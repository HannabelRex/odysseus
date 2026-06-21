# Jarvis Model Routing Notes

## Goal

Jarvis should support free/local models first and premium/cloud models only when needed.

## Default provider strategy

1. Use local Ollama models for normal tasks.
2. Use coding-focused local models for coding tasks.
3. Use cloud models only for tasks that need stronger reasoning, better tool use, or higher reliability.

## Recommended free-first local models

| Task | Suggested local model |
|---|---|
| General chat | llama3.1:8b |
| Coding | qwen2.5-coder:7b |
| Lightweight tasks | mistral |
| Research summarization | llama3.1:8b |

## Premium escalation rules

Use paid/cloud models only when:

- Local output quality is poor
- The task is high value
- The task needs stronger reasoning
- The user explicitly asks for best quality
- The workflow requires reliable function calling or structured output

## Routing concept

```text
User request
  -> classify task mode
  -> choose free/local provider first
  -> escalate only when needed
  -> apply safety checks before actions
```

## Future implementation

Later phases can add provider routing in the Odysseus settings or agent layer.

Possible future provider map:

```text
GENERAL_ASSISTANT_MODEL=llama3.1:8b
CODING_MODEL=qwen2.5-coder:7b
RESEARCH_MODEL=llama3.1:8b
PREMIUM_REASONING_MODEL=openai_or_anthropic_optional
```
