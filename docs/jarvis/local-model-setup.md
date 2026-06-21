# Jarvis Local Model Setup

## Purpose

This guide explains how to set up free local models for Jarvis/Odysseus using Ollama.

The goal is not to avoid premium models forever. The goal is to avoid paying for basic development tasks while we build the foundation. Revolutionary, apparently.

## Step 1 - Install Ollama

Install Ollama from the official Ollama download page.

After installation, close and reopen PowerShell, then run:

```powershell
ollama --version
```

Expected result:

```text
ollama version ...
```

## Step 2 - Pull recommended starter models

From the repo root:

```powershell
cd P:\Projects\odysseus
powershell -ExecutionPolicy Bypass -File .\scripts\jarvis\pull-local-models.ps1
```

Default models:

```text
llama3.1:8b
qwen2.5-coder:7b
mistral
nomic-embed-text
```

## Step 3 - Confirm model list

```powershell
ollama list
```

You should see the models you pulled.

## Step 4 - Test local inference

```powershell
cd P:\Projects\odysseus
powershell -ExecutionPolicy Bypass -File .\scripts\jarvis\test-ollama.ps1 -Model "llama3.1:8b"
```

Expected behavior:

- script detects Ollama
- script detects available models
- script sends a small prompt
- script prints a short model response

## Step 5 - Connect Odysseus Docker to Ollama

Since Odysseus runs in Docker and Ollama normally runs on Windows, use this base URL in Odysseus model/provider settings:

```text
http://host.docker.internal:11434/v1
```

Use this as the API key when the UI requires a value:

```text
ollama
```

Use this as the general model:

```text
llama3.1:8b
```

Use this as the coding model where supported:

```text
qwen2.5-coder:7b
```

## Step 6 - Keep premium providers optional

Do not add OpenAI, Claude, Gemini, or other paid API keys until a specific phase requires it.

If a premium provider is added later, it should be configured through local `.env` or Odysseus settings, never committed to Git.
