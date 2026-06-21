# Jarvis Odysseus Phase 05C - Premium Design Token System

Status: Ready to apply

## Goal

Phase 05C introduces a proper premium Jarvis design token layer so future UI work has a stable visual foundation instead of random one-off CSS patches. Because apparently even futuristic assistants need a design system before they stop looking like a haunted admin panel.

## What this phase adds

- A Jarvis design token stylesheet for colors, spacing, radii, shadows, glass surfaces, typography, animation, and status colors.
- A premium foundation stylesheet that applies those tokens gently to existing Odysseus UI surfaces.
- Documentation explaining how later phases should use the tokens.
- Verification and commit scripts.

## What this phase does not do

- It does not remove Odysseus features.
- It does not change model configuration.
- It does not touch user data.
- It does not change authentication.
- It does not rewrite the frontend.

## Files added

```text
docs/jarvis/phase-05c-premium-design-token-system.md
docs/jarvis/premium-design-token-guide.md
docs/jarvis/jarvis-premium-visual-direction.md
static/jarvis/jarvis-design-tokens.css
static/jarvis/jarvis-premium-foundation.css
scripts/jarvis/verify-phase-05c.ps1
scripts/jarvis/commit-phase-05c.ps1
```

## File patched

```text
static/index.html
```

The patch adds stylesheet links for:

```html
<link rel="stylesheet" href="/static/jarvis/jarvis-design-tokens.css" />
<link rel="stylesheet" href="/static/jarvis/jarvis-premium-foundation.css" />
```

## Success criteria

- Phase 05C verification passes.
- The app still starts normally.
- The UI gains a more premium foundation without breaking chat, settings, model selection, or tools.
- Future phases can build on token names instead of inventing new colors everywhere like a CSS junk drawer.
