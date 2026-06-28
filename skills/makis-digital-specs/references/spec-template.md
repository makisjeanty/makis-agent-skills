# Spec Template

Use this template when writing a technical specification for `makis-digital`.

```markdown
## Feature: [name]

### Goal
[One sentence describing the feature and its value.]

### Routes / Endpoints
| Method | Path | Auth | Description |
|---|---|---|---|
| GET | /feature | Public/Admin | List/view |
| POST | /feature | CSRF/JWT | Create |
| POST | /feature/{id}/edit | CSRF/JWT | Update |
| POST | /feature/{id}/delete | CSRF/JWT | Delete |

### Data model
| Field | Type | Required | Default | Notes |
|---|---|---|---|---|
| id | int | yes | auto | primary key |
| name | string | yes | — | max 255 chars |
| status | enum | yes | draft | active/inactive/draft |
| created_at | datetime | yes | now | — |

### Controllers
- `src/Controllers/<Feature>Controller.php` — new controller
- Methods: index, create, show, edit, delete

### Services
- `src/Services/<Feature>Service.php` — business rules
- Validation rules, status transitions, ownership checks

### Repositories
- `src/Repositories/<Feature>Repository.php` — CRUD operations
- `findByStatus`, `findOwnedBy`, pagination support

### Views / Responses
- `views/feature/index.php` — listing with pagination
- `views/feature/show.php` — detail view
- `views/feature/form.php` — create/edit form
- API returns JSON with `{data, errors, pagination}` envelope

### Security
- Auth: login required for all mutations
- Authorization: admin for delete, owner for edit
- CSRF: all browser forms
- Validation: allow-list on status field, max length on strings
- Output: HTML escaped in views, JSON encoded in API

### Testing scope
- Unit: validation rules, status transitions
- Integration: CRUD via HTTP, auth bypass attempts
- Edge cases: empty list, invalid status, non-existent id
```

## Example: Small feature spec

### Feature: User profile editing

**Goal:** Allow logged-in users to edit their own display name and bio.

**Route:** `POST /profile/edit` — requires CSRF, current password confirmation.

**Fields:** display_name (string, max 100), bio (text, max 500).

**Controller:** `ProfileController` — new method or existing edit handler.

**Service:** `ProfileService::updateProfile($userId, $data)` — validates, sanitizes, saves.

**Repository:** `UserRepository::update($id, $data)` — updates user record.

**View:** `views/profile/form.php` — pre-filled form with current values.

**Security:** Auth required, CSRF on form, XSS-safe output, current password confirmation.
