# Jarvis UI Audit Findings

## Audit source

Repo: https://github.com/HannabelRex/odysseus
Branch: jarvis/base-integration
Date: 2026-06-21

This audit is based on the current Odysseus/Jarvis UI behavior observed locally and the latest repo state available on the Jarvis integration branch.

## Current strengths

Odysseus is a powerful base platform. We should preserve its feature depth.

Current feature areas include:

- chat;
- local and API model endpoints;
- agent/chat mode;
- tools;
- Brain and memory;
- skills;
- email;
- calendar;
- compare;
- cookbook;
- deep research;
- gallery;
- library/documents;
- notes;
- tasks;
- themes;
- settings;
- admin tools;
- logs;
- backup and danger-zone operations.

The UI already exposes a large amount of functionality. The problem is not lack of capability. The problem is visual hierarchy and polish.

## Current pain points

### 1. Broken glyphs and encoding artifacts

Observed examples include visible mojibake such as:

- `â–¼`
- `âœ–`
- `â‡’`
- `â€”`
- `â€œ`
- `â€`

Impact:

- makes the interface feel broken;
- damages trust in the product;
- makes controls unclear;
- prevents the UI from feeling premium.

Priority: Critical.

### 2. Sidebar is powerful but visually crowded

The sidebar exposes many important areas, but the grouping is not yet user-friendly.

Current areas should be reorganized into clearer groups:

- Command;
- Work;
- Life;
- Intelligence;
- System.

Priority: High.

### 3. Chat console lacks premium command-center structure

Current chat works, but visually it still feels like a standard chat panel.

Problems:

- model labels are small and not self-explanatory;
- composer controls are scattered;
- agent/chat toggle is not beginner-friendly;
- message action icons are not clear enough;
- empty space is not used to support context or status.

Priority: High.

### 4. Settings is too technical for a personal assistant

Settings currently exposes many raw technical concepts, which is necessary for advanced users but overwhelming for beginners.

The layout should become a premium control room:

- Intelligence Engines;
- Memory Core;
- Tools and Permissions;
- Integrations;
- Interface;
- System Health;
- Backup and Safety.

Priority: High.

### 5. Model management needs clearer intent

The local Ollama endpoint works, but model management should be more understandable.

Recommended labels:

- Fast Local Default;
- General Reasoning;
- Coding Specialist;
- Embedding Model;
- Fallback.

Priority: Medium.

### 6. Jarvis identity exists but needs stronger product expression

The current Jarvis skin is a start. The next stage should move from "theme overlay" to "premium assistant operating system."

Priority: High.

## Design risks

### Risk 1: Overwriting working Odysseus behavior

Mitigation:

- avoid removing existing IDs/classes;
- prefer additive CSS and JS first;
- inspect affected files before every code phase;
- keep each commit small.

### Risk 2: Breaking settings or model flows

Mitigation:

- do settings redesign after icon repair and base layout tokens;
- verify model add/probe/chat flow after every UI change.

### Risk 3: Making the UI pretty but harder to use

Mitigation:

- preserve existing navigation paths;
- add progressive disclosure;
- group advanced options;
- keep beginner-friendly labels.

## UI quality goals

Jarvis should feel:

- premium;
- calm;
- intelligent;
- local-first;
- secure;
- powerful but approachable;
- universal, not limited to one work domain.

## Immediate fix order

1. Icon and encoding repair.
2. Jarvis design tokens.
3. Sidebar and top command redesign.
4. Chat console redesign.
5. Settings control room redesign.
6. Responsive and polish pass.
