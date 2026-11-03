# Activity label artwork

Generated individually with the built-in imagegen tool (`transparent_background: true`). Style reference: `Art/Labels/reference.png`, copied from `~/Desktop/label-concept.png`.

Full-resolution transparent masters: `Art/Labels/<name>.png`. App and widget assets: `Shared/Assets.xcassets/label_<name>.imageset/` (480px wide, alpha preserved). `OfficeTile` overlays the lettering on the bottom of the character illustration; spoken activity names remain in the accessibility label. Both image layers use the same reduced-color rendering behavior.

## Shared prompt

```text
Use case: illustration-story
Asset type: transparent manga hand-lettered activity word art for a small macOS widget.
Input image: style reference only, its text must be replaced by the requested exact text.
Primary request: Generate one standalone word-art label matching the reference's bold manga/comic hand lettering: creamy white letter faces, thick very dark plum ink outlines, colored outer keyline, subtle colored halftone lower extrusion. Hand-drawn expressive silhouette, extremely legible at small size.
Composition: wide horizontal single line, tight composition with small safe transparent margins, entire lettering and small accents fully within canvas. Label fills the canvas width. No character, no panel, no rectangular background, no extra words.
Background: genuinely transparent alpha including holes in letters. No checkerboard baked in.
```

## Per-image prompt additions

### sleep

```text
Text (verbatim): "Sleeping"
Mood and variation: Sleepy, soft rounded slightly drooping letters, lavender and pale blue accent, two tiny sleep bubbles.
```

### wake

```text
Text (verbatim): "Waking up"
Mood and variation: Fresh awakening, buoyant rounded letters, sunrise peach and yellow accents, tiny awakening rays.
```

### breakfast

```text
Text (verbatim): "Breakfast"
Mood and variation: Cheerful morning, bouncy bold letters, warm honey orange and cream accents, small sparkle.
```

### sleepy_pc

```text
Text (verbatim): "Warming up"
Mood and variation: Drowsily gathering energy, gently uneven rounded letters, muted coral and lavender accents, small curved motion ticks.
```

### focused_pc

```text
Text (verbatim): "Focused"
Mood and variation: Energetic concentration, forward leaning bold letters, pink halftone lower shadow and vivid yellow outer border, sharp emphasis rays, very close to reference.
```

### lunch

```text
Text (verbatim): "Lunch"
Mood and variation: Happy midday pause, plump playful letters, fresh green and golden yellow accents, tiny joyful rays.
```

### meeting

```text
Text (verbatim): "Meetings"
Mood and variation: Lively discussion, rhythmic upright bold letters, cyan blue accents, small paired conversational motion marks.
```

### coffee_break

```text
Text (verbatim): "Coffee Break"
Mood and variation: Warm relaxed pause, flowing rounded letters, mint green and warm cream accents, tiny steam curls.
```

### leaving

```text
Text (verbatim): "Signing off"
Mood and variation: Upbeat finished-work feeling, dynamic sweeping letters, coral orange and golden yellow accents, small departing motion ticks.
```

### dinner

```text
Text (verbatim): "Dinner"
Mood and variation: Cozy satisfying evening, rounded bold letters, amber and warm coral accents, tiny warm sparkles.
```

### relaxing

```text
Text (verbatim): "Off duty"
Mood and variation: Laid-back unwinding, loose gently reclining rounded letters, turquoise and soft pink accents, a couple relaxed curved ticks.
```

### bedtime

```text
Text (verbatim): "Bedtime"
Mood and variation: Quiet settling down for the night, soft rounded letters, periwinkle and lavender accents, two tiny stars.
```

### weekend

```text
Text (verbatim): "Reading"
Mood and variation: Peaceful absorbed reading, gentle rounded hand lettering, sage green and pale gold accents, one quiet small sparkle.
```


## Coffee Break wording correction

Built-in imagegen edit of the previous coffee_break label, with `transparent_background: true`. The current wording is `Coffee Break`; the tea leaf accent is removed.

```text
Use case: text-localization. Input image is the edit target and exact lettering style reference. Replace the wording with exactly "Coffee Break" (capital C, capital B, two words separated by a clearly visible word space). Spell C-o-f-f-e-e B-r-e-a-k correctly. Preserve the same flowing bold rounded manga hand-lettering style, creamy white letter faces, thick very dark plum outlines, mint-green outer keyline, warm orange halftone lower extrusion, small cream steam curls and little yellow emphasis rays. Remove the tea leaf decoration so it no longer implies tea. Single wide horizontal line, readable at small widget size, all letters and accents fully visible, tight framing with small safe transparent margins. Genuine transparent alpha background including letter holes, no opaque backdrop, no checkerboard, no character, no additional text or watermark.
```
