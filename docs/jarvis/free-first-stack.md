# Jarvis Free-First Stack Policy

## Purpose

Jarvis should use free, open-source, local, or free-tier tools first. Paid services should be optional and used only when they solve a real quality, speed, reliability, or convenience problem.

This keeps development practical and avoids turning the assistant into a subscription collection machine wearing a suit.

## Default approach

| Layer | Free-first choice | Premium option only if needed |
| --- | --- | --- |
| Base workspace | Odysseus | Not needed |
| Local LLM | Ollama | OpenAI API, Anthropic API |
| General model | llama3.1:8b | GPT or Claude models |
| Coding model | qwen2.5-coder:7b | Stronger paid coding model |
| Speech-to-text | faster-whisper | OpenAI speech-to-text |
| Text-to-speech | edge-tts, pyttsx3, Piper | OpenAI TTS, ElevenLabs |
| Vector memory | ChromaDB | Managed vector database |
| Database | SQLite or existing Odysseus DB | Managed Postgres |
| Search | SearXNG | Paid search API |
| Notifications | ntfy | Paid notification service |
| Scheduling | Built-in/Odysseus scheduler, APScheduler | Temporal, cloud queues |
| Deployment | Local Docker | Cloud hosting |

## Model strategy

Start with Ollama because it is local and free.

Recommended starter models:

- llama3.1:8b for general assistant conversations
- qwen2.5-coder:7b for coding help

If local model quality is not enough, make premium models optional through settings. Do not hard-code paid APIs as the only path.

## When premium is allowed

Premium services are acceptable when one of these is true:

- local model quality is too low for a serious task
- local model speed is too slow
- speech recognition accuracy is poor
- text-to-speech quality matters for daily usage
- cloud reliability is required
- external API quality is clearly better than free alternatives

## What must remain optional

These should never be required for basic local Jarvis usage:

- OpenAI API key
- Anthropic API key
- ElevenLabs API key
- paid web search API
- paid hosted database
- paid cloud deployment

## Environment variable principle

Paid providers should be configurable, not mandatory.

Example:

LLM_PROVIDER=ollama
OLLAMA_BASE_URL=http://host.docker.internal:11434/v1

Optional later:

LLM_PROVIDER=openai
OPENAI_API_KEY=your_key_here

## Local-first development rule

Every phase should work locally first unless the phase specifically concerns cloud deployment or external integrations.

## Cost control rule

Before adding a premium provider, document:

- why free/local is not enough
- what the premium tool improves
- expected cost risk
- fallback option
- how to disable it
