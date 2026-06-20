# Jarvis Odysseus Phase 01 - Project Tracking and Safety Baseline

Status: Ready to apply

Project folder:
P:\Projects\odysseus

Target branch:
jarvis/base-integration

## Purpose

Phase 01 creates the control documents for the Jarvis customization work inside the Odysseus repo.

This phase intentionally avoids runtime code changes. The goal is to establish the project roadmap, safety policy, free-first technology direction, local setup notes, and future phase plan before modifying the application.

## Why this phase exists

Odysseus already contains many powerful assistant features. Before we customize it into Jarvis, we need clear guardrails:

- which phases we will implement
- which tools should be free-first
- which actions need approval
- how local development should be run
- how we track progress
- how we avoid leaking secrets
- when we are allowed to touch runtime code

This avoids turning the repo into a pile of enthusiastic edits that nobody understands later. Software already creates enough archaeology jobs.

## What this phase adds

- Jarvis roadmap
- Detailed implementation phase plan
- Free-first stack policy
- Safety and permissions policy
- Local setup notes
- Verification script
- Commit helper script

## What this phase does not do

- Does not change app runtime code
- Does not change Docker setup
- Does not add model providers
- Does not add voice features
- Does not add new agents yet
- Does not modify secrets or environment values

## Success criteria

Phase 01 is complete when:

- docs/jarvis/jarvis-roadmap.md exists
- docs/jarvis/phase-plan.md exists
- docs/jarvis/free-first-stack.md exists
- docs/jarvis/safety-policy.md exists
- docs/jarvis/local-setup-notes.md exists
- scripts/jarvis/verify-phase-01.ps1 exists
- scripts/jarvis/commit-phase-01.ps1 exists
- verify script passes
- changes are committed and pushed to origin/jarvis/base-integration

## Recommended commit message

docs: add Jarvis project tracking and safety baseline

## Next phase

Phase 02 - Jarvis Identity and Assistant Presets

Phase 02 will define how Odysseus should behave as Satheesh's Jarvis assistant, including persona, default operating rules, workflow focus, local/free model preference, and safe action behavior.
