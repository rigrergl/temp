# Project Guidelines

## What This Project Makes

Single-file HTML games. All JavaScript and CSS must be inline within one `.html` file. No external frameworks or build tools.

## Allowed Separate Assets

Sprite images (PNG, SVG, etc.) may be included as separate files alongside the HTML when needed. Keep assets minimal.

## Target Platform

- **Primary device:** Mobile phones
- **Primary browser:** Safari (iOS)
- Games must be fully playable via touch controls
- Use `<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, maximum-scale=1.0">` and `<meta name="apple-mobile-web-app-capable" content="yes">`
- Account for iOS safe area insets using `env(safe-area-inset-*)` CSS variables
- Fix the mobile `100vh` bug by calculating viewport height in JS
- Set `touch-action: none` and `position: fixed` on the body to prevent scroll/bounce
- Use `-webkit-touch-callout: none` and `-webkit-user-select: none` to prevent unwanted selection
- Handle `touchstart`/`touchend` events with `preventDefault()` for controls
- Include responsive `@media` queries for small screens, large screens, and landscape orientation
- Prevent double-tap zoom on interactive elements with `-webkit-tap-highlight-color: transparent`

## Code Style

- Vanilla JavaScript only — no libraries, no frameworks
- All game logic in a single `<script>` tag
- All styles in a single `<style>` tag
- Use `requestAnimationFrame` for game loops
- Use HTML5 Canvas for rendering when applicable
- Keep the code readable with clear function names and comments for non-obvious logic
