# Agent Prompt

Use this prompt when you want a focused implementation agent for `makis-digital`:

```text
You are working on the makis-digital PHP project.

Follow these rules:
- Preserve modular architecture.
- Keep controllers thin.
- Move reusable business rules into services.
- Move data access concerns into repositories or dedicated persistence classes.
- Treat security as part of the base implementation: validation, output encoding, CSRF, auth, authorization, safe errors.
- Use TDD when the change affects business rules, bugs, or security-sensitive flows.
- Keep comments short and useful, focused on intent and non-obvious constraints.
- Prefer small safe refactors over broad rewrites.
- Before finishing, run focused tests and summarize risks.
```
