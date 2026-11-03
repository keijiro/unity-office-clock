#!/bin/bash
#
# From source to a zip that can be handed to somebody: build/dist holds the archive and its
# checksum. It stops there. Choosing the version, writing the notes and creating the GitHub
# release are the steps in Docs/Release.md, so nothing below talks to GitHub and this can be
# run as often as is useful. Only the notarisation leaves the machine.
#
# An app downloaded from the internet is quarantined, and since macOS 15 an unnotarised one
# can only be opened from System Settings. So the bundle is signed with a Developer ID,
# hardened, timestamped, notarised by Apple and stapled. Stapling lets Gatekeeper accept it
# without a network check.
#
# Usage:  Tools/package.sh
#
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BUILD="$ROOT/build/package"
DIST="$ROOT/build/dist"
NOTARY_PROFILE="officeclock-notary"

cd "$ROOT"

say() { printf '\n\033[1m==> %s\033[0m\n' "$*"; }
die() { printf '\033[31merror:\033[0m %s\n' "$*" >&2; exit 1; }

VERSION=$(awk -F'"' '/MARKETING_VERSION/ {print $2}' project.yml)
BUILD_NUMBER=$(awk -F'"' '/CURRENT_PROJECT_VERSION/ {print $2}' project.yml)
[ -n "$VERSION" ] || die "no MARKETING_VERSION in project.yml"

say "Office Clock $VERSION ($BUILD_NUMBER)"

# Use the Developer ID Application certificate, not the App Store distribution one: this
# script signs the bundle itself.
IDENTITY=$(security find-identity -v -p codesigning \
           | awk -F'"' '/Developer ID Application/ {print $2; exit}')
[ -n "$IDENTITY" ] || die "no Developer ID Application identity in the keychain — see Docs/Release.md"

# The notarisation credentials are a keychain item, not a file, so the script never holds them.
xcrun notarytool history --keychain-profile "$NOTARY_PROFILE" >/dev/null 2>&1 \
    || die "no notarytool profile '$NOTARY_PROFILE' — see Docs/Release.md"

command -v xcodegen >/dev/null || die "xcodegen not found (brew install xcodegen)"

echo "  identity: $IDENTITY"

# ---------------------------------------------------------------- build

# Built in its own derived data folder so that it never touches the development copy in
# build/Build, which is registered with LaunchServices on this machine.
say "building"
xcodegen generate --quiet
rm -rf "$BUILD"
xcodebuild -project OfficeClock.xcodeproj -scheme OfficeClock -configuration Release \
           -derivedDataPath "$BUILD" -quiet build

APP="$BUILD/Build/Products/Release/OfficeClock.app"
APPEX="$APP/Contents/PlugIns/OfficeClockWidget.appex"
[ -d "$APPEX" ] || die "the widget extension is missing from $APP"

# The build signs the bundle with the local Apple Development certificate, and the
# LaunchServices registration that comes with it is not wanted here.
pluginkit -r "$APPEX" 2>/dev/null || true
/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister \
    -u "$APP" 2>/dev/null || true

# ---------------------------------------------------------------- sign

# Sign inside out, and pass the entitlements explicitly: --force drops the existing ones,
# and the system ignores a widget extension that is not sandboxed.
say "signing"
codesign --force --timestamp --options runtime --sign "$IDENTITY" \
         --entitlements Widget/OfficeClockWidget.entitlements "$APPEX"
codesign --force --timestamp --options runtime --sign "$IDENTITY" \
         --entitlements App/OfficeClock.entitlements "$APP"
codesign --verify --deep --strict --verbose=2 "$APP"

for bundle in "$APPEX" "$APP"; do
    codesign -d --entitlements - --xml "$bundle" 2>/dev/null | grep -q "com.apple.security.app-sandbox" \
        || die "$(basename "$bundle") lost its sandbox entitlement"
done

# ---------------------------------------------------------------- notarise

# The zip sent to Apple is not the one that ships. The ticket is stapled to the bundle, so
# the bundle has to be zipped again afterwards to carry it.
say "notarising"
ditto -c -k --sequesterRsrc --keepParent "$APP" "$BUILD/notarize.zip"
xcrun notarytool submit "$BUILD/notarize.zip" --keychain-profile "$NOTARY_PROFILE" --wait
rm -f "$BUILD/notarize.zip"

xcrun stapler staple "$APP"
xcrun stapler validate "$APP"

# Check spctl's output, not its exit code. On the machine that signed the bundle spctl
# accepts a Developer ID build even if it was never notarised; only the output text tells
# the two apart.
ASSESS=$(spctl --assess --type exec --verbose=4 "$APP" 2>&1)
echo "$ASSESS"
grep -q "source=Notarized Developer ID" <<<"$ASSESS" \
    || die "Gatekeeper does not see this as notarised — a download would be warned about"

# ---------------------------------------------------------------- archive

# Named for the chip: the build is arm64 only, and an Intel Mac user can see that from the
# file name before downloading.
say "archiving"
rm -rf "$DIST"; mkdir -p "$DIST"
ZIP="$DIST/OfficeClock-$VERSION-macOS-arm64.zip"
ditto -c -k --sequesterRsrc --keepParent "$APP" "$ZIP"
(cd "$DIST" && shasum -a 256 ./*.zip | sed 's|\./||' > SHA256SUMS && cat SHA256SUMS)

say "ready in build/dist — Docs/Release.md takes it from here"
ls -lh "$DIST"
