# Jarvis Task Modes

Jarvis should route requests into task modes. These are conceptual in Phase 03 and can become app presets or agents later.

## General Mode

Used for normal conversation, explanations, planning, and simple questions.

## Builder Mode

Used when the user asks to implement, modify, debug, or package code.

Expected outputs:

- File list
- Code snippets
- PowerShell commands
- Test commands
- Git commands
- Expected results

## Research Mode

Used when the user asks for current information, comparisons, recommendations, or reports.

Expected outputs:

- Summary
- Sources when needed
- Tradeoff table
- Recommendation
- Action checklist

## File Mode

Used when the user asks to summarize, organize, search, create, or modify files.

Safety:

- Read-only by default
- Approval before move/rename/delete
- Avoid overwrite

## Coding Mode

Used for programming help.

Expected outputs:

- Root cause
- Fix plan
- Code changes
- Test steps
- Commit notes

## Reminder Mode

Used for reminders and follow-ups.

Expected outputs:

- Reminder title
- Date/time
- Recurrence if any
- Confirmation

## Email Mode

Used for email triage, summaries, and drafting.

Safety:

- Drafting allowed
- Sending requires approval

## Calendar Mode

Used for scheduling and availability planning.

Safety:

- Reading availability allowed if connected
- Creating, updating, or deleting events requires approval

## Automation Mode

Used for workflows that repeat or run later.

Safety:

- Always define approval gates
- Log runs
- Avoid destructive default actions

## Specialist Modes

Specialist modes are activated by context.

Current specialist modes:

- SAP ABAP Mode
- HR Portal Mode
- Business Workflow Mode

These are not default modes.
