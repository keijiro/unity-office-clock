# Troubleshooting

Problems hit during development, how each was diagnosed, and the fix. See
[Platform-Notes.md](Platform-Notes.md) for the underlying WidgetKit behavior.

## Widget turns into a blank gray panel when another app is in front

- **Symptom:** The widget looks fine while the desktop is active. When any app
  window is in front, it becomes a flat light-gray panel with only the tile
  dividers visible.
- **Cause:** In the background, macOS draws desktop widgets in `accented`
  rendering mode, which keeps only opacity and draws everything in one tint.
  The opaque sky gradient became a solid sheet covering everything else.
- **Fix:** When the rendering mode is not `.fullColor`, draw no opaque
  background, and mark the icon images with
  `.widgetAccentedRenderingMode(.desaturated)`.
- **Mistake to avoid:** The first fix assumed `vibrant` mode and changed
  nothing, because the real mode was `accented`. Check the actual mode before
  fixing (see below).

## Finding out which rendering mode the system actually uses

Log from the widget view. `ImageRenderer` previews can't reproduce the
system's tinting.

```swift
import os
private let log = Logger(subsystem: "jp.keijiro.OfficeClock", category: "widget")
// in body:
let _ = log.notice("mode=\(renderingMode.description, privacy: .public)")
```

```sh
/usr/bin/log show --last 2m --predicate 'subsystem == "jp.keijiro.OfficeClock"' --style compact
```

In zsh, `log` is a shell builtin, so call `/usr/bin/log` explicitly.

## The extra-large size doesn't appear in the widget gallery

- **Cause:** Two copies of the extension were registered (`build/` and
  `~/Applications`) with the same build number, and the gallery used a cached
  descriptor from before `.systemExtraLarge` was added.
- **Fix:** Follow the full install sequence in
  [Build-and-Install.md](Build-and-Install.md): bump the build number,
  unregister the `build/` copy, and restart `chronod` and `NotificationCenter`.

## Can't read files the sandboxed app wrote

The app's container (`~/Library/Containers/jp.keijiro.OfficeClock/`) is
protected by macOS privacy controls (TCC), so other processes such as a
terminal can't read it. For this reason the `--render` debug option writes its
PNG to stdout instead of to a file.
