# Jarvis Odysseus Local Setup Notes

## Project folder

P:\Projects\odysseus

## Git remotes

origin:
https://github.com/HannabelRex/odysseus

upstream:
https://github.com/pewdiepie-archdaemon/odysseus.git

Upstream push should remain disabled:

upstream push: DISABLE

## Working branch

jarvis/base-integration

## Start Odysseus with Docker

From PowerShell:

```powershell
cd P:\Projects\odysseus

docker compose up -d --build
```

Open:

http://localhost:7000

## Stop Odysseus

```powershell
cd P:\Projects\odysseus

docker compose down
```

## Check containers

```powershell
cd P:\Projects\odysseus

docker compose ps
```

## Check logs

```powershell
cd P:\Projects\odysseus

docker compose logs --tail=200 odysseus
```

or:

```powershell
docker logs odysseus-odysseus-1 --tail 300
```

## Ollama local model setup

Install Ollama on Windows if not already installed.

Verify:

```powershell
ollama --version
```

Pull starter models:

```powershell
ollama pull llama3.1:8b
ollama pull qwen2.5-coder:7b
ollama list
```

Test:

```powershell
ollama run llama3.1:8b
```

Exit Ollama chat:

/bye

## Docker to host Ollama endpoint

Because Odysseus runs in Docker and Ollama runs on Windows host, use:

http://host.docker.internal:11434/v1

Recommended provider settings inside Odysseus:

- Provider type: OpenAI-compatible
- Base URL: http://host.docker.internal:11434/v1
- API key: ollama
- Model: llama3.1:8b

## Daily Git safety commands

Before work:

```powershell
cd P:\Projects\odysseus

git checkout jarvis/base-integration
git pull

git status
```

After work:

```powershell
git status
git add <files>
git commit -m "message"
git push
```

## Pulling upstream updates later

Do this only when planned:

```powershell
cd P:\Projects\odysseus

git fetch upstream
git checkout dev
git pull upstream dev
```

Then carefully merge into Jarvis branch later.

Do not casually merge upstream during active Jarvis changes. Git conflicts are already dramatic enough without surprise guests.
