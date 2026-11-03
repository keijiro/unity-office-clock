# Art Pipeline

Activity captions remain separate transparent manga lettering; see [Label-Art.md](Label-Art.md).

## Character-first workflow

Generated with built-in imagegen, not the fallback CLI. First create `Art/character-design.png`, then use that sheet as the reference for each of the 13 independent activity generations. Preserve identity and drawing style, while varying posture, expression, outfit and essential furniture to make actions readable at widget size.

The design sheet has a white background. Every activity uses `transparent_background: true`. Reject painted backgrounds, background glow and multiple panels.

`Art/<name>.png` contains the full-resolution master. `Shared/Assets.xcassets/cat_<name>.imageset/<name>.png` contains the alpha-preserving 480px runtime copy. Asset names and labels are unchanged.

## Design sheet prompt

Reference input: the previous `Art/focused_pc.png` (before this regeneration), for identity and style only. Tool option: `transparent_background: false`.

```text
Use case: stylized-concept. Asset type: master character design reference sheet for an illustrated clock. Input image: character identity and drawing style reference only. Create a clean character model sheet of this same cute dark plum-purple anthropomorphic cat: large lime green eyes, white muzzle, cheek tufts, white paws and feet, fluffy swept forelock, large pink inner ears with white tufts, exactly one long fluffy purple tail with white tip. Preserve polished anime dark outlines and simple soft cel shading. Show full body front and side/three-quarter views in orange hoodie with black drawstrings and dark shorts, plus three expressive head studies (determined, yawning, delighted), plus a small full-body pale lavender button-up pajama outfit view. Consistent compact cute proportions. White background, orderly spacious layout, no text, no lettering, no watermark. This is a character reference sheet, not an activity scene. Entire bodies and tails visible.
```

## Final activity prompts

Reference input for every prompt: `Art/character-design.png`. Tool option: `transparent_background: true`.

### sleep

```text
Use case: illustration-story. Asset type: single transparent activity illustration for a small clock widget. Input image: master character design sheet, identity and style reference ONLY, do not reproduce the sheet layout or its poses. Draw exactly one of this same cute dark plum cat, lime green eyes, swept fluffy forelock, pink ears with white tufts, white muzzle and paws, exactly one fluffy white-tipped tail. Match polished dark anime outlines and simple cel shading throughout including props and food. Create a fresh expressive action composition. Square canvas, large readable character, entire ears and all essential props inside canvas with 5 percent margin. Isolated character with essential furniture only, genuine transparent background outside silhouettes, no room, floor, backdrop, card, text, letters, logos, watermarks or white sticker border. Scene: Sleeping deeply in a small wooden bed, lying horizontally on their side, head resting on a pillow, eyes completely closed and mouth relaxed. Wear lavender button-up pajamas from reference, with upper body visible above a soft purple blanket tucked over lower body. Clear bed headboard and short legs, gentle diagonal view. No hoodie. Bed and sleeping pose immediately recognizable.
```

### wake

```text
Use case: illustration-story. Asset type: single transparent activity illustration for a small clock widget. Input image: master character design sheet, identity and style reference ONLY, do not reproduce the sheet layout or its poses. Draw exactly one of this same cute dark plum cat, lime green eyes, swept fluffy forelock, pink ears with white tufts, white muzzle and paws, exactly one fluffy white-tipped tail. Match polished dark anime outlines and simple cel shading throughout including props and food. Create a fresh expressive action composition. Square canvas, large readable character, entire ears and all essential props inside canvas with 5 percent margin. Isolated character with essential furniture only, genuine transparent background outside silhouettes, no room, floor, backdrop, card, text, letters, logos, watermarks or white sticker border. Scene: Just waking up: seated on edge of a small bed with feet dangling, lavender pajamas, both arms stretched high and wide overhead, back arched, huge yawning mouth and shut eyes, rumpled forelock. Blanket pushed aside. Tall open V-shaped silhouette. No hoodie.
```

### breakfast

```text
Use case: illustration-story. Asset type: single transparent activity illustration for a small clock widget. Input image: master character design sheet, identity and style reference ONLY, do not reproduce the sheet layout or its poses. Draw exactly one of this same cute dark plum cat, lime green eyes, swept fluffy forelock, pink ears with white tufts, white muzzle and paws, exactly one fluffy white-tipped tail. Match polished dark anime outlines and simple cel shading throughout including props and food. Create a fresh expressive action composition. Square canvas, large readable character, entire ears and all essential props inside canvas with 5 percent margin. Isolated character with essential furniture only, genuine transparent background outside silhouettes, no room, floor, backdrop, card, text, letters, logos, watermarks or white sticker border. Scene: A bright energetic breakfast: standing in orange hoodie and dark shorts, holding a slice of buttered toast in one paw near an open smiling mouth, other paw pouring milk from a small plain pitcher into a cereal bowl on a tiny round breakfast table. Wide awake green eyes, ears perked. Body turned three-quarter toward viewer, upbeat upright posture. Food very simple flat cartoon shapes. Deliver ONE single isolated transparent cutout. No colored haze, glow, ground shadow or background.
```

### sleepy_pc

```text
Use case: illustration-story. Asset type: single transparent activity illustration for a small clock widget. Input image: master character design sheet, identity and style reference ONLY, do not reproduce the sheet layout or its poses. Draw exactly one of this same cute dark plum cat, lime green eyes, swept fluffy forelock, pink ears with white tufts, white muzzle and paws, exactly one fluffy white-tipped tail. Match polished dark anime outlines and simple cel shading throughout including props and food. Create a fresh expressive action composition. Square canvas, large readable character, entire ears and all essential props inside canvas with 5 percent margin. Isolated character with essential furniture only, genuine transparent background outside silhouettes, no room, floor, backdrop, card, text, letters, logos, watermarks or white sticker border. Scene: Struggling to stay awake at a laptop on a compact desk: slumped deeply sideways in a chair, cheek squashed against one paw propped on desk, drooping eyelids with unfocused green eyes, small slack mouth, other paw limply over keyboard. Orange hoodie and dark shorts. Head hanging low, ears droop, utterly exhausted, visibly different from alert typing. One coffee mug nearby. Deliver ONE single isolated transparent cutout, not multiple panels. Transparent empty space surrounds all furniture.
```

### focused_pc

```text
Use case: illustration-story. Asset type: single transparent activity illustration for a small clock widget. Input image: master character design sheet, identity and style reference ONLY, do not reproduce the sheet layout or its poses. Draw exactly one of this same cute dark plum cat, lime green eyes, swept fluffy forelock, pink ears with white tufts, white muzzle and paws, exactly one fluffy white-tipped tail. Match polished dark anime outlines and simple cel shading throughout including props and food. Create a fresh expressive action composition. Square canvas, large readable character, entire ears and all essential props inside canvas with 5 percent margin. Isolated character with essential furniture only, genuine transparent background outside silhouettes, no room, floor, backdrop, card, text, letters, logos, watermarks or white sticker border. Scene: Working intensely at a laptop on a compact desk, leaning sharply forward, side three-quarter view, narrowed determined green eyes fixed on screen, mouth closed, both paws actively typing, ears alert, orange hoodie and dark shorts. Laptop screen faces cat. Compact chair, no coffee mug. Strong forward diagonal posture conveys concentration. Deliver ONE single isolated transparent cutout, not multiple panels. Transparent empty space surrounds all furniture.
```

### lunch

```text
Use case: illustration-story. Asset type: single transparent activity illustration for a small clock widget. Input image: master character design sheet, identity and style reference ONLY, do not reproduce the sheet layout or its poses. Draw exactly one of this same cute dark plum cat, lime green eyes, swept fluffy forelock, pink ears with white tufts, white muzzle and paws, exactly one fluffy white-tipped tail. Match polished dark anime outlines and simple cel shading throughout including props and food. Create a fresh expressive action composition. Square canvas, large readable character, entire ears and all essential props inside canvas with 5 percent margin. Isolated character with essential furniture only, genuine transparent background outside silhouettes, no room, floor, backdrop, card, text, letters, logos, watermarks or white sticker border. Scene: Casual lunch break, sitting cross-legged on a small folded picnic cloth, leaning into a big triangular sandwich held in both paws and taking a big happy bite, cheeks puffed and delighted eyes curved shut. Orange hoodie and dark shorts. Small open lunchbox at their knee, sandwich has simple lettuce tomato cheese shapes. No table, cup, computer or chair. Clearly low compact cross-legged silhouette. Deliver ONE single isolated transparent cutout. No colored haze, glow, ground shadow or background.
```

### meeting

```text
Use case: illustration-story. Asset type: single transparent activity illustration for a small clock widget. Input image: master character design sheet, identity and style reference ONLY, do not reproduce the sheet layout or its poses. Draw exactly one of this same cute dark plum cat, lime green eyes, swept fluffy forelock, pink ears with white tufts, white muzzle and paws, exactly one fluffy white-tipped tail. Match polished dark anime outlines and simple cel shading throughout including props and food. Create a fresh expressive action composition. Square canvas, large readable character, entire ears and all essential props inside canvas with 5 percent margin. Isolated character with essential furniture only, genuine transparent background outside silhouettes, no room, floor, backdrop, card, text, letters, logos, watermarks or white sticker border. Scene: Energetically presenting at a meeting: standing full body beside a small freestanding presentation board showing only three simple colored bars and an upward line, no text. Orange hoodie and dark shorts, headset microphone, one arm confidently pointing to the board, other paw open toward audience, mouth open mid-explanation, eyebrows lifted. Wide assertive stance, full body visible. No laptop or desk. Deliver ONE single isolated transparent cutout, not multiple panels. Transparent empty space surrounds all furniture.
```

### coffee_break

```text
Use case: illustration-story. Asset type: single transparent activity illustration for a small clock widget. Input image: master character design sheet, identity and style reference ONLY, do not reproduce the sheet layout or its poses. Draw exactly one of this same cute dark plum cat, lime green eyes, swept fluffy forelock, pink ears with white tufts, white muzzle and paws, exactly one fluffy white-tipped tail. Match polished dark anime outlines and simple cel shading throughout including props and food. Create a fresh expressive action composition. Square canvas, large readable character, entire ears and all essential props inside canvas with 5 percent margin. Isolated character with essential furniture only, genuine transparent background outside silhouettes, no room, floor, backdrop, card, text, letters, logos, watermarks or white sticker border. Scene: Reclining comfortably in a compact armchair, legs crossed, one arm draped over armrest and other paw lifting a steaming coffee mug to nose, eyes closed with a contented smile. Orange hoodie and dark shorts. Backward diagonal pose. Only cat, chair and mug. Deliver ONE single isolated transparent cutout. No colored haze, glow, ground shadow or background.
```

### leaving

```text
Use case: illustration-story. Asset type: single transparent activity illustration for a small clock widget. Input image: master character design sheet, identity and style reference ONLY, do not reproduce the sheet layout or its poses. Draw exactly one of this same cute dark plum cat, lime green eyes, swept fluffy forelock, pink ears with white tufts, white muzzle and paws, exactly one fluffy white-tipped tail. Match polished dark anime outlines and simple cel shading throughout including props and food. Create a fresh expressive action composition. Square canvas, large readable character, entire ears and all essential props inside canvas with 5 percent margin. Isolated character with essential furniture only, genuine transparent background outside silhouettes, no room, floor, backdrop, card, text, letters, logos, watermarks or white sticker border. Scene: Full-body brisk walking stride, one foot forward and other raised behind, head turned back over shoulder, big cheerful smile, one paw waving high and other holding purple backpack strap. Orange hoodie and dark shorts, tail trailing. Only cat and backpack. Deliver ONE single isolated transparent cutout. No colored haze, glow, ground shadow or background.
```

### dinner

```text
Use case: illustration-story. Asset type: single transparent activity illustration for a small clock widget. Input image: master character design sheet, identity and style reference ONLY, do not reproduce the sheet layout or its poses. Draw exactly one of this same cute dark plum cat, lime green eyes, swept fluffy forelock, pink ears with white tufts, white muzzle and paws, exactly one fluffy white-tipped tail. Match polished dark anime outlines and simple cel shading throughout including props and food. Create a fresh expressive action composition. Square canvas, large readable character, entire ears and all essential props inside canvas with 5 percent margin. Isolated character with essential furniture only, genuine transparent background outside silhouettes, no room, floor, backdrop, card, text, letters, logos, watermarks or white sticker border. Scene: Enjoying steak dinner at a small dining table, orange hoodie and dark shorts, seated straight with a pleased expectant grin, a fork in one raised paw and a dinner knife in the other poised above a plate of steak and simple vegetables. Front three-quarter view, elbows spread, steak obvious with only three broad grill stripes. Simple candle in holder at table edge suggests evening. All food simple outlined cartoon cel shading, no realistic texture. Deliver ONE single isolated transparent cutout. No colored haze, glow, ground shadow or background.
```

### relaxing

```text
Use case: illustration-story. Asset type: single transparent activity illustration for a small clock widget. Input image: master character design sheet, identity and style reference ONLY, do not reproduce the sheet layout or its poses. Draw exactly one of this same cute dark plum cat, lime green eyes, swept fluffy forelock, pink ears with white tufts, white muzzle and paws, exactly one fluffy white-tipped tail. Match polished dark anime outlines and simple cel shading throughout including props and food. Create a fresh expressive action composition. Square canvas, large readable character, entire ears and all essential props inside canvas with 5 percent margin. Isolated character with essential furniture only, genuine transparent background outside silhouettes, no room, floor, backdrop, card, text, letters, logos, watermarks or white sticker border. Scene: Excited gaming, sprawling diagonally across a compact beanbag, one leg stretched toward foreground and other bent, leaning back, both paws grip purple game controller, wide intense green eyes and exuberant open grin. Orange hoodie and dark shorts. Only cat, beanbag and controller. Deliver ONE single isolated transparent cutout. No colored haze, glow, ground shadow or background.
```

### bedtime

```text
Use case: illustration-story. Asset type: single transparent activity illustration for a small clock widget. Input image: master character design sheet, identity and style reference ONLY, do not reproduce the sheet layout or its poses. Draw exactly one of this same cute dark plum cat, lime green eyes, swept fluffy forelock, pink ears with white tufts, white muzzle and paws, exactly one fluffy white-tipped tail. Match polished dark anime outlines and simple cel shading throughout including props and food. Create a fresh expressive action composition. Square canvas, large readable character, entire ears and all essential props inside canvas with 5 percent margin. Isolated character with essential furniture only, genuine transparent background outside silhouettes, no room, floor, backdrop, card, text, letters, logos, watermarks or white sticker border. Scene: Getting ready for bed, standing full body in lavender pajamas and slippers, cradling a large pillow under one arm while rubbing one drooping eye with the other paw, head tilted and mouth making a little yawn. Slouched sleepy standing posture. No bed, no hoodie.
```

### weekend

```text
Use case: illustration-story. Asset type: single transparent activity illustration for a small clock widget. Input image: master character design sheet, identity and style reference ONLY, do not reproduce the sheet layout or its poses. Draw exactly one of this same cute dark plum cat, lime green eyes, swept fluffy forelock, pink ears with white tufts, white muzzle and paws, exactly one fluffy white-tipped tail. Match polished dark anime outlines and simple cel shading throughout including props and food. Create a fresh expressive action composition. Square canvas, large readable character, entire ears and all essential props inside canvas with 5 percent margin. Isolated character with essential furniture only, genuine transparent background outside silhouettes, no room, floor, backdrop, card, text, letters, logos, watermarks or white sticker border. Scene: Reading quietly, lounging sideways in a compact armchair, legs curled over one armrest, open purple book on raised knees held in both paws, thoughtful green eyes looking down at book and subtle serene smile. Cream T-shirt and dark shorts, tail draped beside chair. Side view, relaxed horizontal silhouette. Only cat, chair and book. Deliver ONE single isolated transparent cutout. No colored haze, glow, ground shadow or background.
```

## Import and validation

Resize with `sips -Z 480 Art/<name>.png --out Shared/Assets.xcassets/cat_<name>.imageset/<name>.png`. Preserve alpha; never flatten onto a background. Check all 13 names, runtime dimensions, transparent pixels, complete silhouettes, and readable expressions and props on light and dark backgrounds at small sizes.

## Follow-up adjustments (current)

These built-in imagegen edits supersede the corresponding initial scene prompts above. Input: the activity master generated above as the edit target. Tool option: `transparent_background: true`. Keep the same filenames and regenerate the 480px runtime copies.

### meeting

```text
Use case: precise-object-edit. Input image is the edit target. Preserve this exact cat identity, dark plum fur, white markings, green eyes, hair, orange hoodie, dark shorts, single tail, polished anime outlines, simple cel shading, square framing and genuine transparent alpha background. Keep everything unchanged except the requested changes. No background, floor, glow, text or watermark. Replace the standing presentation scene with a friendly web video meeting: cat seated comfortably at a compact desk with straight vertical legs, wearing its headset with boom microphone, looking toward an open laptop, one paw raised in a gentle conversational open-hand gesture and the other resting beside the keyboard. Soft relaxed eyebrows and rounded friendly eyes, small warm smile while speaking, no intense or assertive expression. Remove presentation board and chart entirely. Show laptop from rear three-quarter view, screen facing cat; no interface on back of laptop. Full chair and feet visible. Preserve character and illustration style, but change pose and furniture as required.
```

### dinner

```text
Use case: precise-object-edit. Input image is the edit target. Preserve this exact cat identity, dark plum fur, white markings, green eyes, hair, orange hoodie, dark shorts, single tail, polished anime outlines, simple cel shading, square framing and genuine transparent alpha background. Keep everything unchanged except the requested changes. No background, floor, glow, text or watermark. Remove the candle, flame and entire candle holder from the dining table. Fill their former location with the plain continuous wooden tabletop, leaving that area empty. Preserve all other content, especially face, pose, plate, food, utensils, chair and table shape.
```

### sleepy_pc

```text
Use case: precise-object-edit. Input image is the edit target. Preserve this exact cat identity, dark plum fur, white markings, green eyes, hair, orange hoodie, dark shorts, single tail, polished anime outlines, simple cel shading, square framing and genuine transparent alpha background. Keep everything unchanged except the requested changes. No background, floor, glow, text or watermark. Move the coffee mug and its coaster from the far side/back of the laptop to the near edge of the desk next to the cat's free paw, within easy reach, on the cat's side of the laptop. Ensure mug rests fully on tabletop with clear space and does not overlap the keyboard or paw. Remove mug from its original location, leaving only one mug. Preserve drowsy expression, slumped posture, laptop, chair and desk.
```

### relaxing

```text
Use case: precise-object-edit. Input image is the edit target. Preserve this exact cat identity, dark plum fur, white markings, green eyes, hair, orange hoodie, dark shorts, single tail, polished anime outlines, simple cel shading, square framing and genuine transparent alpha background. Keep everything unchanged except the requested changes. No background, floor, glow, text or watermark. Change only the facial expression to visibly joyful relaxed gaming: remove the sharply inward-slanting angry-looking eyebrows and intense stare. Use softly lifted relaxed brows, bright rounded happy green eyes and a warm broad laughing smile with lifted cheeks. The character is having fun, not fierce or competitive. Preserve sprawling pose, hands, controller, beanbag, ears, tail and framing.
```

### focused_pc

```text
Use case: precise-object-edit. Input image is the edit target. Preserve this exact cat identity, dark plum fur, white markings, green eyes, hair, orange hoodie, dark shorts, single tail, polished anime outlines, simple cel shading, square framing and genuine transparent alpha background. Keep everything unchanged except the requested changes. No background, floor, glow, text or watermark. Change the face to calm pleasant concentration: remove furrowed sharply angled brows, narrowed glare and frown; use relaxed neutral brows, attentive softly rounded green eyes looking at laptop and a small gentle closed-mouth smile. Preserve the forward typing posture. Replace the desk's slanted Z-shaped support frame with an ordinary simple rectangular desk supported by straight vertical legs that descend directly downward from tabletop corners, parallel to the image's vertical axis, no diagonal braces or slanted supports. Keep tabletop, chair, laptop and other content unchanged.
```

## Second follow-up adjustments (current)

These built-in imagegen edits supersede the previous edits for sleepy_pc and relaxing. Input: the previous activity master. Tool option: `transparent_background: true`.

### sleepy_pc

```text
Use case: precise-object-edit. Input image is the edit target. Preserve exact cat identity, plum fur, white markings, hair, orange hoodie, dark shorts, single tail, polished anime outlines and cel shading, square framing and genuine transparent alpha background. No background, floor, text, watermark or glow. Correct only the desk construction. It must be a conventional rectangular desk with exactly FOUR straight vertical legs, one attached beneath EACH of the four tabletop corners. Make all four legs visibly identifiable, including the currently missing front-left leg beneath the tabletop near the cat's free paw. Place that front-left leg in front of the cat's shins where physically appropriate, with correct occlusion. Keep all four legs vertical, parallel, distinct and properly supporting the tabletop, with no diagonal supports. Remove the low horizontal rectangular foot frame to make the four individual legs unambiguous. Preserve the tabletop, laptop, mug at the cat's hand, sleepy face, slumped pose, chair, feet and tail; change only necessary occlusion for the fourth desk leg.
```

### relaxing

```text
Use case: precise-object-edit. Input image is the edit target. Preserve exact cat identity, plum fur, white markings, hair, orange hoodie, dark shorts, single tail, polished anime outlines and cel shading, square framing and genuine transparent alpha background. No background, floor, text, watermark or glow. Change only leg pose and facial expression. The cat is still comfortably seated leaning back in the same purple beanbag and holding the same game controller. Bring BOTH thighs and knees close together, knees touching, with BOTH lower legs resting together and both feet side by side in a natural relaxed seated position. No spread legs, no raised knee to the side, no foot sole thrust toward the viewer. Change the face to a warm sincere beaming smile: both eyes softly closed in symmetrical upward happy crescents, relaxed brows, cheeks gently lifted, a small symmetrical closed-mouth U-shaped smile. No open mouth, tongue, teeth, smirk, sly expression or sideways grin. Preserve upper body, hands, controller, ears, tail and style; adjust beanbag contour only as needed.
```

## Sleep tail correction (current)

Built-in imagegen edit of the preceding sleep master, with `transparent_background: true`. This supersedes the visible tail in the initial sleep illustration.

```text
Use case: precise-object-edit. Input image is the edit target. Make exactly one localized correction: completely hide the cat's tail beneath the purple blanket. Remove the entire visible purple-and-white fluffy tail sticking up through the blanket on the right. Restore a continuous natural smooth blanket surface and outer silhouette in that area, with simple cel-shaded fabric folds. Where the tail extended above the correct blanket contour, restore genuinely transparent background. No visible tail, no fur tuft, no hole or slit in the bedding, and no new bulge. Preserve everything else exactly: sleeping cat's face, head, ears, paws, lavender pajamas, pose, pillow, wooden bed, blanket colors, framing, polished anime outlines and soft cel shading. Preserve genuine transparent alpha everywhere outside the cat and bed. No background, floor, glow, text or watermark.
```
