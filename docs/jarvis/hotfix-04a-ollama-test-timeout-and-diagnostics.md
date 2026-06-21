# Jarvis Odysseus Hotfix 04A - Ollama Test Timeout and Diagnostics

## Status

Hotfix package.

Apply only on branch:

```text
jarvis/base-integration
```

## Why this hotfix exists

Phase 04 successfully pulled the local Ollama models, but the first version of `scripts/jarvis/test-ollama.ps1` was too strict for real local model behavior on Windows.

Manual API tests proved that local generation works:

| Model | Manual result | Observed behavior |
|---|---|---|
| `llama3.2:3b` | Passed | Fast starter model |
| `llama3.1:8b` | Passed | Slower initial load |
| `qwen2.5-coder:7b` | Passed | Very slow initial generation |

The test script needed to behave like a beginner-friendly diagnostic helper instead of panicking like a tiny CI server with trust issues.

## What changed

This hotfix updates `scripts/jarvis/test-ollama.ps1` to:

- default to `llama3.2:3b` as the first runtime test model
- use a short prompt
- expose `-TimeoutSec`
- expose `-NumPredict`
- send Ollama `num_predict` in the generation request
- show model duration details when available
- print clearer recovery steps for timeouts and 500 errors
- keep the Docker-to-Ollama endpoint reminder

## Recommended tests after applying

Fast starter test:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\jarvis\test-ollama.ps1 -Model "llama3.2:3b"
```

General model test:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\jarvis\test-ollama.ps1 -Model "llama3.1:8b" -TimeoutSec 600 -NumPredict 24
```

Coding model test:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\jarvis\test-ollama.ps1 -Model "qwen2.5-coder:7b" -TimeoutSec 900 -NumPredict 32
```

## Odysseus setting reminder

When Odysseus runs inside Docker and Ollama runs on Windows, configure Odysseus with:

```text
http://host.docker.internal:11434/v1
```

Do not use this inside Docker:

```text
http://localhost:11434/v1
```

Inside Docker, `localhost` means the container itself, because software enjoys making simple words suspicious.
