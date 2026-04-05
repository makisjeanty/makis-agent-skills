# Security Rules

## Input handling

- Treat all `$_GET`, `$_POST`, `$_FILES`, headers, cookies, and JSON bodies as untrusted.
- Validate type, length, format, and allowed values.
- Reject invalid data early.

## Output handling

- Escape HTML body content.
- Escape HTML attributes separately.
- Escape URLs separately.
- Encode JSON with safe flags when returning APIs.

## Auth and authorization

- Authenticate before protected actions.
- Authorize per action, not only per page.
- Keep permission checks close to mutations and privileged reads.

## Browser security

- Protect every state-changing form with CSRF.
- Use secure session settings.
- Prefer POST, PUT, DELETE for mutations and GET only for safe reads.

## File and storage safety

- Sanitize file names.
- Validate MIME type and extension for uploads.
- Keep uploads outside executable paths when possible.
- Never trust client-provided file metadata alone.

## Error handling and logging

- Show generic errors to users.
- Log enough detail for debugging.
- Never expose secrets, stack traces, or filesystem details in production responses.

## Security checklist for every change

- What new inputs were introduced?
- What can an unauthenticated actor do?
- What can an authenticated but unauthorized actor do?
- What data leaves the system, and is it escaped?
- What state changes occur, and are they protected?
