# Verification Checklist

Use this checklist after every non-trivial change in `makis-digital`.

## Build

- [ ] Project loads without fatal or parse errors.
- [ ] No undefined functions, classes, or constants introduced.
- [ ] Autoload mapping covers any new classes.

## Focused tests

- [ ] Unit tests for new or changed pure logic (validators, helpers, utilities).
- [ ] Integration tests for new or changed route-controller-service paths.
- [ ] Persistence tests for new or changed read/write operations.
- [ ] All focused tests pass.

## Broader tests

- [ ] Full test suite runs without failures.
- [ ] Any pre-existing failures are documented and unrelated to the change.

## Security review

- [ ] Entry points affected by the change are enumerated.
- [ ] Validation is present for all new input paths.
- [ ] Authorization checks are near the protected action, not assumed from routing.
- [ ] CSRF protection is present for browser state-changing forms.
- [ ] Output is escaped for the correct context (HTML, attribute, URL, JSON).
- [ ] Error messages do not leak internal details.

## Diff review

- [ ] No debug output, dump, or var_dump left in the diff.
- [ ] No hardcoded credentials, API keys, or secrets.
- [ ] No commented-out code blocks without a documented reason.
- [ ] No unrelated files modified.
- [ ] No sensitive data being logged.

## Artifacts

- [ ] Test results captured (which suite, which tests, pass/fail).
- [ ] Summary of changes and verification outcome saved.
