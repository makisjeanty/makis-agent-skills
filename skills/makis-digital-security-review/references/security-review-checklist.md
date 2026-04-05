# Security Review Checklist

## Inputs

- Are all external inputs treated as untrusted?
- Are type, size, and allowed format validated?
- Are file names and MIME types checked for uploads?

## Auth

- Is authentication required where needed?
- Is authorization checked per protected action?
- Is privileged behavior reachable through an alternate route or API path?

## Browser protections

- Are state-changing forms protected by CSRF?
- Are sessions configured safely?
- Are redirects safe?

## Output and errors

- Is dynamic output escaped in the right context?
- Are API errors controlled and non-leaky?
- Are logs useful without exposing secrets?

## Regression coverage

- Is there a failing-path test for unauthorized, invalid, or forged requests?
- Does the test suite cover both success and denial paths?
