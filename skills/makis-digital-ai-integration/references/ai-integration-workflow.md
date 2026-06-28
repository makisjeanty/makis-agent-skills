# AI Integration Workflow

Use this playbook when integrating Claude or other LLM APIs into `makis-digital`.

## Step 1 — Map the integration point

- Identify the controller or trigger that will call the AI.
- Define what data goes out (prompt + context) and what comes back (structured or unstructured).
- Define the fallback behavior if the API is unreachable or returns an error.

## Step 2 — Create the service layer

- Create `src/Services/AI/ClaudeService.php` (or equivalent per provider).
- Inject the SDK client via constructor or factory.
- Expose focused methods like `summarizeText(...)`, `classifyRequest(...)`, `generateResponse(...)`.
- Keep prompt templates in `src/Services/AI/Prompts/` or config files.

## Step 3 — Define output models

- Create DTOs or typed classes for structured responses.
- Validate required fields after parsing.
- Reject or fall back when critical fields are missing or malformed.

## Step 4 — Add error handling

- Wrap SDK calls in try/catch for:
  - Connection errors
  - Rate-limit errors
  - Timeout errors
  - Invalid response format
  - Unexpected API errors
- Log diagnostic info without exposing prompt content or API keys.
- Return safe user-facing errors that do not leak internals.

## Step 5 — Add tests

- Unit tests for prompt assembly and output parsing.
- Integration tests using a mock HTTP client or test server.
- Security tests that verify sensitive data is not included in prompts.

## Step 6 — Document assumptions

- Save prompt templates and expected output schemas to the project knowledge base.
- Document token budget, model selection, and cost considerations.
- Note any rate-limit or concurrency constraints.
