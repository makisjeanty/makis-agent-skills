---
name: makis-digital-dev-rules
description: Reusable engineering rules for the makis-digital project. Use when Codex or another agent is asked to add features, refactor modules, harden security, organize architecture, write tests, define coding standards, or create implementation plans for this PHP codebase.
license: MIT
metadata:
  maintainer: JEANMAKISJEANTY
  version: "0.1.0"
  scope: project-and-global
  environment: Designed for Codex and Agent Skills-compatible coding agents working on PHP application codebases. No special system packages required.
---

# Makis Digital Dev Rules

Use this skill as the default delivery standard for work inside `makis-digital`. Use it as the umbrella skill when the task spans multiple concerns or when you first need to choose the right specialized skill.

## Core workflow

1. Read the affected route, controller, view, data access, and tests before editing.
2. Find the real source of the problem before changing code.
3. Keep each layer focused on one responsibility.
4. Add or update tests for business rules, regressions, and security-sensitive behavior.
5. Prefer small safe refactors over large rewrites unless the task explicitly requires broader change.
6. Extract reusable rules from real project work instead of inventing generic guidance.
7. Produce artifacts for meaningful work so future reviews can verify what changed.

## Knowledge loading

- Read `references/knowledge/architecture-current.md` when orienting yourself in the codebase.
- Read `references/knowledge/decisions.md` before making structural changes or moving implementation targets.
- Read `references/knowledge/security-baseline.md` when the task touches auth, validation, output, CSRF, sessions, uploads, or APIs.
- Read `references/knowledge/crud-projects-pattern.md` when the task touches the `projects` flow.

## Skill authoring rules

- Keep the skill grounded in real `makis-digital` tasks, fixes, reviews, and refactors.
- Keep `SKILL.md` concise and move deeper material into `references/`.
- Add project-specific gotchas when an agent makes a mistake that should not repeat.
- Prefer defaults over long option menus.
- Use validation loops for risky or multi-step changes.

Read [references/external-patterns.md](references/external-patterns.md) for the patterns adopted from Agent Skills and Anthropic references.

## Architecture rules

- Keep controllers thin: parse input, call a service or repository, choose the response.
- Keep business rules in services or dedicated domain classes.
- Keep persistence details in a repository or database-focused layer.
- Keep security logic centralized under `src/Security` or another dedicated security module.
- Keep views passive: render escaped data and avoid business decisions.
- Avoid hidden coupling between controllers, views, and storage format.

Read [references/architecture-rules.md](references/architecture-rules.md) when designing or refactoring modules.

## Security baseline

- Validate every external input with explicit allow-lists and length limits.
- Escape every dynamic output in HTML, attributes, URLs, and JSON contexts.
- Require CSRF protection for state-changing browser forms.
- Require authentication and authorization checks close to protected actions.
- Fail safely: return controlled errors, log details internally, do not leak internals to users.
- Prefer secure defaults over optional security.

Read [references/security-rules.md](references/security-rules.md) for the project security checklist.

## Testing and TDD

- Use TDD for new business rules, bug fixes, and security-sensitive flows when practical.
- Write a failing test first for a bug or invariant when the behavior is clear.
- Add focused unit tests for pure logic and targeted integration tests for request flow and persistence.
- Do not trust manual testing alone for CRUD, auth, validation, or routing changes.

Read [references/testing-playbook.md](references/testing-playbook.md) before starting a non-trivial change.

## Delivery rules

- Prefer explicit names over abbreviations.
- Prefer small methods with one reason to change.
- Add comments only for intent, invariants, or non-obvious tradeoffs.
- Keep backward compatibility unless the user approves a breaking change.
- Leave the touched area cleaner than before, but do not refactor unrelated modules opportunistically.
- Choose autonomy deliberately: low for risky mutations, higher only for well-understood repetitive work.
- Save reusable project patterns after successful changes so future agents can apply them consistently.

## Project resources

- Use [references/project-rules.md](references/project-rules.md) for the project-wide working agreement.
- Use [references/module-blueprint.md](references/module-blueprint.md) when creating or reorganizing CRUD modules.
- Use [references/agent-prompt.md](references/agent-prompt.md) when you want a reusable prompt for a focused implementation agent.
- Use [references/anthropic-php-sdk-notes.md](references/anthropic-php-sdk-notes.md) when integrating Claude capabilities into this PHP project.
- Use [references/skill-catalog.md](references/skill-catalog.md) to choose the right local skill or starter bundle.
- Use [references/workflows.md](references/workflows.md) for ordered execution playbooks.

## Specialized skills

- Use `$makis-digital-agent-central` as the first skill when the task scope is unclear or spans multiple concerns.
- Use `$makis-digital-specs` to translate requirements into technical specifications before coding.
- Use `$makis-digital-crud-refactor` for CRUD reorganization and modularization.
- Use `$makis-digital-security-review` for security review and hardening work.
- Use `$makis-digital-test-first-bugfix` for regressions and bug fixes with TDD.
- Use `$makis-digital-ai-integration` for AI SDK integration with secure wrappers.
- Use `$makis-digital-database-patterns` for persistence and query design.
- Use `$makis-digital-memory` to capture decisions and reusable patterns.
- Use `$makis-digital-verification-loop` for post-change verification.
- Use `$makis-digital-api-patterns` for REST API design and contracts.
- Use `$makis-digital-error-handling` for consistent exception and error patterns.
- Use `$makis-digital-testing-strategy` to plan test coverage levels.
- Use `$makis-digital-frontend-patterns` for PHP views, forms, and frontend conventions.
- Use `$makis-digital-deployment` for build, release, and environment workflows.
- Use `$makis-digital-logging-observability` for structured logging practices.
- Use `$makis-digital-dependency-management` for Composer and package workflows.
