# Skill Catalog

## Core skills

- `makis-digital-agent-central`
  Central orchestrator — use first when scope is unclear or task spans multiple concerns.
- `makis-digital-specs`
  Translate requirements into structured technical specifications before coding.
- `makis-digital-dev-rules`
  Umbrella skill with reusable engineering rules for architecture, security, testing, and delivery.
- `makis-digital-crud-refactor`
  Use for CRUD reorganization, modularization, and safer controller/service/repository separation.
- `makis-digital-security-review`
  Use for validation, CSRF, auth, output escaping, upload safety, and general hardening reviews.
- `makis-digital-test-first-bugfix`
  Use for regressions, bug reproduction, and risky fixes that should start from a failing test.
- `makis-digital-ai-integration`
  Use for integrating AI SDKs with secure wrappers, structured output, and proper error handling.
- `makis-digital-database-patterns`
  Use for persistence layer design, repository patterns, query organization, and migrations.
- `makis-digital-memory`
  Use to capture decisions, patterns, and architecture rationale across sessions.
- `makis-digital-verification-loop`
  Use after changes to confirm builds, tests, security, and diffs are clean.
- `makis-digital-api-patterns`
  Use for REST API design with consistent envelopes, auth, pagination, and error formats.
- `makis-digital-error-handling`
  Use for typed exceptions, safe user-facing messages, and structured logging context.
- `makis-digital-testing-strategy`
  Use to plan test coverage at unit, integration, and e2e levels.
- `makis-digital-frontend-patterns`
  Use for PHP views, form handling, JS organization, and accessible markup.
- `makis-digital-deployment`
  Use for build, release, health checks, environment config, and rollback.
- `makis-digital-logging-observability`
  Use for PSR-3 structured logging with levels, context, and security-aware practices.
- `makis-digital-dependency-management`
  Use for Composer workflows, version policies, and security auditing.
- `makis-digital-idea-prompt-generator`
  Generate ideas and structured prompts for agent-central from vague goals.
- `makis-digital-expert-researcher`
  Research codebases, patterns, and libraries before implementing.

## Starter bundles

- `safe-feature-delivery`
  Start with `makis-digital-dev-rules`, then use `makis-digital-crud-refactor`, and finish with `makis-digital-security-review`.
- `security-hardening`
  Start with `makis-digital-dev-rules`, then use `makis-digital-security-review`, and add `makis-digital-test-first-bugfix` if the fix is risky.
- `bugfix-with-confidence`
  Start with `makis-digital-test-first-bugfix`, then use `makis-digital-security-review` if the bug touches auth, input, output, uploads, or sessions.
- `ai-feature-delivery`
  Start with `makis-digital-dev-rules`, then use `makis-digital-ai-integration`, and finish with `makis-digital-verification-loop`.
- `crud-with-database-review`
  Start with `makis-digital-crud-refactor`, add `makis-digital-database-patterns` if persistence changes, and finish with `makis-digital-verification-loop`.
- `full-feature-from-scratch`
  Start with `makis-digital-specs`, then `makis-digital-agent-central` to orchestrate, and finish with `makis-digital-memory` to capture decisions.
- `api-development`
  Start with `makis-digital-api-patterns`, then `makis-digital-error-handling`, then `makis-digital-testing-strategy`.
- `production-readiness`
  Start with `makis-digital-deployment`, then `makis-digital-logging-observability`, then `makis-digital-dependency-management`.
- `idea-to-feature`
  Start with `makis-digital-idea-prompt-generator`, then `makis-digital-agent-central` to execute.
- `research-first`
  Start with `makis-digital-expert-researcher`, then `makis-digital-agent-central` to implement.
