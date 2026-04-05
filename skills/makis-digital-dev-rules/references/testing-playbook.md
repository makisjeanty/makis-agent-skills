# Testing Playbook

## When to use TDD first

Use test-first when:

- fixing a bug with a reproducible case
- adding business rules
- changing validation logic
- changing authentication, authorization, CSRF, or token behavior
- reorganizing code without intending to change behavior

## Test selection

- Use unit tests for pure validation and rule classes.
- Use integration-style tests for routing, controller flow, persistence, and rendering decisions.
- Add regression tests for every bug that reached implementation.

## Minimal workflow

1. Describe the expected behavior in one sentence.
2. Write or update the smallest failing test proving it.
3. Implement the smallest safe change.
4. Run the focused test file.
5. Run the broader related suite before finishing.

## CRUD coverage baseline

Every CRUD module should eventually cover:

- create with valid input
- create with invalid input
- list or read existing records
- update existing record
- update missing record
- delete existing record
- delete missing record
- auth or permission failure
- CSRF failure for browser mutations

## Practical rule

If a change feels risky and there is no test, stop and add one before deeper refactoring.
