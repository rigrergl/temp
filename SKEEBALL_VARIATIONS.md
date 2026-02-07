# Skee-Ball Game - Agent Variation Instructions

Use this document to spin up multiple agents, each producing a different variation of the skee-ball game. Each variation modifies `skeeball.html` (or creates a new file) with distinct gameplay, visuals, or mechanics.

---

## Base Game Summary

- **File:** `skeeball.html` (single self-contained HTML file, no external dependencies)
- **Mechanics:** Swipe/drag upward to roll a ball up a lane toward scoring rings (10, 20, 30, 40, 50, 100 points)
- **Rules:** 9 balls per game, high score saved to localStorage
- **Tech:** Canvas 2D rendering, Web Audio API for sounds, touch + mouse input
- **Mobile:** Fully responsive, touch-friendly, `user-scalable=no`

---

## Shareable Link Format

After pushing to a branch, the game is viewable in any mobile browser (Safari, Chrome) via:

```
https://htmlpreview.github.io/?https://raw.githubusercontent.com/rigrergl/temp/<branch-name>/skeeball.html
```

Alternatively, use GitHub Pages or raw.githack.com:

```
https://raw.githack.com/rigrergl/temp/<branch-name>/skeeball.html
```

> **Note:** `raw.githack.com` serves correct MIME types and works more reliably for HTML preview in Safari/mobile. `htmlpreview.github.io` also works but can occasionally have caching issues.

---

## Variation Prompts

Copy any of the prompts below and give them to a separate agent. Each agent should:

1. Read the existing `skeeball.html` as a starting point
2. Make the described modifications
3. Save to the same file (`skeeball.html`) or a new file if specified
4. Keep everything in a single HTML file (all CSS/JS inline)
5. Ensure mobile touch controls still work
6. Commit and push to the branch

---

### Variation 1: Neon Cyberpunk Theme

**Output file:** `skeeball-cyberpunk.html`

```
Modify the skee-ball game to have a full cyberpunk aesthetic. Changes:
- Replace the color scheme with cyan, hot pink, electric purple, and black
- Add a grid-line animated background (like Tron)
- Add scanline overlay effect on the entire canvas
- Make the ball leave a longer neon trail with glow effects
- Add a CRT screen curvature effect using CSS
- Change the font to a more futuristic style (use system fonts: "Lucida Console" or "Consolas")
- Add particle explosions on every score with cyberpunk colors
- Scoring text should glitch/flicker briefly when points are awarded
- Keep all gameplay mechanics identical
```

---

### Variation 2: Realistic Physics & 3D Perspective

**Output file:** `skeeball-3d.html`

```
Modify the skee-ball game to feel more physically realistic. Changes:
- Draw the lane in a 3D perspective view (narrower at top, wider at bottom) using canvas transforms
- Add ball shadow that changes size based on "height" of the ball
- Implement a proper arc trajectory - ball should visually rise off the ramp and arc into the scoring zone
- Add ball spin animation (rotating texture/pattern on the ball)
- Ball speed affects trajectory arc height - faster swipes = higher arc
- Add a subtle bounce animation when ball lands in a ring
- Add lane texture (wood grain pattern drawn with canvas lines)
- Sound effects should have reverb/echo feel (longer decay times)
- Keep the same scoring zones and rules
```

---

### Variation 3: Power-Ups & Multi-Ball

**Output file:** `skeeball-powerups.html`

```
Modify the skee-ball game to add power-up mechanics. Changes:
- Every 3rd ball, a random power-up appears on the lane that the ball can collect:
  - MULTI-BALL: Splits into 3 balls, all score independently
  - MAGNET: Ball curves toward the 100-point center ring
  - DOUBLE: Next score is worth 2x points
  - BIG BALL: Ball radius doubles, easier to hit center rings
  - EXTRA BALL: Get one extra ball added to remaining count
- Power-ups appear as floating, rotating icons on the lane
- Power-up has a glowing aura and spins slowly
- When collected, flash the screen border with the power-up color
- Show active power-up indicator in the UI
- Add a power-up history showing last 3 power-ups collected
- Keep base scoring and 9-ball rules the same
```

---

### Variation 4: Multiplayer Hot-Seat

**Output file:** `skeeball-multiplayer.html`

```
Modify the skee-ball game to support 2-player hot-seat mode. Changes:
- Add a start screen with "1 PLAYER" and "2 PLAYER" buttons
- In 2-player mode, players alternate turns (each rolls one ball, then it switches)
- Split the score display to show both players: P1 on left, P2 on right
- Active player's score should glow/pulse
- Different ball colors per player (P1 = blue/cyan, P2 = red/orange)
- Show "PLAYER 1's TURN" / "PLAYER 2's TURN" between throws
- At game end, show both scores and declare a winner
- Add a crown icon next to the winner's score
- Winner gets a special particle celebration effect
- Each player gets 9 balls (18 total throws in a game)
```

---

### Variation 5: Progressive Difficulty / Arcade Mode

**Output file:** `skeeball-arcade.html`

```
Modify the skee-ball game to have progressive rounds with increasing difficulty. Changes:
- Game is split into rounds (Round 1, 2, 3...) with 5 balls each
- Each round, the scoring rings get smaller (shrink by 10% per round)
- After Round 3, add moving obstacles on the lane (bumpers that bounce the ball)
- After Round 5, the scoring rings slowly rotate
- Add a target score per round - if you don't reach it, game over
  - Round 1: 100 points, Round 2: 150, Round 3: 200, +75 per round after
- Show round number and target prominently
- Between rounds, show a "ROUND COMPLETE" screen with bonus points for exceeding target
- Bonus: leftover points above target carry over as bonus multiplied by 1.5x
- Add a "combo" system: consecutive scores of 30+ build a combo multiplier (1x, 1.5x, 2x, 2.5x, 3x max)
- Combo resets if you score under 20 or miss entirely
- Keep the neon arcade aesthetic
```

---

### Variation 6: Retro 8-Bit Pixel Art

**Output file:** `skeeball-retro.html`

```
Modify the skee-ball game to have a full retro 8-bit pixel art style. Changes:
- Render everything with a chunky pixel aesthetic (use canvas imageSmoothing = false, scale up from small buffer)
- Replace smooth shapes with pixel-art equivalents (square ball, blocky rings)
- Use a limited color palette (NES-style: ~24 colors)
- Replace Web Audio synth sounds with chiptune-style sounds (square waves, very short, retro beeps)
- Add a pixel font for all text (render text as pixel blocks or use a blocky system font)
- Scoring animation: numbers pop up in pixel style and float upward
- Add a simple pixel-art frame around the play area (like an arcade cabinet bezel)
- Screen transitions should be instant cuts, not fades
- Add a blinking "INSERT COIN" prompt on the title/game-over screen
- Keep all gameplay mechanics identical
```

---

### Variation 7: Zen / Relaxation Mode

**Output file:** `skeeball-zen.html`

```
Modify the skee-ball game to be a calming, zen experience. Changes:
- Remove ball limit - infinite balls, no game over
- Remove score pressure - still track score but no high score comparison
- Replace neon colors with soft pastels (lavender, mint, soft coral, cream)
- Background: slowly shifting gradient (aurora borealis effect)
- Ball leaves a gentle watercolor-like trail that fades slowly
- Scoring rings pulse softly like breathing
- Replace sharp sounds with gentle chimes and soft tones (sine waves with long decay)
- Add ambient background drone (very low volume, warm pad sound)
- When ball scores, petals/leaves float outward instead of sharp particles
- Add a "session time" display instead of balls remaining
- Smooth, slow animations everywhere - nothing jarring
- Text uses a softer, rounded font style
```

---

## How to Use These Prompts

1. **Single agent, one variation:**
   ```
   Read skeeball.html, then apply Variation N and save to the specified output file.
   Commit and push to the branch.
   ```

2. **Multiple agents in parallel:**
   Assign each agent a different variation number. They write to separate files so there are no conflicts.

3. **Iterating on one variation:**
   Give an agent the base prompt plus feedback:
   ```
   Apply Variation 3 (Power-Ups) to skeeball.html.
   Additional feedback: Make the magnet power-up stronger
   and add a visual indicator showing the magnetic pull.
   ```

4. **Combining variations:**
   ```
   Start with skeeball.html. Combine Variation 1 (Cyberpunk Theme)
   with Variation 5 (Arcade Mode). Prioritize the cyberpunk visuals
   with the progressive difficulty mechanics.
   ```

---

## Testing Checklist

After any variation is created, verify:

- [ ] Opens correctly in a mobile browser (Safari iOS, Chrome Android)
- [ ] Touch swipe-up launches the ball
- [ ] Ball physics feel reasonable (reaches scoring zone on medium swipe)
- [ ] Scoring works correctly for all ring values
- [ ] Score display updates in real time
- [ ] Sound effects play (may need first tap to unlock audio context)
- [ ] Game over / reset flow works
- [ ] No console errors
- [ ] File is fully self-contained (no external dependencies)
- [ ] Page has `<meta name="viewport">` for proper mobile scaling
