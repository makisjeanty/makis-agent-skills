---
name: makis-digital-expert-researcher
description: Specialist researcher for codebases, technologies, libraries, and architecture decisions. Investigates existing code, explores patterns, researches libraries and APIs, and produces evidence-backed recommendations before implementation. Use before any major implementation or integration decision.
license: MIT
metadata:
  maintainer: JEANMAKISJEANTY
  version: "0.1.0"
  scope: project-and-global
  environment: Designed for Codex and Agent Skills-compatible coding agents that need evidence before acting.
---

# Makis Digital Expert Researcher

Use this skill when you need to understand existing code, evaluate a library or API, or make an evidence-backed decision before implementing. Research first, then implement.

## Research modes

| Mode | When | Tools |
|---|---|---|
| **Codebase exploration** | New to a project, need to understand structure | Grep, Glob, Read, codebase-memory MCP |
| **Pattern discovery** | Need to find how things are done in this project | search_graph, trace_path, Grep by convention |
| **Library evaluation** | Choosing a package or SDK | Web search, README, Packagist, GitHub stats |
| **Architecture analysis** | Understanding why things are laid out as they are | codebase-memory MCP, directory traversal, config files |
| **Decision research** | Evidence for a choice (DB, pattern, approach) | Web search + codebase search + comparison |

## Core workflow

### Phase 1 — Define research question

Before searching, write down:

```
What I need to know: {QUESTION}
Why: {WHAT_DECISION_DEPENDS_ON_IT}
Scope: {FILE, MODULE, OR TECHNOLOGY}
Depth: {quick|moderate|deep}
```

### Phase 2 — Gather evidence

For **codebase research**:
1. Search for relevant files by name (`Glob`)
2. Search for relevant patterns (`Grep` for keywords, `search_graph` for definitions)
3. Read key files to understand conventions
4. Trace call chains if relevant (`trace_path`)
5. Check for existing similar implementations

For **library/technology research**:
1. Check Packagist / GitHub for the library
2. Read README for purpose and install
3. Check recent commits, stars, maintenance status
4. Search for known issues or security advisories
5. Check if the project already uses similar libraries

### Phase 3 — Synthesize report

```
## Research: {TOPIC}

### Summary
{3-5 line summary of findings}

### Evidence
- {SOURCE_1}: {FINDING}
- {SOURCE_2}: {FINDING}

### Recommendation
{clear recommendation with rationale}

### Risks
- {RISK_1}
- {RISK_2}
```

## Research patterns

### Exploring a brownfield project

```
1. Read directory structure (ls or Read on root)
2. Read composer.json → understand stack
3. Read config files → understand environment
4. Read key controllers → understand routing
5. Read key models → understand data model
6. Read routes file → understand endpoints
7. Report: stack summary + key patterns + pain points
```

### Finding how a feature is implemented

```
1. Search for feature keywords in routes
2. Search for feature keywords in controllers
3. Find the service/repository layer
4. Trace the data flow (controller → service → repository)
5. Find related tests
6. Report: architecture + data flow + test coverage
```

### Evaluating a new library

```
1. Find the package on Packagist
2. Check PHP version requirements
3. Check recent releases and maintenance
4. Check dependents/downloads
5. Read the README for integration patterns
6. Search the codebase for similar libraries already in use
7. Report: recommendation + integration guide
```

## Knowledge sources

| Source | When |
|---|---|
| `codebase-memory MCP search_graph` | Find functions, classes, routes by pattern |
| `codebase-memory MCP trace_path` | Understand call chains and data flow |
| `codebase-memory MCP get_architecture` | High-level project structure |
| `Glob + Grep` | String search when MCP is insufficient |
| `Web search` | Library evaluation, comparison, best practices |
| `composer.json` | Stack, dependencies, PHP version |
| `.env / .env.example` | Environment config |

## Autonomy levels

- **Quick** (single question) — search, answer, done
- **Moderate** (feature research) — explore codebase, check libraries, write mini-report
- **Deep** (architecture decision) — full investigation with multiple evidence sources, comparison, written recommendation

## References

- Read [references/expert-researcher.md](references/expert-researcher.md) for detailed templates and examples.
