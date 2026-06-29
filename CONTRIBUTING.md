# Contributing

Thanks for contributing to `makis-agent-skills`!

## Setup (run once after cloning)

```bash
make install-hooks
pip install -r requirements-dev.txt
```

This installs a pre-commit hook that automatically runs `validate-all` and the
Python test suite (with 100% coverage check) before every commit. Shell tests
also run if `bats` is available.

## Adding a new skill

1. **Scaffold** the skill structure:
   ```bash
   make scaffold NAME=my-new-skill DESC="What it does"
   # or: bash scripts/skill-scaffold.sh makis-digital-my-new-skill --description "..."
   ```

2. **Edit** `skills/makis-digital-my-new-skill/SKILL.md`:
   - Keep the workflow focused and concrete.
   - Add `## Knowledge loading`, `## Workflow`, `## Rules`, `## Gotchas` sections.
   - Reference the shared knowledge files under `references/knowledge/`.

3. **Add a reference file** at `references/<topic>.md` with detailed patterns.

4. **Register the skill** in these files:
   - `CATALOG.md` — add to Core skills and add a starter bundle if appropriate.
   - `skills/makis-digital-dev-rules/references/skill-catalog.md` — same as CATALOG.
   - `skills/makis-digital-dev-rules/SKILL.md` — add to Specialized skills section.

5. **Validate**:
   ```bash
   make validate-all
   ```

## Skill structure

```
skills/makis-digital-<name>/
  SKILL.md              # Main skill file (required)
  agents/
    openai.yaml         # Agent metadata (required)
  references/
    <name>.md           # Detailed reference content
    knowledge/          # Shared project knowledge (copied from dev-rules)
```

## Naming conventions

- Skill directory name: `makis-digital-<hyphenated-name>`.
- `SKILL.md` `name` field must match the directory name.
- Reference files use the topic name without the `makis-digital-` prefix.

## Quality checklist

- [ ] SKILL.md has valid YAML frontmatter with `name`, `description`, `license`, `metadata`.
- [ ] `agents/openai.yaml` exists with `display_name`, `short_description`, `default_prompt`.
- [ ] All relative markdown links resolve to existing files.
- [ ] The skill is registered in CATALOG.md and dev-rules references/skill-catalog.md.
- [ ] `make validate-all` passes.
- [ ] `make test` passes (any change to a script in `scripts/` must include a corresponding test).

## Updating knowledge files

The four shared knowledge files (`architecture-current.md`, `decisions.md`,
`security-baseline.md`, `crud-projects-pattern.md`) live in
`skills/makis-digital-dev-rules/references/knowledge/` and are propagated to
all other skills. After editing them, run:

```bash
make sync-knowledge
```

Skills with a `.no-sync` marker (e.g. `makis-digital-test-first-bugfix`) have
intentionally customised knowledge files and are skipped automatically.

## Pull request process

1. Run `make validate-all && make test` before opening a PR.
2. Keep PRs focused on one skill or logical group of changes.
3. Reference any issues the PR addresses.
