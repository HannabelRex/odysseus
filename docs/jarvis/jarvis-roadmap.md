# Jarvis Odysseus Roadmap

## Vision

Build a personal Jarvis-like AI assistant on top of Odysseus.

Jarvis should help Satheesh with:

- daily assistant conversations
- local and free-first AI model usage
- coding help
- SAP ABAP learning and work support
- HR portal planning and implementation support
- research and report creation
- file and document management
- reminders and personal task tracking
- email and calendar assistance
- safe automation workflows

Jarvis should be useful before it is fancy. Voice, automation, and multi-agent behavior should be added only after the base assistant is stable and safe.

## Core principles

1. Free-first tools
   - Prefer free, open-source, local, or generous free-tier tools.
   - Use premium tools only when there is clear value.

2. Local-first development
   - Run locally first on Windows.
   - Use Docker where it simplifies setup.
   - Avoid cloud deployment until the local system is stable.

3. Safety-first execution
   - Read-only actions can be easier.
   - Write actions need checks.
   - Sensitive actions need explicit approval.

4. Beginner-friendly implementation
   - Every phase must include clear commands.
   - Every phase must explain why changes are being made.
   - Avoid hidden magic.

5. Phase-based delivery
   - Build in small safe increments.
   - Commit and push after every completed phase.
   - Do not mix multiple unrelated features in one phase.

## Major milestones

| Milestone | Result |
| --- | --- |
| M0 | Odysseus runs locally and is pushed to Satheesh's GitHub fork |
| M1 | Jarvis project tracking and safety baseline exists |
| M2 | Jarvis identity and presets are documented/configured |
| M3 | Local Ollama model setup is configured and tested |
| M4 | Safety rules are reflected in assistant behavior and workflows |
| M5 | Voice interaction is added or improved |
| M6 | Jarvis workflows are added |
| M7 | SAP, HR portal, and business workflow support is added |
| M8 | Email, calendar, and contact integrations are configured safely |
| M9 | Windows convenience launcher scripts are added |
| M10 | Backup, hardening, and deployment safety are completed |

## Current baseline

Completed:

- Phase O0: Odysseus install and smoke test
- Git origin set to Satheesh's repo
- Upstream push disabled
- Jarvis base branch created and pushed

Current active branch:

jarvis/base-integration

## Next immediate work

Phase 01:

- Add roadmap
- Add phase plan
- Add free-first stack policy
- Add safety policy
- Add local setup notes
- Add verification and commit helper scripts
