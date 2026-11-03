# Design Decisions

Requirements and the reasons behind choices that the code itself doesn't
explain.

## Original requirements (from the project owner)

- A world clock for Unity's main offices: Copenhagen, Tokyo, US West Coast
  (San Francisco) and US East Coast (New York).
- Digital time display.
- A background that roughly shows day and night. Seasonal changes in daylight
  are deliberately ignored.
- An icon showing what people are probably doing at that hour, drawn as an
  anthropomorphic cat based on `character.png`. The owner's examples:
  - 7–8: waking up
  - 8–9: breakfast
  - 9–10: sleepy at the computer
  - 11–12: working seriously
  - The workday ends at 17:00; 17–18 is saying goodbye and leaving.
- Images are made with the `/gemini-image` skill.

The slots the owner didn't specify (afternoon, evening, night) and the weekend
schedule were filled in by the implementer. Change them freely.

## Current design

- Extra large (4×2) only, with the original office order.
- Transparent color character illustrations follow `Art/character-design.png`: plum fur, green eyes, white markings, and soft anime shading. Clothing, posture, expression and essential furniture vary by activity; sleep/wake/bedtime use lavender pajamas, and weekend reading uses a cream T-shirt. The orange hoodie remains the daytime outfit.
- One continuous sky blends the four offices' local-time colors. No individual tile backgrounds, white image cards, borders or separators.
- Each column places city, weekday and local time above the character, with a quiet activity caption below it.
- Reduced rendering modes omit the sky and shadows; alpha-preserving desaturated artwork remains visible. Sun/moon symbols retain the day/night cue.
- Date offsets are relative to the viewer's own calendar date.
- The existing weekday/weekend schedule is retained; weekend artwork now shows reading.
