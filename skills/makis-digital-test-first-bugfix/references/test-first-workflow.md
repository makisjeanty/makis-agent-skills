# Test-First Workflow

## Minimal sequence

1. Write the expected behavior in plain language.
2. Turn it into a failing test.
3. Confirm the failure is for the right reason.
4. Implement the smallest safe fix.
5. Re-run the targeted tests.
6. Re-run the related suite.

## Good regression tests

- Name the bug scenario clearly.
- Keep setup small.
- Assert the exact broken behavior.
- Avoid unrelated expectations in the same test.

## Safe refactor pattern

If the current code is messy:

1. Add regression test.
2. Make it pass with the smallest patch.
3. Refactor with tests still green.
4. Add more tests only if a new branch appears.
