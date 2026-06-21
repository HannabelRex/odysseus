# Jarvis Odysseus Phase 05E - Chat Mission Console Redesign

Status: Ready to apply

## Purpose

Phase 05E begins the visible premium redesign of the central chat workspace. Previous phases fixed the foundation: project tracking, safety rules, Jarvis identity, local models, icon repair, design tokens, and the navigation shell. This phase focuses on the main interaction surface: the chat console.

## Design goal

Transform the chat area from a basic panel into a premium Jarvis mission console while preserving every Odysseus feature.

The experience should feel like:

- a universal AI command center
- local-first and safe-by-default
- elegant, dark, glassy, and readable
- beginner-friendly without hiding advanced power
- focused on the active mission, not raw controls everywhere

## Scope

This phase adds:

- `static/jarvis/jarvis-chat-console.css`
- `static/jarvis/jarvis-chat-console.js`
- chat mission context rail
- premium input/composer treatment
- improved chat panel surfaces
- model/safety/context hints
- documentation and verification scripts

## Non-goals

This phase does not:

- remove or rename existing Odysseus features
- change model settings
- change backend routes
- change database schema
- change email/calendar/tool behavior
- modify `.env`
- enable any unsafe automation

## Why this is a separate phase

The chat screen is the heart of Jarvis. Reworking it safely means adding a reversible enhancement layer first instead of rewriting the entire frontend in one violent act of optimism.

## Verification

Run:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\jarvis\verify-phase-05e.ps1
```

Then rebuild:

```powershell
docker compose up -d --build odysseus
```

Open:

```text
http://localhost:7000
```

Hard refresh with `Ctrl + F5`.
