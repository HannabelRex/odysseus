# Navigation Shell Test Checklist

Use this checklist after applying Phase 05D and rebuilding Docker.

## Browser setup

1. Start/rebuild Odysseus:

```powershell
cd P:\Projects\odysseus
docker compose up -d --build odysseus
```

2. Open:

```text
http://localhost:7000
```

3. Hard refresh:

```text
Ctrl + F5
```

## Visual checks

- [ ] Top Jarvis command bar appears.
- [ ] Sidebar has premium glass/nav styling.
- [ ] Sidebar items remain readable.
- [ ] Active/hover states are visible.
- [ ] UI no longer feels like a plain legacy admin panel.
- [ ] No new broken glyphs appear.

## Functional checks

- [ ] New Chat still works.
- [ ] Existing chat still opens.
- [ ] Model selector still opens.
- [ ] Local Ollama chat still works.
- [ ] Settings opens.
- [ ] Added Models page opens.
- [ ] Tools/Brain/Calendar/etc. navigation still works.
- [ ] No modal is blocked by the command bar.

## Rollback

If the UI shell causes problems, remove these two references from `static/index.html`:

```html
<link rel="stylesheet" href="/static/jarvis/jarvis-navigation-shell.css" />
<script src="/static/jarvis/jarvis-navigation-shell.js"></script>
```

Then rebuild Docker.
