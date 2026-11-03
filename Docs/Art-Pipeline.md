# Art Pipeline

The current artwork uses `new-concept.png` as the character and style reference. All 13 activity illustrations were generated individually with the built-in imagegen tool, requesting a genuinely transparent background.

`Art/<name>.png` contains the full-resolution master. `Shared/Assets.xcassets/cat_<name>.imageset/` contains a 480px copy with alpha preserved. Never convert these assets to RGB or add a background. The UI draws the silhouettes directly on a continuous sky.

## Reproduction prompts

Each scene uses the following template, replacing only the Scene sentence. Reference input: `new-concept.png`. Tool option: `transparent_background: true`.

```
Use case: illustration-story. Asset: transparent macOS clock character illustration. Reference image is the exact character and art style guide. Draw this same charming dark plum-purple anthropomorphic cat, white muzzle, white paws and tail tip, large green eyes, swept fluffy hair, pink inner ears, orange hoodie with black drawstrings. Preserve the reference's polished anime ink outlines, soft cel shading and proportions faithfully. Scene: focused happily typing on a dark purple laptop, with a small coffee mug, simplified compact desk vignette. Composition: one centered character, square canvas, entire ears, tail and props visible with a little clear margin; large readable face; no rectangular scene or card. Genuine transparent background everywhere outside the character and essential props. No background, floor, lettering, watermark, sticker outline, or extra characters.
```

- **focused_pc**: focused happily typing on a dark purple laptop, with a small coffee mug, simplified compact desk vignette.

Inspect the generated image for character consistency, complete ears and tail, and genuine alpha before importing. Resize using an alpha-preserving image tool (for example `sips -Z 480`) and check the widget at daytime, nighttime and in reduced rendering modes.

## Scene prompts

- **sleep**: sleeping peacefully curled up hugging a purple pillow, eyes closed, orange hoodie, fluffy tail wrapped around body, no bed or desk.
- **wake**: waking up stretching both arms with a little yawn, seated on a small purple cushion, orange hoodie, no bed or desk.
- **breakfast**: enjoying breakfast holding toast and a warm mug, orange hoodie, simple small plate of toast, no large table.
- **sleepy_pc**: drowsily working at a dark purple laptop, half closed green eyes, one paw holding coffee, orange hoodie, minimal desk props.
- **lunch**: happily eating a triangular lettuce, tomato and cheese sandwich held in both paws, orange hoodie, compact seated pose, minimal props.
- **meeting**: cheerful video meeting wearing a headset and gesturing with one paw beside a dark purple laptop, orange hoodie.
- **coffee_break**: taking a relaxing tea break, holding a steaming mug with both paws, eyes contentedly closed, orange hoodie, small cookie beside them.
- **leaving**: walking home waving goodbye with one paw, wearing orange hoodie and a purple backpack, full body and tail visible.
- **dinner**: enjoying a grilled steak dinner with vegetables, holding a fork with a bite of steak, orange hoodie, happy expression, minimal props.
- **relaxing**: relaxing playing a video game with a purple controller held in both paws, seated on a small purple cushion, orange hoodie, excited green eyes.
- **bedtime**: sleepily hugging a large purple pillow, eyes half closed yawning, orange hoodie, full tail visible, no bed.
- **weekend**: enjoying a day off reading an open book seated comfortably with tail curled around a small purple cushion, orange hoodie, relaxed green eyes.

Final corrections: reading has exactly one tail curled around the feet; the back of the meeting laptop has a simple white cat emblem, not a screen interface.

## Meal illustration revision

Built-in imagegen precise-object edits of the previous lunch/dinner masters, with `transparent_background: true`.

- **lunch**: Replace the ramen, bowl and chopsticks with a clearly recognizable triangular sandwich of sliced bread, lettuce, tomato and cheese. The cat is happily eating the sandwich, holding it in both paws near its mouth. No bowl, noodles or chopsticks remain.
- **dinner**: Replace the pasta dinner with a grilled beef steak on the same plate, with clear sear marks and a small side of vegetables. The raised fork holds a bite-sized piece of steak near the mouth instead of pasta. No noodles or pasta remain. Keep the mug.

Shared constraints: preserve character identity, dark purple fur, white markings, green eyes, orange hoodie, expression, ears, single tail, anime outlines and soft cel shading, framing, and genuine alpha. Change paws only as needed; no added text or background.

## Food style unification (current)

Built-in imagegen, transparent_background: true. These prompts supersede the earlier meal edits; food uses simple cel shading without realistic texture.

### lunch

Use case: precise-object-edit. Input is the edit target. Redraw ALL food and food details in exactly the same simple anime/cartoon visual language as this cat's paws and hoodie: clean dark plum outlines of matching weight, smooth large flat color shapes, just one simple cel-shadow shape per surface. Food must look drawn by the same character artist, not pasted-in realistic food. No texture, stippling, pores, grain, speckles, realistic material rendering, intricate highlights, fine lines or microdetail. Preserve the cat identity, face, hair, fur, pose, orange hoodie, tail, composition, framing, utensils and other props. Genuine transparent background and alpha. No text or new objects. Keep the cat eating a triangular sandwich. Simplify bread to a completely smooth cream triangle and a plain tan crust, NO bread holes or dots. Fillings are just a few broad lettuce waves, one plain red tomato shape, one flat yellow cheese shape, each with at most one shadow tone. No seeds, veins, crumbs, gloss or tiny details. Make the entire sandwich as graphically simple as the hoodie.

### dinner

Use case: precise-object-edit. Input is the edit target. Redraw ALL food and food details in exactly the same simple anime/cartoon visual language as this cat's paws and hoodie: clean dark plum outlines of matching weight, smooth large flat color shapes, just one simple cel-shadow shape per surface. Food must look drawn by the same character artist, not pasted-in realistic food. No texture, stippling, pores, grain, speckles, realistic material rendering, intricate highlights, fine lines or microdetail. Preserve the cat identity, face, hair, fur, pose, orange hoodie, tail, composition, framing, utensils and other props. Genuine transparent background and alpha. No text or new objects. Keep the cat eating steak, with a steak bite on the fork and steak on the plate. Draw the steak as a simple rounded brown cartoon shape with only THREE broad dark diagonal grill stripes and one flat shadow. The fork bite is a plain brown/pink block with a clean outline and single cel shadow. Simplify side vegetables to a few smooth green/orange shapes. Remove herb sprigs, tiny florets, seeds, marbling, meat fibers, grain, shiny spots and all realistic food texture. Keep the plate and mug.
