# Security Baseline

- CSRF is present for browser forms.
- Session bootstrap, auth, validation, output encoding, rate limiting, and JWT support already exist.
- Current reviews should preserve those controls and add denial-path tests where missing.
