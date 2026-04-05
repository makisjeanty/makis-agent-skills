# External Patterns Adopted

This file records the external references that shape this skill so we do not recreate conventions from scratch.

## Agent Skills format

Adopt these patterns from Agent Skills:

- A skill is a folder centered on `SKILL.md`.
- Keep metadata precise so activation is reliable.
- Use progressive disclosure: keep core instructions in `SKILL.md`, move deeper material to `references/`, scripts, or assets.
- Prefer concise, reusable procedures over generic best-practice prose.

## Skill writing patterns

Adopt these authoring rules:

- Start from real expertise and project artifacts.
- Capture corrections from real usage as reusable instructions.
- Add gotchas for non-obvious mistakes agents are likely to repeat.
- Provide a default approach first and mention alternatives only when needed.
- For multi-step work, use plan -> validate -> execute.

## Agent-first patterns

Adopt these operating patterns from Antigravity-style agent workflows:

- Prefer verifiable artifacts over opaque execution.
- Adjust autonomy by risk level instead of treating all tasks the same.
- Save useful patterns, architecture decisions, and debugging outcomes as reusable knowledge.
- Break larger work into smaller scoped tasks or chained agents when verification would otherwise be weak.

## How this affects makis-digital

- Keep this skill tied to the actual PHP project structure and conventions.
- Extract rules from real bugs, review feedback, and refactors in this repository.
- Add focused reference files instead of growing one giant skill file.

## Current external sources

- Agent Skills overview: https://agentskills.io/what-are-skills
- Agent Skills best practices: https://agentskills.io/skill-creation/best-practices
- Agent Skills specification: https://agentskills.io/specification
- Anthropic skills repository: https://github.com/anthropics/skills
- Antigravity documentation hub: https://antigravity.im/documentation
- Antigravity agents guide: https://antigravity.im/agents
