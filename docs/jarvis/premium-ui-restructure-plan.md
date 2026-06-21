# Premium Jarvis UI Restructure Plan

## Product direction

Jarvis should become a universal AI command center.

It should not feel like a generic admin interface or a narrow SAP/HR assistant. SAP, HR, stock research, deployment, and coding can become specialist modes later. The base product should remain universal.

## Target experience

Jarvis should feel like:

- a personal AI operating system;
- a premium command center;
- a calm research and work cockpit;
- a safe tool-using assistant;
- a local-first AI workspace.

It should not feel like:

- an old settings-heavy admin panel;
- a raw developer dashboard;
- a chatbot with too many buttons;
- a glowing game UI with poor readability.

## Visual language

### Foundation

- deep navy/black background;
- subtle radial cyan glow;
- glass panels with restrained blur;
- refined borders;
- soft shadows;
- clear text hierarchy;
- elegant spacing;
- minimal animations.

### Mood

Premium, calm, futuristic, practical.

Not nightclub. Not terminal museum. Not sci-fi for the sake of sci-fi.

## Core layout vision

```text
Top Command Bar
- Jarvis status
- global search / command palette
- active model
- active mode
- system health
- settings

Left Navigation
- Home
- Chat
- Research
- Code
- Files
- Tasks
- Calendar
- Email
- Automation
- Memory
- Tools
- Settings

Main Mission Console
- active chat, research, file, task, or settings workspace

Right Context Rail
- current model
- active mode
- memory used
- tools available
- approvals
- workflow progress
```

## Navigation redesign

### Proposed groups

Command:

- Home
- Chat
- Search
- Research

Work:

- Code
- Files
- Documents
- Notes

Life:

- Tasks
- Calendar
- Email
- Reminders

Intelligence:

- Memory
- Agents
- Tools
- Automations

System:

- Models
- Settings
- Health
- Backup

## Chat console redesign

The chat page should become the Mission Console.

Add:

- improved message cards;
- clear assistant/user distinction;
- model badge;
- active mode badge;
- tool usage timeline placeholder;
- response action row;
- copy/regenerate/details controls;
- better composer layout;
- optional right context rail.

## Composer redesign

Proposed composer controls:

```text
Ask Jarvis anything...
+ Attach | / Command | Mic | Mode | Model | Send
```

The composer should support beginner-friendly command discovery later:

- /research
- /code
- /file
- /task
- /calendar
- /email
- /summarize
- /plan

## Settings redesign

Rename the mental model from Settings to Control Room.

Suggested sections:

- Intelligence Engines;
- AI Defaults;
- Memory Core;
- Tools and Permissions;
- Integrations;
- Communication;
- Appearance;
- Shortcuts;
- Account;
- System Health;
- Backup;
- Danger Zone.

## Model UI redesign

Model entries should show:

- model name;
- provider;
- status;
- best use;
- performance note;
- recommended/default tag.

Example:

```text
llama3.2:3b
Fast local default
Best for everyday chat
Status: Ready
```

## Icon strategy

Avoid fragile text glyphs. Use stable SVG icons.

Recommended approach:

1. Replace broken visible mojibake first.
2. Create a Jarvis icon helper or inline SVG library.
3. Use consistent icons across sidebar, settings, chat, and controls.
4. Avoid icon fonts unless the repo already has a reliable icon dependency.

## Safety UI

Jarvis should visibly communicate safe mode.

Add later:

- pending approvals indicator;
- safe mode badge;
- risky action warnings;
- tool permission summary;
- audit trail link.

## Accessibility and usability

Every UI phase should preserve:

- keyboard navigation;
- readable contrast;
- focus states;
- reduced motion compatibility;
- clear labels;
- responsive behavior.

## Implementation principle

Small pushes. One visible improvement at a time.

Do not attempt a giant UI rewrite until the current frontend structure is fully mapped and the critical icon/encoding issues are fixed.
