# Anthropic PHP SDK Notes

Use these notes when `makis-digital` needs Claude integration through PHP.

## Package

- Repository: https://github.com/anthropics/anthropic-sdk-php
- Install with `composer require "anthropic-ai/sdk:^0.9.0"`
- Requires PHP 8.1+

## Practical adoption notes

- Create the client with `Anthropic\Client`.
- Read the API key from environment variables, never hardcode it.
- Wrap API calls with explicit exception handling for connection, rate-limit, and status errors.
- Keep Claude-specific integration behind a service class such as `ClaudeService` instead of calling the SDK directly from controllers.

## Useful capabilities

- Standard message creation for synchronous requests.
- Streaming with SSE for long-running responses.
- Structured output using PHP classes that extend `StructuredOutputModel`.
- Retries are built in for common transient failures, but error handling should still be explicit at the application layer.

## Suggested architecture for this project

- `src/Services/AI/ClaudeService.php`: SDK wrapper and prompt orchestration
- `src/Services/AI/Contracts/...`: DTOs or output models for structured responses
- `config/` or env loader: API key and model selection
- tests around serialization, validation, fallback behavior, and safe failure modes

## Security rules for SDK integration

- Never send secrets, session identifiers, or raw credentials in prompts.
- Sanitize or minimize user content before forwarding it externally when possible.
- Log request metadata carefully and avoid logging sensitive prompt bodies by default.
- Validate structured output before trusting it in business logic.
