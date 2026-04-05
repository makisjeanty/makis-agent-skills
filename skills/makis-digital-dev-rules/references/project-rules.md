# Project Rules

## Objective

Keep `makis-digital` maintainable for a solo beginner developer while preserving production-minded security and predictable growth.

## Non-negotiable rules

- Prefer clarity over cleverness.
- Prefer boring and consistent patterns over premature abstraction.
- Keep security controls present from the first implementation.
- Refactor by seams: routes, controllers, services, repositories, views, security, tests.
- Do not mix request handling, business rules, persistence, and rendering in the same method when avoidable.

## Code style rules

- Use descriptive names in English for code identifiers.
- Keep public methods focused on one use case.
- Return early to reduce nesting.
- Avoid duplicated validation logic across controllers.
- Avoid magic strings for statuses, role names, or error keys when a dedicated constant or value object would make the code safer.

## Comment rules

- Comment invariants, threat-model decisions, and tradeoffs.
- Do not comment obvious line-by-line behavior.
- Update comments when behavior changes.

## Refactor rules

- Preserve behavior first, then improve structure.
- Add a test before moving risky code.
- Move repeated logic to a reusable class only after a second real use case or when the duplication is security-sensitive.

## Review checklist

- Is the input validated?
- Is the output escaped?
- Is the state-changing action protected by CSRF or API auth?
- Is the permission check in the right place?
- Is the code easier to understand than before?
- Is there a test proving the expected behavior?
