# Makis Digital Workflows

These workflows are ordered playbooks inspired by skill-library workflow patterns.

## Workflow: Safe CRUD Change

1. Activate `makis-digital-dev-rules` to frame the change.
2. Use `makis-digital-crud-refactor` to map route, controller, persistence, and tests.
3. Add or update tests that lock current behavior.
4. Refactor incrementally toward controller, service, and repository separation.
5. Run focused tests and keep the result as an artifact.
6. Run `makis-digital-security-review` before closing if the CRUD flow mutates data or exposes admin actions.
7. Save the reusable pattern to the project knowledge base if the refactor created a new standard.

## Workflow: Security Hardening Pass

1. Activate `makis-digital-security-review`.
2. Enumerate all entry points in the affected flow.
3. Check validation, CSRF, auth, authorization, output escaping, and error handling.
4. Add failing-path tests for unauthorized or forged requests.
5. Patch the smallest risky surface first.
6. Re-run focused tests and capture the results as an artifact.
7. Summarize any remaining exposure and recommended autonomy level for future work in the same area.

## Workflow: Test-First Bugfix

1. Activate `makis-digital-test-first-bugfix`.
2. State the broken behavior in one sentence.
3. Write the narrowest failing test that proves it.
4. Implement the smallest safe fix.
5. Re-run the focused suite and then the related broader suite.
6. Preserve the failing-test and passing-test evidence as artifacts.
7. If the bug touches input, auth, sessions, uploads, or output, add `makis-digital-security-review` before finishing.

## Workflow: AI Integration in PHP

1. Activate `makis-digital-dev-rules`.
2. Use `makis-digital-ai-integration` to set up the SDK wrapper and service layer.
3. Keep SDK calls inside a dedicated service class.
4. Validate input and minimize outbound data.
5. Add tests around failure handling and structured output assumptions.
6. Run `makis-digital-verification-loop` before closing.
7. Document prompt/output assumptions as reusable knowledge for future agents.

## Workflow: Safe Database Change

1. Activate `makis-digital-dev-rules` to frame the change.
2. Use `makis-digital-database-patterns` to review or design the persistence layer.
3. Add or update repository methods and migration steps.
4. Add focused persistence tests for each read/write path.
5. Run the full test suite.
6. Run `makis-digital-verification-loop` before closing.
7. Run `makis-digital-memory` to capture any new patterns or schema decisions.

## Workflow: Full Feature from Scratch

1. Activate `makis-digital-agent-central` to analyze and route the task.
2. Use `makis-digital-specs` to write the technical specification.
3. Use `makis-digital-dev-rules` to frame implementation.
4. Use the relevant specialized skill (CRUD, AI, database, security) to implement.
5. Run `makis-digital-verification-loop` after implementation.
6. Run `makis-digital-memory` to capture decisions and new patterns.

## Workflow: Knowledge Capture Session

1. Activate `makis-digital-memory`.
2. Review recent completed work for reusable patterns, decisions, or gotchas.
3. Capture each finding in the appropriate knowledge file.
4. Update skill reference files if a new pattern should be codified as a workflow or rule.
5. Run validation to confirm knowledge files are well-formed.

## Workflow: API Endpoint Development

1. Activate `makis-digital-dev-rules` to frame the work.
2. Use `makis-digital-api-patterns` to design the endpoint contract, envelope, and auth.
3. Use `makis-digital-error-handling` to ensure typed exceptions and safe error responses.
4. Implement the endpoint handler, validation, and response formatting.
5. Use `makis-digital-testing-strategy` to cover success, validation, auth, and error paths.
6. Run `makis-digital-verification-loop` before closing.

## Workflow: Production Readiness Check

1. Activate `makis-digital-deployment` to verify build, health checks, and rollback plan.
2. Use `makis-digital-logging-observability` to confirm structured logging is in place.
3. Use `makis-digital-dependency-management` to audit dependencies and run `composer audit`.
4. Use `makis-digital-security-review` to confirm security baseline.
5. Run `makis-digital-verification-loop` with the full checklist.

## Workflow: Idea to Feature

1. Activate `makis-digital-idea-prompt-generator` with the domain or goal.
2. Select the best idea and refine it into a concrete prompt.
3. Pass the prompt to `makis-digital-agent-central` to analyze and route the task.
4. Follow the orchestrated skill chain produced by agent-central.
5. Run `makis-digital-verification-loop` before closing.

## Workflow: Research Before Implementation

1. Activate `makis-digital-expert-researcher` with the research question.
2. Choose depth: quick (single question), moderate (feature scope), or deep (architecture decision).
3. Gather evidence from the codebase and, if needed, from external sources.
4. Produce a structured report: summary, evidence, recommendation, risks.
5. Pass the recommendation to `makis-digital-agent-central` to plan and execute implementation.
