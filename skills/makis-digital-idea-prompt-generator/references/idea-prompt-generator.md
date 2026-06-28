# Idea & Prompt Generator — Reference

Detailed templates, patterns, and examples for each phase.

## Phase 1 — Idea generation templates

### Project idea template

```
Name: {NAME}
Description: {ONE_LINE}
Value prop: {WHO_NEEDS_IT_AND_WHY}

Core features:
1. {FEATURE_1}
2. {FEATURE_2}
3. {FEATURE_3}

Tech stack relevance: {HOW_IT_USES_THE_STACK}
Effort: {small|medium|large}
Risk: {low|medium|high} — {WHY}
```

### Feature idea template

```
Name: {NAME}
Parent project: {PROJECT}
Description: {ONE_LINE}

User story: As a {ROLE}, I want to {ACTION} so that {BENEFIT}.

Acceptance criteria:
1. {AC_1}
2. {AC_2}
3. {AC_3}

Depends on: {EXISTING_FEATURES}
Effort: {small|medium|large}
```

## Phase 2 — Refinement questions

For any chosen idea, answer:

1. **MVP scope** — what is the smallest useful version?
2. **Entities** — list all database entities and their relationships
3. **Routes** — list all endpoints
4. **Auth** — who can do what? (guest, user, admin)
5. **Validation** — what rules apply to each input?
6. **Edge cases** — empty state, error state, loading state, duplicate, deletion cascade
7. **Security** — CSRF, XSS, injection, rate limiting, file upload risks
8. **Testing** — what unit, integration, and E2E tests are needed?

## Phase 3 — Prompt templates

### Agent Central prompt (default)

```
Context: {EXISTING_PROJECT_DESCRIPTION}

Build a {FEATURE} for {PROJECT}.

Requirements:
- {REQ_1}
- {REQ_2}
- {REQ_3}

Stack: PHP {VERSION}, {FRAMEWORK}, {DB}, {FRONTEND}

Entities: {ENTITY_1} (fields: {FIELDS}), {ENTITY_2} (fields: {FIELDS})
Relationships: {RELATIONSHIPS}

Routes:
Method | Path | Auth | Description
GET | /{resource} | {auth} | List
POST | /{resource} | {auth} | Create
GET | /{resource}/{id} | {auth} | Show
PUT|PATCH | /{resource}/{id} | {auth} | Update
DELETE | /{resource}/{id} | {auth} | Delete

Validation rules:
- Field {X}: {rule}
- Field {Y}: {rule}

Security: CSRF on all state-changing forms, XSS-safe output, parameterized queries, {EXTRA}

Deliverables:
- Migration file
- Model with relationships
- Controller with validation
- Service layer
- Repository
- View templates (if applicable)
- Feature/unit tests
- Route definitions

After building, run: Load makis-digital-verification-loop and verify.
```

### Quick CRUD prompt

```
Load makis-digital-crud-refactor

Create CRUD for {ENTITY}.

Fields: {FIELD_LIST}
Validation: {RULES}
Auth: {WHO_CAN_ACCESS}

Generate: migration, model, controller, service, repository, tests, routes.
```

### Security review prompt

```
Load makis-digital-security-review

Audit {FILE_OR_ROUTE} for:
- CSRF protection
- Authentication gates
- XSS in output
- SQL injection in queries
- File upload safety
- Rate limiting
- Session security
```

### Bugfix prompt

```
Load makis-digital-test-first-bugfix

Bug: {DESCRIPTION}
Steps to reproduce: {STEPS}
Expected: {EXPECTED}
Actual: {ACTUAL}
Environment: {PHP_VERSION}, {FRAMEWORK_VERSION}, {DB}

Write a failing test first, then fix.
```

## Idea → prompt examples

### Example 1: Blog with AI summaries

**Input:** "I want a blog where posts get auto-summarized by AI"

**Phase 1 output:**
- Name: BlogPost AI
- Features: CRUD posts, markdown editor, AI summary on save, tag system, RSS feed
- Effort: Medium
- Risk: Low

**Phase 3 prompt:**
```
Context: Fresh Laravel 11 project with OpenAI SDK installed.

Build a blog post system with AI summary generation for {PROJECT}.

Requirements:
- CRUD for blog posts (title, slug, body, excerpt, status, tags)
- AI summary generated on post creation via OpenAI
- Tag system (many-to-many with posts)
- Markdown editor for post body
- Published/draft status
- Paginated public listing

Stack: PHP 8.3, Laravel 11, MySQL, Blade + Tailwind

Entities:
- Post (title, slug, body, excerpt, status, ai_summary, published_at)
- Tag (name, slug)
- PostTag (pivot)

Relationships: Post belongsToMany Tag

Routes:
GET  /admin/posts          — list (admin auth)
POST /admin/posts          — create (admin auth)
...

Validation:
- title: required, max:255, unique
- body: required
- status: in:draft,published

Security: admin auth middleware, CSRF on all forms, XSS-safe Blade output.

Deliverables: migration, Post model with relationships, Tag model, PostController, PostService, PostRepository, admin views, public index view, tests, routes.

After building, run: Load makis-digital-verification-loop and verify.
```

### Example 2: Order management for e-commerce

**Input:** "Order management dashboard for my shop"

**Phase 1 output:**
- Name: Order Manager
- Features: list orders, update status, refund, notes, customer email
- Effort: Medium
- Risk: Medium (payment data)

**Phase 3 security excerpt:**
```
Security: admin auth middleware, CSRF on status updates, rate limiting on refund actions, no raw SQL, audit log for status changes, PCI-safe (no card data stored).
```
