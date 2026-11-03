# Release

How a version gets from this repository to the GitHub Releases page.

`Tools/package.sh` does the mechanical part: build, sign, notarise and archive. Its output is
`build/dist/OfficeClock-<version>-macOS-arm64.zip` plus `SHA256SUMS`. It never talks to
GitHub, so you can run it as often as you like. Choosing the version, writing the notes and
publishing are manual, because a published release can't be quietly taken back.

## One-time setup

**A Developer ID Application certificate** in the login keychain. The script picks the first
one that `security find-identity -v -p codesigning` lists. Only the Account Holder can issue
one, at <https://developer.apple.com/account/resources/certificates>. This is not the Apple
Development certificate that `project.yml` uses for everyday builds. Leave that setting
alone: the script re-signs the bundle after the build.

**A notarytool credential** named `officeclock-notary`. It lives in the keychain, so nothing
in the repository holds it. It uses the team's App Store Connect API key (the same key as
other projects, but stored under a profile name of its own):

```sh
xcrun notarytool store-credentials officeclock-notary \
      --key ~/.asc/AuthKey_98ZW2JAUS3.p8 --key-id 98ZW2JAUS3 --issuer <issuer-uuid>
```

The issuer UUID is on the Keys page of App Store Connect (Users and Access → Integrations).

**XcodeGen** (`brew install xcodegen`) and an authenticated `gh` CLI.

## Releasing a version

1. Bump `MARKETING_VERSION` (and `CURRENT_PROJECT_VERSION`) in `project.yml` and commit.
2. Run `Tools/package.sh`. Notarisation usually takes a few minutes. The script stops if
   Gatekeeper doesn't report `source=Notarized Developer ID`.
3. Smoke test on this machine. To see exactly what a downloader will see, unpack the zip
   rather than using `build/package` directly. First unregister the development copy in
   `~/Applications`, because two extensions with the same bundle ID make it unclear which
   one the widget host loads (see [Build-and-Install.md](Build-and-Install.md)).
4. Tag and publish:

   ```sh
   V=1.0
   git tag v$V && git push origin v$V
   gh release create v$V build/dist/OfficeClock-$V-macOS-arm64.zip build/dist/SHA256SUMS \
      --title "Office Clock $V" --notes-file notes.md
   ```

## What the script checks, and why

- **Entitlements survive re-signing.** `codesign --force` drops the existing entitlements,
  so both bundles are signed with their `.entitlements` files passed explicitly. The script
  then confirms that the App Sandbox key is present. The system ignores a widget extension
  that isn't sandboxed, and nothing else reports the failure.
- **Sign inside out.** The `.appex` is signed first, then the `.app` that contains it.
- **Two zips.** The zip sent to Apple is not the one that ships. The ticket is stapled to the
  bundle, so the bundle is zipped again afterwards to carry it. Stapling lets Gatekeeper
  accept the app without a network check.
- **spctl output, not exit code.** On the machine that signed the bundle, spctl accepts a
  Developer ID build even if it was never notarised. Only the output text tells the two apart.
- **arm64 only.** `ARCHS` is set to `arm64` in `project.yml`, and the zip name says so, so an
  Intel Mac user can tell before downloading.
- **Separate build folder.** The script builds into `build/package` and unregisters that copy
  from LaunchServices, so it doesn't interfere with the development install.

## Installing from a release (for users)

1. Unzip and move `OfficeClock.app` to `/Applications`.
2. Open it once. This registers the widget with the system.
3. Right-click the desktop → Edit Widgets… → "Unity Office Clock" (extra large).
