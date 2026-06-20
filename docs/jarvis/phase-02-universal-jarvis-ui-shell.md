# Jarvis Odysseus Phase 02 - Universal Jarvis UI Shell

Status: Ready to apply

## Goal

Change the Odysseus user experience into a Jarvis-style universal assistant workspace without locking the assistant into SAP ABAP, HR portal, or any single domain.

## Why this phase exists

Odysseus already provides a strong self-hosted AI workspace foundation. Phase 02 starts the Jarvis transformation at the UI and identity layer while keeping the underlying platform intact.

This phase avoids deep backend rewrites. It adds a non-invasive Jarvis theme and universal assistant overlay first, because changing the visual shell is safer than immediately editing core runtime logic.

## What changes

- Adds a Jarvis theme stylesheet at `static/jarvis/jarvis-theme.css`.
- Adds a small frontend enhancement script at `static/jarvis/jarvis-ux.js`.
- Updates `static/index.html` to load the Jarvis CSS and JS.
- Adds documentation for the universal assistant scope and UI design system.
- Adds verify and commit scripts.

## What does not change

- No database schema changes.
- No authentication changes.
- No email/calendar/file permissions are changed.
- No model provider settings are changed.
- No agent tool execution rules are loosened.

## Universal assistant direction

Jarvis should support all general personal-assistant tasks:

- General Q&A and reasoning
- Coding and debugging
- Web research
- File and document work
- Notes and reminders
- Calendar planning
- Email drafting and summarization
- Automation workflows
- Business workflows
- Learning and tutoring
- Creative ideation
- Project management

SAP ABAP and HR portal support are valuable presets, but they are not the default identity of Jarvis.

## Verification

Run:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\jarvis\verify-phase-02.ps1
```

Expected result:

```text
Phase 02 verification passed.
```

## Runtime validation

After applying and committing, rebuild the Docker service:

```powershell
docker compose up -d --build odysseus
```

Then open:

```text
http://localhost:7000
```

Use `Ctrl + F5` if the old UI is cached.
