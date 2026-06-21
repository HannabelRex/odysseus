# Jarvis Icon and Encoding Repair Notes

## Problem

The current Odysseus frontend contains visible mojibake artifacts in several UI labels and controls. These are usually caused by UTF-8 text being interpreted with the wrong encoding at some point in the rendering or source pipeline.

Examples observed in the UI/repo include:

```text
âœ–
â–¼
â‡’
â€”
â€œ
â€
â—
â—‹
```

## Chosen fix for Phase 05B

Phase 05B uses a small client-side repair overlay:

```text
static/jarvis/jarvis-icon-repair.js
```

This approach is intentionally conservative:

- It does not rewrite the huge `static/index.html` manually.
- It does not remove existing features.
- It works for UI that is dynamically inserted after page load.
- It is easy to remove later if the upstream source is cleaned.

## Why not a full rewrite immediately?

The current frontend is feature-rich and consolidated. A direct rewrite risks breaking chat, models, settings, tools, and integrations all at once.

The better route is:

```text
05B - Repair visible glyph/icon defects
05C - Add design tokens
05D - Redesign sidebar/top bar
05E - Redesign chat console
05F - Redesign settings/control room
05G - Polish/responsive/accessibility
```

## Replacement table

The repair script maps common corrupted sequences to readable symbols:

| Broken text | Repaired text |
|---|---|
| `âœ–` | `×` |
| `âœ“` | `✓` |
| `â–¼` | `▾` |
| `â–¸` | `▸` |
| `â‡’` | `→` |
| `â†’` | `→` |
| `â€”` | `—` |
| `â€“` | `–` |
| `â€œ` | `“` |
| `â€` | `”` |
| `â€˜` | `‘` |
| `â€™` | `’` |
| `â‰¤` | `≤` |
| `â‰¥` | `≥` |
| `â—` | `●` |
| `â—‹` | `○` |

## Later improvement

In a later phase, fragile text-symbol icons should be replaced with inline SVG icons or a stable icon component layer.

Recommended future direction:

```text
Lucide-style inline SVG icons
```

That avoids icon-font dependencies and prevents encoding garbage from appearing in premium UI controls. Tiny miracle: icons that display as icons.
