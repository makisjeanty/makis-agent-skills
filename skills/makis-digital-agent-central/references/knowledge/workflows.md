# Workflows

## Safe CRUD Change

1. Activate `makis-digital-dev-rules` to frame the change.
2. Use `makis-digital-crud-refactor` to map route, controller, persistence, and tests.
3. Add or update tests that lock current behavior.
4. Refactor incrementally toward controller, service, and repository separation.
5. Run focused tests.
6. Run `makis-digital-security-review` before closing if the CRUD flow mutates data or exposes admin actions.

## Security Hardening Pass

1. Activate `makis-digital-security-review`.
2. Enumerate all entry points in the affected flow.
3. Check validation, CSRF, auth, authorization, output escaping, and error handling.
4. Add failing-path tests for unauthorized or forged requests.
5. Patch the smallest risky surface first.
6. Re-run focused tests and summarize any remaining exposure.

## Test-First Bugfix

1. Activate `makis-digital-test-first-bugfix`.
2. State the broken behavior in one sentence.
3. Write the narrowest failing test that proves it.
4. Implement the smallest safe fix.
5. Re-run the focused suite and then the related broader suite.
6. If the bug touches input, auth, sessions, uploads, or output, add `makis-digital-security-review` before finishing.

## AI Integration in PHP

1. Activate `makis-digital-dev-rules`.
2. Read `references/anthropic-php-sdk-notes.md`.
3. Keep SDK calls inside a dedicated service class.
4. Validate input and minimize outbound data.
5. Add tests around failure handling and structured output assumptions.
