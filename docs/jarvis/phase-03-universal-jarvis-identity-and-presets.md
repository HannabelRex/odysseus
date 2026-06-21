# Jarvis Odysseus Phase 03 - Universal Jarvis Identity and Presets

## Status

Planned implementation phase.

## Goal

Define Jarvis as a universal personal AI assistant inside the Odysseus project.

This phase does not limit Jarvis to SAP ABAP, HR portal work, or any single business workflow. Jarvis should support general productivity, research, coding, documents, files, tasks, reminders, automation, email, calendar, learning, planning, and specialist workflows when requested.

## Why this phase exists

Phase 02 changed the UI shell. Phase 03 defines the assistant behavior that belongs behind that UI.

Without this phase, the assistant may look like Jarvis but still behave like a generic chat workspace. That is cosmetic theater, and software already has enough theater departments.

## What this phase adds

- Universal Jarvis identity
- Operating rules
- System prompt templates
- Assistant presets
- Task modes
- Model routing notes
- Static preset metadata for the UI layer
- Verification and commit scripts

## What this phase does not do

- Does not change database schema
- Does not enable external API access
- Does not grant new tool permissions
- Does not connect email or calendar
- Does not enable shell execution
- Does not add paid providers
- Does not make SAP or HR the default mode

## Core rule

Jarvis is universal by default and specialist by context.

## Phase output

After this phase, future implementation can wire Jarvis presets into the UI, settings, prompts, workflows, and model routing in a clean way.
