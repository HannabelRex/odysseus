# Phase 05A - Premium UI Audit and Restructure Blueprint

Status: Ready to apply
Branch: jarvis/base-integration
Repo: https://github.com/HannabelRex/odysseus

## Purpose

Phase 05A starts the Jarvis premium UI restructure without touching runtime behavior yet.

The goal is to push UI improvements one controlled change at a time:

1. Audit the current UI problems.
2. Define the premium Jarvis visual direction.
3. Map existing Odysseus features into a better Jarvis information architecture.
4. Define implementation phases that keep all existing features intact.
5. Prepare the team to fix visual and icon issues before deeper layout restructuring.

## Why this is docs-first

The current UI has strong features, but the presentation is uneven:

- broken glyphs and mojibake appear in some controls;
- settings and model management feel like legacy admin pages;
- the chat workspace has weak hierarchy;
- sidebar navigation is functional but not premium;
- Jarvis identity is visually present, but the product does not yet feel like a complete command center.

A full rewrite would be risky because Odysseus already contains many working areas: chat, models, tools, Brain, email, calendar, notes, tasks, research, library, gallery, settings, and admin controls.

So we will preserve features and restructure the UI in small commits.

## Phase 05A output

This phase adds:

- a UI audit;
- a premium restructure plan;
- a Jarvis interface map;
- an incremental implementation phase plan;
- verification and commit scripts.

## Non-goals

This phase does not:

- rewrite `static/index.html`;
- modify `static/style.css`;
- change chat behavior;
- change model providers;
- change auth or permissions;
- remove Odysseus features;
- add premium paid services.

## Success criteria

Phase 05A is complete when:

- all planning files exist;
- all planning files describe a universal Jarvis assistant, not a SAP-only or HR-only assistant;
- the next UI phases are clearly sequenced;
- the branch remains clean after commit and push.

## Next recommended phase

Phase 05B - Icon and Encoding Repair.

This should be the first actual UI code change. It should fix broken characters and replace fragile glyphs with stable icon handling before we redesign larger layouts.
