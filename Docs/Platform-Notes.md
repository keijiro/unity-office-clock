# macOS WidgetKit Platform Notes

Platform behavior that shapes the implementation. "Observed" means verified on
the development machine (macOS 27.0.1, Xcode 27.2). "Docs" means taken from
Apple's documentation or the SDK, and not tested separately here.

## Widget sizes

- **Docs:** macOS desktop widgets come in four sizes only: small (1×1), medium
  (2×1), large (2×2) and extra large (4×2). There is no wide single-row size
  such as 3×1 or 4×1. The lock-screen `accessory*` sizes don't apply to the
  desktop.
- **Product decision:** this widget supports extra large only. Smaller layouts
  didn't stand out enough on the desktop and were removed (see
  [Design-Decisions.md](Design-Decisions.md)).

## Rendering modes on the desktop

- **Observed:** The system renders each timeline entry twice up front, once in
  `fullColor` (desktop active) and once in `accented` (another app in front).
  Both renders appear in the log right after a reload.
- **Observed:** `accented` mode ignores color and keeps only opacity. Any opaque
  view becomes a solid tinted area. Images are drawn as a flat tint unless they
  use `.widgetAccentedRenderingMode(...)`.
- **Docs:** `.widgetAccentedRenderingMode` needs macOS 15. This is why the
  deployment target is 15.0.
- **Not observed:** `vibrant` mode (luminance becomes opacity) never showed up
  on the desktop here. The current color artwork keeps its natural luminance and alpha in this mode;
  unlike the original white-backed line art, it is not inverted.
- **Unverified (general knowledge, not tested here):** In System Settings →
  Desktop & Dock, "Widget style" set to "Full-color" keeps widgets in color in
  the background. The default "Automatic" lets them dim. App code can't
  override this setting.

## Timeline

- The digital clock is driven by one timeline entry per minute, not by
  `Text(date, style:)`. The built-in styles either don't tick (`.time`) or
  count up and down (`.timer`), and the per-office state (sky, icon) changes
  with time anyway.

## Offline rendering previews

`--accented` and `--vibrant` use a preview-only environment override and grayscale artwork. They exercise the reduced layout without enabling WidgetKit's system compositing pass inside ImageRenderer (which can omit images or text). These are layout approximations, not exact previews of desktop tinting. Production widgets continue to use the real `widgetRenderingMode` and `.widgetAccentedRenderingMode(.desaturated)`.
