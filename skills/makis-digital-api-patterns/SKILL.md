---
name: makis-digital-api-patterns
description: REST API patterns for the makis-digital PHP project covering endpoint design, authentication, response envelopes, pagination, error formats, and versioning. Use when creating or refactoring API endpoints.
license: MIT
metadata:
  maintainer: JEANMAKISJEANTY
  version: "0.1.0"
  scope: project-and-global
  environment: Designed for Codex and Agent Skills-compatible coding agents building or maintaining PHP JSON APIs.
---

# Makis Digital API Patterns

Use this skill when the task involves API endpoints, JSON responses, API authentication, or client-facing data contracts.

## Knowledge loading

- Read `references/knowledge/architecture-current.md` to understand where API controllers live.
- Read `references/knowledge/security-baseline.md` before designing auth for new endpoints.
- Read `references/knowledge/decisions.md` before changing API conventions.

## Workflow

1. Define the endpoint contract (method, path, request body, response shape, status codes) before writing code.
2. Choose auth strategy — JWT for API, session+CSRF for browser forms, or both for hybrid endpoints.
3. Implement request validation with allow-lists and structured error responses.
4. Implement the response with a consistent envelope format.
5. Add pagination for list endpoints that may return many items.
6. Add focused API tests for success, validation errors, auth failures, and edge cases.

## Response envelope

```json
{
  "data": { ... },
  "errors": [],
  "pagination": { "page": 1, "per_page": 20, "total": 100 }
}
```

- Success: `data` populated, `errors` empty.
- Validation error: `data` null, `errors` array of `{ "field": "...", "message": "..." }`.
- Auth error: HTTP 401/403, `errors` populated, `data` null.

## Endpoint design

- Use resource-oriented URLs: `/api/projects`, `/api/projects/{id}`.
- Use HTTP methods for actions: GET (read), POST (create), PUT/PATCH (update), DELETE.
- Use consistent plural nouns for collection endpoints.
- Do not embed actions in URLs (`/api/projects/delete/5` → `DELETE /api/projects/5`).

## Security rules

- All API endpoints except public ones require JWT or API key auth.
- Validate every input field with type, format, and length checks.
- Return generic error messages for auth failures — do not reveal whether the user exists.
- Rate-limit authentication endpoints and resource-intensive queries.
- Log request metadata without logging request bodies or auth tokens.

## Testing rules

- Test each endpoint for success, validation error, auth failure, and not-found.
- Test pagination parameters (page, per_page, out-of-range values).
- Test response envelope format.

## References

- Read [references/api-standards.md](references/api-standards.md) for detailed API conventions and examples.
