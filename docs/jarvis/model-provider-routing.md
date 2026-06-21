# Jarvis Model Provider Routing

## Purpose

Jarvis should support provider routing without becoming dependent on one paid provider.

The default strategy:

```text
Local/free first.
Premium only when clearly useful.
```

## Provider priority

| Priority | Provider type | Use case |
|---|---|---|
| 1 | Local Ollama | everyday development, private/local testing |
| 2 | Free-tier/cloud optional | occasional stronger tasks if available |
| 3 | Paid API | high-value tasks only |

## Suggested routing rules

| Task type | First model | Fallback |
|---|---|---|
| General chat | `llama3.1:8b` | premium general model |
| Coding | `qwen2.5-coder:7b` | premium coding-capable model |
| Summarization | `llama3.1:8b` | premium long-context model |
| Memory embeddings | `nomic-embed-text` | paid embedding API |
| Sensitive local file analysis | local model | premium only after approval |
| Business-critical output | local draft | premium review if needed |

## Manual routing first

In the early phases, model selection should stay manual through Odysseus settings.

Automatic routing comes later after:

- safety rules are stable
- model config is tested
- logging exists
- tool approvals are reliable

## No secret leakage rule

Never place provider API keys in:

```text
prompts
docs committed to Git
scripts committed to Git
source code committed to Git
screenshots
chat messages
```

Use local settings or `.env`, and keep `.env` ignored.

## Future runtime routing idea

Later Jarvis can use a simple policy engine:

```text
if task is simple and local model available:
    use Ollama
elif task is complex and user allows premium:
    use premium model
else:
    ask user for approval or use local fallback
```

No automatic paid calls without explicit configuration. The API bill should not become an autonomous agent.
