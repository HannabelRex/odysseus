# Jarvis Odysseus Phase Plan

This document tracks the implementation phases for building Jarvis on top of Odysseus.

## Phase O0 - Install and Smoke Test

Status: Completed

Goal:
Get Odysseus running locally with Docker and confirm login works.

Completed:

- Docker build completed
- Odysseus container started
- SearXNG container healthy
- ChromaDB container started
- ntfy container started
- Login successful
- Phase 00 document committed and pushed

## Phase O1 - Project Tracking and Safety Baseline

Status: Current

Goal:
Create the Jarvis planning and safety documentation baseline.

Files:

- docs/jarvis/jarvis-roadmap.md
- docs/jarvis/phase-plan.md
- docs/jarvis/free-first-stack.md
- docs/jarvis/safety-policy.md
- docs/jarvis/local-setup-notes.md
- scripts/jarvis/verify-phase-01.ps1
- scripts/jarvis/commit-phase-01.ps1

Success:

- Verification script passes
- Changes committed and pushed to origin/jarvis/base-integration

## Phase O2 - Jarvis Identity and Assistant Presets

Goal:
Define Jarvis behavior, operating rules, and assistant presets.

Expected work:

- Create Jarvis operating instructions
- Define Satheesh-specific workflow focus
- Define beginner-friendly response style
- Define free-first model preference
- Define approval-first sensitive action policy
- Add preset documentation or config if supported by Odysseus structure

## Phase O3 - Free-First Local Model Setup

Goal:
Configure local AI model support through Ollama.

Expected work:

- Confirm Ollama is installed
- Pull starter models
- Document model choices
- Configure Odysseus OpenAI-compatible provider endpoint
- Test local chat

Recommended models:

- llama3.1:8b for general chat
- qwen2.5-coder:7b for coding help

Docker-to-host Ollama endpoint:

http://host.docker.internal:11434/v1

## Phase O4 - Jarvis Safety Profile

Goal:
Implement and document Jarvis action safety rules.

Expected work:

- Define risk levels
- Define tool permissions
- Define approval flow
- Document risky actions
- Add assistant policy text
- Later: connect safety checks to actual tool behavior if Odysseus supports it cleanly

## Phase O5 - Voice Layer

Goal:
Add or improve speech-to-text and text-to-speech interaction.

Free-first options:

- faster-whisper for local speech-to-text
- edge-tts or pyttsx3 for text-to-speech
- openWakeWord later if wake word is needed

Premium optional later:

- OpenAI speech-to-text
- OpenAI text-to-speech
- ElevenLabs

## Phase O6 - Jarvis Workflows

Goal:
Add personal workflows.

Examples:

- morning briefing
- HR portal phase planning
- SAP ABAP helper
- research report creation
- unread email summary
- calendar planning
- Git commit helper
- deployment checklist generator

## Phase O7 - Business, SAP, and HR Portal Agent

Goal:
Add Satheesh-specific work support.

Focus areas:

- SAP ABAP support
- HR portal implementation planning
- release notes
- regression checklists
- deployment validation
- SQL migration review
- PowerShell command creation

## Phase O8 - Email, Calendar, and Contacts

Goal:
Configure real assistant integrations safely.

Rules:

- Read emails only after configuration
- Draft replies before sending
- Require approval before sending mail
- Require approval before creating or changing calendar events
- Require contact disambiguation when names are unclear

## Phase O9 - Windows Launcher Pack

Goal:
Make Jarvis easy to start, stop, update, backup, and open.

Expected scripts:

- start-jarvis.ps1
- stop-jarvis.ps1
- update-jarvis.ps1
- backup-jarvis-data.ps1
- open-jarvis.ps1

## Phase O10 - Hardening, Backup, and Deployment Safety

Goal:
Make Jarvis safer for serious use.

Expected work:

- backup procedure
- restore procedure
- secret handling checklist
- local-only default
- external exposure warning
- audit checklist
- production hardening notes
