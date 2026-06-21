# Jarvis Premium Design Token Guide

## Purpose

This guide defines the reusable visual language for Jarvis inside Odysseus. The goal is to keep the UI premium, calm, futuristic, readable, and consistent.

## Design principles

1. **Premium calm over noisy sci-fi**  
   Jarvis should feel intelligent and elegant, not like a gaming keyboard fell into a submarine console.

2. **Universal assistant first**  
   The design must support chat, research, code, files, tools, memory, email, calendar, and automation.

3. **Non-invasive layering**  
   Keep Odysseus functionality intact. Add tokens and foundation styles first, then redesign areas phase by phase.

4. **Accessibility still matters**  
   Futuristic does not mean unreadable. Text contrast, focus states, and motion reduction must stay sane.

## Token groups

### Background tokens

- `--jarvis-space-void`
- `--jarvis-space-deep`
- `--jarvis-space-navy`
- `--jarvis-space-aurora`

### Surface tokens

- `--jarvis-surface-glass`
- `--jarvis-surface-panel`
- `--jarvis-surface-panel-strong`
- `--jarvis-surface-elevated`

### Accent tokens

- `--jarvis-cyan`
- `--jarvis-blue`
- `--jarvis-violet`
- `--jarvis-emerald`
- `--jarvis-amber`
- `--jarvis-red`

### Text tokens

- `--jarvis-text-primary`
- `--jarvis-text-secondary`
- `--jarvis-text-muted`
- `--jarvis-text-inverse`

### Border tokens

- `--jarvis-border-subtle`
- `--jarvis-border-cyan`
- `--jarvis-border-strong`

### Radius tokens

- `--jarvis-radius-xs`
- `--jarvis-radius-sm`
- `--jarvis-radius-md`
- `--jarvis-radius-lg`
- `--jarvis-radius-xl`
- `--jarvis-radius-pill`

### Shadow tokens

- `--jarvis-shadow-sm`
- `--jarvis-shadow-md`
- `--jarvis-shadow-lg`
- `--jarvis-shadow-glow`
- `--jarvis-shadow-cyan`

### Spacing tokens

- `--jarvis-space-1` through `--jarvis-space-8`

## Future phase usage

- Phase 05D should use these tokens for sidebar and top command bar.
- Phase 05E should use these tokens for chat cards, composer, response actions, and context rail.
- Phase 05F should use these tokens for Settings / Control Room.
- Phase 05G should use these tokens for dashboard cards and quick actions.

## Rule

Do not hardcode new colors in future Jarvis CSS unless there is a strong reason. Add or reuse a token instead. Civilization begins with naming things, apparently.
