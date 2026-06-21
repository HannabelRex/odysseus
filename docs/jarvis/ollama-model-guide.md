# Jarvis Ollama Model Guide

## Model selection principle

Use the smallest local model that can do the job acceptably. Upgrade only when the task needs stronger reasoning, better coding skill, longer context, or reliability.

## Recommended starter models

| Model | Role | Why use it |
|---|---|---|
| `llama3.1:8b` | General Jarvis chat | Good local general-purpose baseline |
| `qwen2.5-coder:7b` | Coding help | Better for code tasks than a general model |
| `mistral` | Lightweight fallback | Useful when speed matters more than depth |
| `nomic-embed-text` | Embeddings | Useful for future vector memory/search |

## General assistant model

```text
llama3.1:8b
```

Use for:

- general questions
- planning
- summarization
- basic reasoning
- drafting
- simple research synthesis
- assistant personality testing

## Coding model

```text
qwen2.5-coder:7b
```

Use for:

- explaining code
- generating scripts
- debugging errors
- writing small functions
- reviewing file changes
- creating PowerShell helper scripts

## Lightweight fallback

```text
mistral
```

Use for:

- quick local tests
- fast draft answers
- lower-resource machines
- sanity checks

## Embedding model

```text
nomic-embed-text
```

Use later for:

- semantic memory
- local document search
- vector retrieval
- notes/projects indexing

## When to use premium models later

Use premium providers only when local models are not good enough for:

- complex architecture planning
- high-accuracy coding
- long documents
- difficult research synthesis
- production-critical output
- multi-step tool planning
- vision/audio capabilities local tools cannot handle well

## Prompting local models

Local models usually need clearer prompts than top cloud models.

Good:

```text
You are Jarvis, a universal assistant. Give a direct answer. Use numbered steps. Do not invent facts. Ask for approval before actions.
```

Bad:

```text
Do the thing.
```

Model is not psychic. Shocking development.
