# Jarvis UI Design System

## Design direction

The Jarvis UI should feel like a focused command center, not a generic admin panel that wandered into an AI conference.

## Principles

1. Universal first
   - The UI should support many task types, not one business domain.

2. Calm but futuristic
   - Use dark glass panels, clean contrast, and subtle glow effects.

3. Safety visible
   - Risky actions should be clearly marked before approval.

4. Fast command flow
   - Chat, tools, tasks, research, files, and automation should feel reachable.

5. Local/free-first
   - The UI should not push premium providers as the only path.

## Visual language

| Element | Direction |
|---|---|
| Background | Dark command-center gradient |
| Accent | Cyan/blue Jarvis glow |
| Panels | Glass/frosted surfaces |
| Borders | Subtle luminous borders |
| Typography | Clean monospace/sans blend |
| Status | Universal mode indicator |
| Buttons | Compact, high-contrast, command-like |

## Phase 02 implementation notes

This phase applies a non-invasive overlay approach:

- CSS variables override Odysseus theme tokens.
- A JS enhancer adds a `jarvis-universal-ui` class to the body.
- A small universal mode status panel is injected into the page.
- Odysseus branding visible in the browser title and exact UI text nodes is adjusted to Jarvis.

This approach minimizes merge conflicts with upstream Odysseus updates.
