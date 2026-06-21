# Sidebar and Top Command Bar Design

## Concept

The Jarvis navigation shell turns Odysseus into a universal command center. The goal is to make the app feel like a premium personal AI operating system rather than a conventional admin panel.

## Layout concept

```text
Top command bar
- Jarvis status
- active model hint
- local runtime/safe mode indicator
- quick mission label

Left sidebar
- premium glass surface
- clearer active states
- command-center navigation feel
- preserved original features and links

Main workspace
- unchanged in this phase
- receives subtle spacing and visual harmony only
```

## Design language

- Deep navy/black backgrounds
- Cyan/violet accents
- Glass panels
- Reduced clutter
- Soft active-state glow
- Small status chips instead of noisy labels

## Navigation groups for later phases

The existing sidebar items will eventually be mentally grouped as:

### Command

- Home / New Chat
- Search
- Chats
- Compare

### Work

- Tools
- Brain / Memory
- Deep Research
- Library
- Notes

### Life

- Email
- Calendar
- Tasks
- Reminders

### System

- Models
- Theme
- Settings
- Users / Admin

Phase 05D does not fully reorder the DOM yet. It prepares styling and a safer shell. Reordering and full component treatment should happen after functional testing.

## Command bar behavior

The top command bar is inserted by `jarvis-navigation-shell.js` and contains:

- Jarvis label
- universal workspace label
- model hint extracted from visible text where possible
- local safe-mode indicator

This is intentionally informational. It does not block clicks, change app state, or call APIs.
