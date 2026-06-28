# Expert Researcher — Reference

Detailed templates, patterns, and examples for each research mode.

## Phase 1 — Research question templates

### Codebase understanding

```
Mode: codebase-exploration
Question: How is the {FEATURE} implemented?
Depth: moderate
Scope: {DIRECTORY}

What I need:
- Which controller handles it?
- Which service/repository layer does it use?
- What routes are involved?
- How are errors handled?
```

### Technology choice

```
Mode: library-evaluation
Question: Should we use {LIBRARY} for {PURPOSE}?
Depth: deep
Scope: ecosystem-wide

Criteria:
- PHP version compatibility
- Active maintenance (commits in last 6 months)
- Known security issues
- Existing usage in our project (similar libs)
- Community size (stars, downloads)
- Documentation quality
```

### Bug/issue research

```
Mode: pattern-discovery
Question: Why is {BUG} happening in {COMPONENT}?
Depth: deep
Scope: {MODULE}

Hunt:
1. Find the error message in code
2. Trace the failing path
3. Find existing tests for this path
4. Search for similar bugfix patterns in the project
5. Check recent commits that touched this code
```

## Phase 2 — Evidence gathering scripts

### Full brownfield exploration

```bash
# 1. Project root structure
ls -la

# 2. Stack info
cat composer.json | grep -E '"require"|"require-dev"|"php"'

# 3. Routes
Grep for Route:: in routes/

# 4. Key controllers
ls app/Http/Controllers/

# 5. Models
ls app/Models/

# 6. Database
ls database/migrations/ | tail -5
```

### Pattern discovery

```bash
# Find how a specific pattern is implemented
search_graph --query "Find all Repository classes"
trace_path --function "UserController::store" --depth 2

# Find conventions
Grep for "interface" in app/Repositories/
Grep for "extends Controller" in app/Http/Controllers/
```

### Library evaluation checklist

- [ ] Packagist page — PHP version, dependencies, last release
- [ ] GitHub — stars, last commit, open/closed PR ratio
- [ ] Security — known advisories (`composer audit` equivalent)
- [ ] Alternatives — what else exists for the same purpose
- [ ] Integration — does it match our existing patterns (PSR compliance)?
- [ ] Test — does it have tests? Are they maintained?

## Phase 3 — Report templates

### Quick report

```markdown
## Research: {TOPIC}

The {FEATURE} is handled by {CLASS} in {FILE}.
It uses {PATTERN} and calls {DEPENDENCY}.
Tests are at {TEST_FILE}.

**Pattern:** {DESCRIPTION}
```

### Feature architecture report

```markdown
## Architecture: {FEATURE}

### Stack
- Framework: {FRAMEWORK}
- PHP version: {VERSION}
- Database: {DB}

### Data flow
Request → {CONTROLLER} → {SERVICE} → {REPOSITORY} → {MODEL}

### Key files
| File | Purpose |
|---|---|
| {FILE} | {PURPOSE} |

### Conventions used
- {CONVENTION_1}
- {CONVENTION_2}

### Gaps / risks
- {GAP_1}
```

### Library evaluation report

```markdown
## Library evaluation: {LIBRARY}

### Candidate
- Name: {NAME}
- Packagist: {URL}
- GitHub: {URL}
- Stars: {N}
- Last release: {DATE}
- PHP requirement: {VERSION}

### Current state in project
{DESCRIPTION_OF_EXISTING_USAGE_OR_ABSENCE}

### Comparison with alternatives
| Library | Stars | Maintenance | PHP req | Notes |
|---|---|---|---|---|

### Recommendation
{APPROVE|REJECT|NEEDS_MORE_RESEARCH}

Rationale: {REASONS}
```

## Example flows

### Example 1: Exploring a Laravel project

**Input:** "How does the project handle authentication?"

**Phase 1:**
```
Mode: codebase-exploration
Question: How is auth implemented?
Scope: auth, login, middleware
Depth: moderate
```

**Phase 2 findings:**
- Auth scaffolding: Laravel Breeze (found in composer.json)
- Middleware: `auth` and `admin` in Kernel.php
- Login handled by `Laravel\Fortify` (found via Grep for Fortify)
- Custom middleware at `app/Http/Middleware/AdminMiddleware.php`

**Phase 3 report:**
```
## Research: Authentication

Uses Laravel Breeze + Fortify.
Standard auth middleware for user routes.
Custom AdminMiddleware at app/Http/Middleware/AdminMiddleware.php.
Two-factor login configured.

Key files:
- config/fortify.php — Fortify configuration
- app/Http/Middleware/AdminMiddleware.php — admin gate
- routes/auth.php — auth routes
```

### Example 2: Evaluating a package

**Input:** "Should we use spatie/laravel-medialibrary for file uploads?"

**Phase 2 findings:**
- Packagist: 50M+ downloads, actively maintained
- PHP 8.1+, Laravel 9-11 support
- Last release: 2 months ago
- GitHub: 6k+ stars, 600+ forks
- current project: uses nothing for media, raw file handling in controllers
- Alternative: `plank/laravel-mediable` (1k stars, less active)
- Integration: PSR-4, service provider, Facades

**Phase 3:**
```
## Library evaluation: spatie/laravel-medialibrary

### Recommendation: APPROVE

Rationale: Most popular media library for Laravel, actively maintained,
PSR-compliant, well-documented. Replaces ad-hoc file handling.

Integration steps:
1. composer require spatie/laravel-medialibrary
2. php artisan vendor:publish --provider="Spatie\MediaLibrary\MediaLibraryServiceProvider" --tag="migrations"
3. php artisan migrate
4. Add HasMedia trait to models
5. Replace raw file upload code in controllers
```
