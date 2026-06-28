---
name: makis-digital-error-handling
description: Consistent error handling patterns for the makis-digital PHP project. Covers exception hierarchy, try/catch discipline, user-facing error messages, logging context, and safe failure modes.
license: MIT
metadata:
  maintainer: JEANMAKISJEANTY
  version: "0.1.0"
  scope: project-and-global
  environment: Designed for Codex and Agent Skills-compatible coding agents working on PHP application error handling.
---

# Makis Digital Error Handling

Use this skill when designing error handling for new features, reviewing exception handling in existing code, or standardizing failure modes across the project.

## Knowledge loading

- Read `references/knowledge/architecture-current.md` to understand where error handling is centralized.
- Read `references/knowledge/security-baseline.md` before designing error responses that touch auth or user data.
- Read `references/knowledge/decisions.md` for past error handling decisions.

## Principles

- Fail safely: never leak internal details (stack traces, SQL, file paths) to users.
- Log enough context to debug, but never log secrets, tokens, or full request bodies.
- Use typed exceptions so callers can catch and handle specific failures.
- Return controlled errors to users in the format the surface expects (HTML or JSON).
- Distinguish between programmatic errors (bugs) and operational errors (validation, not-found, rate-limit).

## Exception hierarchy

```
AppException (base)
  ├── ValidationException    (400)
  ├── AuthenticationException (401)
  ├── AuthorizationException  (403)
  ├── NotFoundException       (404)
  ├── ConflictException       (409)
  ├── RateLimitException      (429)
  └── ExternalServiceException (502)
```

- Catch `AppException` subclasses at the controller or middleware level for user-facing responses.
- Catch `Throwable` at the top-level handler for unexpected errors — log and return 500.

## Controller error handling

- Use a try/catch in the controller or a middleware layer.
- Log the exception with context (route, user id, error message).
- Return the appropriate HTTP status and user-safe error body.
- Do not catch exceptions in controllers only to rethrow them — handle or let the error handler handle.

## Service error handling

- Throw typed exceptions from services when business rules are violated.
- Do not catch exceptions in services unless you can recover or add context.
- Wrap external API failures in `ExternalServiceException` with the original cause.

## Gotchas

- Do not use exceptions for control flow — validate before calling when possible.
- Do not log the same error at multiple levels — log once at the handler.
- Do not expose `$e->getMessage()` from low-level exceptions to users.
- Do not catch `Exception` silently — always log or rethrow.
- Do not forget to handle JSON API errors differently from HTML page errors.

## References

- Read [references/error-handling-standards.md](references/error-handling-standards.md) for detailed patterns and examples.
