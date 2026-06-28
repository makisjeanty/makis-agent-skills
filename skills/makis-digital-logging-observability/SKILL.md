---
name: makis-digital-logging-observability
description: Logging and observability patterns for the makis-digital PHP project. Covers structured logging, log levels, context enrichment, and PSR-3 compliant practices. Use when adding or reviewing logging in any part of the application.
license: MIT
metadata:
  maintainer: JEANMAKISJEANTY
  version: "0.1.0"
  scope: project-and-global
  environment: Designed for Codex and Agent Skills-compatible coding agents working on PHP application observability.
---

# Makis Digital Logging and Observability

Use this skill when adding logging to new features, reviewing existing log statements, or standardizing observability practices across the project.

## Knowledge loading

- Read `references/knowledge/architecture-current.md` to understand where logging is configured.
- Read `references/knowledge/security-baseline.md` before logging request data.

## Log levels

| Level | When | Example |
|---|---|---|
| debug | Detailed diagnostic info during development | SQL queries, parsed input |
| info | Normal operational events | User login, record created |
| notice | Normal but significant events | Configuration change, migration run |
| warning | Something unexpected but not an error | Rate-limit approaching, deprecated call |
| error | Runtime error that is recoverable | External API failure, validation exception |
| critical | System component unavailable | Database down, filesystem full |
| alert | Action must be taken immediately | Security-relevant event |
| emergency | System is unusable | Boot failure, config corruption |

## Structured context

Always include structured context with log entries instead of interpolating into the message:

```php
// Good
$this->logger->info('Project created', [
    'project_id' => $project->id,
    'user_id' => $userId,
    'duration_ms' => $duration,
]);

// Bad
$this->logger->info("Project {$project->id} created by user {$userId}");
```

## What to log

- Request-level: method, route, status code, duration, user id.
- Business events: entity creation, deletion, status changes.
- Security events: login success, login failure, auth token issued, permission denied.
- External calls: API url (without tokens), status code, duration.
- Errors: exception class, message, route, user id — never full stack trace in production logs.

## What not to log

- Passwords, secrets, API keys, tokens
- Full request bodies or database rows
- Session identifiers
- Personal identifiable information
- Credit card numbers or payment details

## Log configuration

- Use PSR-3 compatible logger (Monolog or equivalent).
- Configure different handlers per environment: file in production, stdout in development.
- Use log rotation in production to prevent disk exhaustion.
- Format: `[datetime] channel.LEVEL: message {"context"} {"extra"}`

## References

- Read [references/logging-standards.md](references/logging-standards.md) for detailed logging patterns and configuration examples.
