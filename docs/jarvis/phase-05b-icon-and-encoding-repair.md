# Jarvis Odysseus Phase 05B - Icon and Encoding Repair

## Status

Ready to apply.

## Goal

Fix visible broken icon/encoding artifacts in the current Odysseus UI while keeping every existing feature intact.

This is the first actual UI runtime repair in the premium Jarvis restructure lane.

## Why this phase exists

The current UI shows mojibake-style text artifacts such as:

- `âœ–` where a close icon should appear
- `â–¼` where a dropdown caret should appear
- `â‡’` where an arrow should appear
- `â€”` where an em dash should appear
- `â€œ` / `â€` where smart quotes should appear
- `â—` / `â—‹` where circle icons should appear

These make the app feel broken even when the underlying functionality works.

Phase 05B fixes the visible layer without rewriting Odysseus internals.

## What is added

```text
static/jarvis/jarvis-icon-repair.css
static/jarvis/jarvis-icon-repair.js
```

The JavaScript performs safe text-node replacement for known mojibake artifacts and observes future UI mutations so dynamically opened panels such as Settings also get repaired.

The CSS improves the presentation of small symbol-only controls and keeps repaired glyphs visually consistent with the Jarvis UI shell.

## What is patched

```text
static/index.html
```

The page loads:

```html
<link rel="stylesheet" href="/static/jarvis/jarvis-icon-repair.css" />
<script src="/static/jarvis/jarvis-icon-repair.js"></script>
```

## What this phase does not do

- It does not remove Odysseus features.
- It does not change models.
- It does not change tools.
- It does not change authentication.
- It does not redesign the entire layout yet.
- It does not touch private data or `.env`.

## Design principle

Repair the visible defects first, then continue with the larger premium UI restructure.

This phase is intentionally small because broken icons are embarrassing, but broken features are worse. We fix the embarrassment without creating a disaster.

## Testing checklist

After applying and rebuilding Docker:

- Open `http://localhost:7000`.
- Hard refresh with `Ctrl + F5`.
- Open the chat page.
- Open Settings.
- Check model dropdowns and close buttons.
- Confirm `âœ`, `â–`, `â‡`, `â€”`, and similar artifacts are no longer visible in normal UI controls.
- Confirm chat still works with the local Ollama model.
