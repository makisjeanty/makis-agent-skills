---
name: makis-digital-ai-integration
description: Integrate Claude and other AI capabilities into the makis-digital PHP project with secure SDK wrappers, structured output handling, and safe failure modes. Use when adding AI features, calling LLM APIs from PHP, handling structured responses, or implementing prompt-based workflows.
license: MIT
metadata:
  maintainer: JEANMAKISJEANTY
  version: "0.1.0"
  scope: project-and-global
  environment: Designed for Codex and Agent Skills-compatible coding agents integrating AI SDKs into PHP application codebases. Requires PHP 8.1+ and composer access.
---

# Makis Digital AI Integration

Use this skill when the task involves calling an AI or LLM API from PHP, processing structured or unstructured responses, or building prompt-based features for `makis-digital`.

## Knowledge loading

- Read `references/knowledge/architecture-current.md` before deciding where AI service classes belong.
- Read `references/knowledge/decisions.md` before changing AI-related runtime targets.
- Read `references/knowledge/security-baseline.md` before sending user data to external APIs.

## Workflow

1. Identify the integration point and data flow before writing any SDK code.
2. Create a dedicated service class (e.g. `src/Services/AI/ClaudeService.php`) wrapping the SDK.
3. Read API keys from environment variables, never hardcode or commit them.
4. Validate and minimize outbound data before forwarding it externally.
5. Add explicit exception handling for connection, rate-limit, timeout, and malformed responses.
6. Validate structured output before trusting it in business logic.
7. Add focused tests around failure modes, serialization, and output validation.

## Architecture rules

- Keep SDK calls inside a dedicated service class — never call the SDK directly from controllers.
- Keep prompt templates in separate files or configuration, not inline in service code.
- Keep structured output models in `src/Services/AI/Contracts/` or equivalent.
- Keep API key and model selection in environment configuration.

## Security rules

- Never send secrets, session identifiers, passwords, or raw credentials in prompts.
- Sanitize or minimize user content before forwarding it to external APIs.
- Log request metadata (model, latency, token count) but avoid logging prompt bodies by default.
- Validate structured output against an expected schema before using it in application logic.
- Treat AI responses as untrusted input — escape or validate before rendering or persisting.

## Testing rules

- Test with real SDK client instantiation but mock the HTTP layer for deterministic tests.
- Cover connection failures, rate-limit errors, timeouts, and malformed JSON responses.
- Cover structured output parsing failures and partial or missing fields.
- Cover prompt-assumption regressions when prompt templates change.

## Gotchas

- Do not expose raw AI responses directly to users without escaping or post-processing.
- Do not assume structured output will always match the expected schema.
- Do not skip error handling because "the SDK has built-in retries."
- Do not send the full request body or database row to the AI when only a subset is needed.

## References

- Read [references/ai-integration-workflow.md](references/ai-integration-workflow.md) for the detailed PHP AI integration playbook.
- Read `skills/makis-digital-dev-rules/references/anthropic-php-sdk-notes.md` for Anthropic PHP SDK specifics.
