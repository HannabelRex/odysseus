# Jarvis Odysseus Phase 04 - Free Local Model Configuration

## Status

Planned package phase. Apply only on branch `jarvis/base-integration`.

## Goal

Configure the Jarvis/Odysseus project around a free-first local model strategy.

This phase does not force Odysseus to use one provider. It creates the operating guidance and helper scripts needed to use local Ollama models first, while keeping premium/API providers optional for later.

## Why this phase exists

Jarvis should be powerful but cost-aware. The baseline assistant should work with local/free models where practical, then fall back to paid APIs only when the task needs better quality, speed, reliability, or tool support.

This keeps development practical:

- local experimentation stays cheap
- sensitive local tasks can avoid unnecessary API calls
- premium providers can be added later without rewriting the project
- model selection becomes intentional instead of accidental wallet combustion

## Scope

This phase adds:

- local Ollama setup notes
- recommended model guide
- model provider routing notes
- local model troubleshooting guide
- helper scripts to pull and test local models

## Not in scope

This phase does not:

- add API keys
- edit `.env`
- commit `.env`
- change Odysseus database tables
- modify authentication
- modify tool permissions
- wire a provider into runtime code
- enable any autonomous action

## Recommended local-first stack

| Capability | Free-first choice | Premium fallback later |
|---|---|---|
| General chat | `llama3.1:8b` via Ollama | OpenAI/Claude/Gemini API |
| Coding help | `qwen2.5-coder:7b` via Ollama | stronger cloud coding model |
| Lightweight fallback | `mistral` via Ollama | API small model |
| Embeddings | `nomic-embed-text` via Ollama | API embeddings |
| Speech-to-text later | faster-whisper | cloud STT |
| Text-to-speech later | edge-tts / Piper | premium TTS |

## Docker-to-Ollama connection rule

When Odysseus runs inside Docker and Ollama runs on Windows, the Odysseus container must reach the Windows host through:

```text
http://host.docker.internal:11434/v1
```

Do not use `http://localhost:11434/v1` from inside the container unless Ollama is also inside that same container. Inside Docker, `localhost` means the container itself. Software naming remains a tax on sanity.

## Recommended Odysseus provider setting

Use an OpenAI-compatible provider entry where available:

```text
Provider type: OpenAI-compatible
Base URL: http://host.docker.internal:11434/v1
API key: ollama
Model: llama3.1:8b
```

For coding tasks:

```text
Model: qwen2.5-coder:7b
```

For embeddings/vector memory later:

```text
Model: nomic-embed-text
```

## Success checklist

- `ollama --version` works
- `ollama list` shows at least one model
- `scripts/jarvis/test-ollama.ps1` returns a local response
- Odysseus can be configured to use `http://host.docker.internal:11434/v1`
- No API keys were committed
- No `.env` file was staged

## Next phase

After this phase, continue with a runtime wiring phase only after the local model path is tested manually in Odysseus settings.
