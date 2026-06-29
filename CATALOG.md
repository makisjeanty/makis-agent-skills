# Makis Digital Agent Catalog

This is the local catalog for reusable agent guidance in this skill repository.

## Core skills

- `makis-digital-dev-rules`
  Use as the umbrella skill when a task spans architecture, security, testing, and delivery decisions.
- `makis-digital-crud-refactor`
  Use for CRUD reorganization, modularization, and safer controller/service/repository separation.
- `makis-digital-security-review`
  Use for validation, CSRF, auth, output escaping, upload safety, and general hardening reviews.
- `makis-digital-test-first-bugfix`
  Use for regressions, bug reproduction, and risky fixes that should start from a failing test.
- `makis-digital-ai-integration`
  Use for integrating Claude or other AI SDKs into PHP with secure wrappers, structured output, and proper error handling.
- `makis-digital-database-patterns`
  Use for persistence layer design, repository patterns, query organization, and safe migration workflows.
- `makis-digital-verification-loop`
  Use after any change to confirm builds, tests, security, and diffs are clean before closing the task.
- `makis-digital-agent-central`
  Central orchestrator that analyzes incoming tasks and chains the right specialized skills from start to finish.
- `makis-digital-memory`
  Project knowledge management — capture decisions, patterns, and architecture rationale across sessions.
- `makis-digital-specs`
  Translate vague requirements into structured technical specifications before implementing.
- `makis-digital-api-patterns`
  Design REST APIs with consistent envelopes, auth, pagination, versioning, and error responses.
- `makis-digital-error-handling`
  Implement consistent error handling with typed exceptions, safe messages, and proper logging.
- `makis-digital-testing-strategy`
  Plan test coverage — decide what to test at unit, integration, and e2e levels.
- `makis-digital-frontend-patterns`
  Build PHP views, forms, JavaScript, and CSS with proper escaping and accessibility.
- `makis-digital-deployment`
  Set up build, release, health checks, environment config, and rollback workflows.
- `makis-digital-logging-observability`
  Add structured PSR-3 logging with appropriate levels and security-aware context.
- `makis-digital-dependency-management`
  Manage Composer packages with version policies, security audits, and update workflows.
- `makis-digital-idea-prompt-generator`
  Turn vague goals into concrete ideas and ready-to-execute prompts for agent-central.
- `makis-digital-expert-researcher`
  Investigate codebases, patterns, libraries, and architectures before implementing.
- `makis-digital-performance-optimization`
  Profile slow paths, fix N+1 queries, add caching, and tune PHP and MySQL performance.

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
  Start with `makis-digital-specs` to define requirements, then `makis-digital-agent-central` to orchestrate, and finish with `makis-digital-memory` to capture decisions.
- `api-development`
  Start with `makis-digital-api-patterns` for endpoint design, then `makis-digital-error-handling`, then `makis-digital-testing-strategy` for coverage.
- `production-readiness`
  Start with `makis-digital-deployment` for release workflow, then `makis-digital-logging-observability`, then `makis-digital-dependency-management` for audit.
- `idea-to-feature`
  Start with `makis-digital-idea-prompt-generator` to refine the idea and build the prompt, then `makis-digital-agent-central` to execute.
- `research-first`
  Start with `makis-digital-expert-researcher` to investigate architecture and patterns, then `makis-digital-agent-central` to implement based on findings.
- `performance-fix`
  Start with `makis-digital-performance-optimization` to profile and fix the slow path, then `makis-digital-database-patterns` if persistence changes are needed, and finish with `makis-digital-verification-loop`.

## Orchestration

For any task, start with `makis-digital-agent-central` to automatically analyze, route, and chain the right skills. Use individual skills directly only when the scope is already clear and narrow.

## Selection rule

If the task is broad or unclear, start with `makis-digital-dev-rules`.
If the task is clearly narrow, use the smallest specialized skill that fits.
