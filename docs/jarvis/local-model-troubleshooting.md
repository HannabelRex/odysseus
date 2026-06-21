# Jarvis Local Model Troubleshooting

## Hotfix 04A note

Hotfix 04A improves `scripts/jarvis/test-ollama.ps1` after manual testing proved the models work but large models may need longer load and generation time.

The safest first test model is:

```text
llama3.2:3b
```

Use larger models after the small model passes.

## Ollama command not found

Problem:

```text
ollama : The term 'ollama' is not recognized
```

Fix:

1. Install Ollama.
2. Close PowerShell.
3. Open a new PowerShell window.
4. Run:

```powershell
ollama --version
```

## Ollama installed but no models

Check:

```powershell
ollama list
```

Pull models:

```powershell
cd P:\Projects\odysseus
powershell -ExecutionPolicy Bypass -File .\scripts\jarvis\pull-local-models.ps1
```

## Test script cannot reach Ollama

Check if Ollama API is reachable from Windows:

```powershell
Invoke-RestMethod http://127.0.0.1:11434/api/tags
```

If this fails:

- start Ollama from the Start Menu
- restart your machine if service startup is confused
- check firewall/security software

## Generation timeout or 500 error

A timeout or 500 error does not always mean the model is broken.

Common causes:

- first model load is slow
- model is too large for current available RAM/GPU
- another model is already loaded
- the machine is busy
- timeout was too short

Start with the smallest installed model:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\jarvis\test-ollama.ps1 -Model "llama3.2:3b"
```

For `llama3.1:8b`, allow more time:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\jarvis\test-ollama.ps1 -Model "llama3.1:8b" -TimeoutSec 600 -NumPredict 24
```

For `qwen2.5-coder:7b`, allow even more time:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\jarvis\test-ollama.ps1 -Model "qwen2.5-coder:7b" -TimeoutSec 900 -NumPredict 32
```

Check loaded models:

```powershell
ollama ps
```

Restart Ollama if repeated 500 errors continue:

```powershell
Stop-Process -Name ollama -Force -ErrorAction SilentlyContinue
```

Then start Ollama again from the Windows Start Menu.

## Manual API test

Use this if the helper script fails and you want to isolate the issue:

```powershell
$Body = @{
  model = "llama3.2:3b"
  prompt = "Say hello in one short sentence."
  stream = $false
  options = @{
    num_predict = 24
  }
} | ConvertTo-Json -Depth 5

Invoke-RestMethod `
  -Uri "http://127.0.0.1:11434/api/generate" `
  -Method Post `
  -Body $Body `
  -ContentType "application/json" `
  -TimeoutSec 180
```

## Odysseus Docker cannot reach Ollama

Use this in Odysseus settings:

```text
http://host.docker.internal:11434/v1
```

Do not use this from inside Docker:

```text
http://localhost:11434/v1
```

Inside Docker, `localhost` points to the container, not Windows.

## Recommended model order

| Task | Recommended model |
|---|---|
| First runtime test | `llama3.2:3b` |
| Everyday local chat | `llama3.2:3b` |
| Better local general reasoning | `llama3.1:8b` |
| Coding help | `qwen2.5-coder:7b` |
| Embeddings/vector memory later | `nomic-embed-text` |
| Fallback | `mistral` |

## Model gives weak answers

Try:

- clearer prompts
- a coding model for coding tasks
- smaller focused task chunks
- premium fallback later for complex tasks

## Out of memory

Symptoms:

- model crashes
- response never completes
- machine freezes
- fans become philosophical

Fix:

- close other apps
- use a smaller model
- avoid running multiple models at once
- do not pull huge models until hardware is confirmed

## Keep Docker stable

After model setup, if you need to rebuild Odysseus:

```powershell
cd P:\Projects\odysseus
docker compose up -d --build odysseus
```

Then open:

```text
http://localhost:7000
```
