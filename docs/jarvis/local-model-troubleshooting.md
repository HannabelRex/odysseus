# Jarvis Local Model Troubleshooting

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

## Model is slow

Try:

```text
mistral
```

or use a smaller model later.

Possible causes:

- not enough RAM
- CPU-only inference
- model too large
- other apps consuming memory
- laptop power saving mode

## Model gives weak answers

Try:

- clearer prompts
- coding model for coding tasks
- premium fallback for complex tasks
- smaller focused task chunks

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
