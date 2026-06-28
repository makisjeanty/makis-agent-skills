# Makis Agent Skills

Reusable local skill repository for Codex and Agent Skills-compatible coding agents.

## Included skills

- `makis-digital-dev-rules`
  Umbrella skill with reusable engineering rules for architecture, security, testing, and delivery.
- `makis-digital-crud-refactor`
  CRUD reorganization with thin controllers, services, repositories, and safe incremental changes.
- `makis-digital-security-review`
  Security review and hardening for validation, CSRF, auth, output escaping, and upload safety.
- `makis-digital-test-first-bugfix`
  Test-first bugfix workflow for regressions and risky fixes.
- `makis-digital-ai-integration`
  AI SDK integration with secure wrappers, structured output, and error handling.
- `makis-digital-database-patterns`
  Persistence layer design, repository patterns, query organization, and migration workflows.
- `makis-digital-verification-loop`
  Post-change verification for builds, tests, security, and diffs before closing tasks.
- `makis-digital-agent-central`
  Central orchestrator that analyzes tasks and chains the right specialized skills.
- `makis-digital-memory`
  Project knowledge capture — decisions, patterns, and architecture rationale across sessions.
- `makis-digital-specs`
  Requirements-to-specs translator for structured technical specifications before coding.
- `makis-digital-api-patterns`
  REST API design with consistent envelopes, authentication, pagination, and error responses.
- `makis-digital-error-handling`
  Typed exceptions, safe user-facing messages, structured logging context, and consistent failure modes.
- `makis-digital-testing-strategy`
  Test planning at unit, integration, and e2e levels with coverage priorities and decision trees.
- `makis-digital-frontend-patterns`
  PHP view templates, form handling, JavaScript organization, and accessible markup conventions.
- `makis-digital-deployment`
  Build, release, health checks, environment config, and rollback procedures.
- `makis-digital-logging-observability`
  PSR-3 structured logging with appropriate levels, context enrichment, and security-aware practices.
- `makis-digital-dependency-management`
  Composer workflows, update strategies, security auditing, and version policies.

## Repository layout

- `skills/`
  Self-contained skills with `SKILL.md`, agent metadata, references, and embedded knowledge.
- `CATALOG.md`
  Quick map of skills and starter bundles.
- `WORKFLOWS.md`
  Ordered playbooks for common work patterns.
- `scripts/sync-to-codex.ps1`
  Copies all repository skills into `~/.codex/skills` (PowerShell, Windows / Codex).
- `scripts/sync-to-claude.sh`
  Copies all repository skills into `~/.claude/skills` (Bash, Linux / Claude Code).
- `scripts/sync-to-ecc.sh`
  Copies catalog and workflows into `~/.claude/skills/ecc` for ECC integration.
- `scripts/skill-scaffold.sh`
  Generates a new skill skeleton with SKILL.md, agent metadata, and reference files.
- `scripts/validate-skills.py`
  Validates skill frontmatter and required files for CI and local checks.
- `scripts/validate-markdown-links.py`
  Validates relative Markdown links so skill docs and references do not drift.

## Install or sync

### To Codex (Windows)

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\sync-to-codex.ps1
```

### To Claude Code (Linux)

```bash
bash scripts/sync-to-claude.sh
```

Restart your agent tool so newly installed or updated skills are picked up.

## Create a new skill

```bash
bash scripts/skill-scaffold.sh makis-digital-my-new-skill --description "What this skill does"
```

## Quick commands

```bash
make validate          # Validate all skills
make validate-links   # Validate markdown links
make validate-all     # Both validations
make sync-claude      # Sync to ~/.claude/skills
make sync-ecc         # Sync to ECC catalog
make scaffold NAME=x DESC="..."  # Scaffold a new skill
```

## Project files

- `SKILL.md` — skill instructions
- `agents/openai.yaml` — agent metadata
- `references/` — detailed patterns and playbooks
- `references/knowledge/` — shared project knowledge
- `agents/` — reusable Claude Code agents (`makis-dev-agent`, `makis-security-agent`)
- `.editorconfig` — editor consistency
- `Makefile` — automation shortcuts
- `CONTRIBUTING.md` — how to add skills
- `.github/ISSUE_TEMPLATE/` — issue templates for skills and bugs
- `.github/PULL_REQUEST_TEMPLATE.md` — PR template

## Validate locally

Run:

```powershell
python .\scripts\validate-skills.py
python .\scripts\validate-markdown-links.py
```

The same validations run in GitHub Actions on push and pull request.
