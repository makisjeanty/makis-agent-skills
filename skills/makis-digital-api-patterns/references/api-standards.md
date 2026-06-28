# API Standards

Conventions for `makis-digital` JSON API endpoints.

## URL structure

```
GET    /api/resource            list
POST   /api/resource            create
GET    /api/resource/{id}       read
PUT    /api/resource/{id}       update (full)
PATCH  /api/resource/{id}       partial update
DELETE /api/resource/{id}       delete
```

Nested resources: `/api/projects/{id}/tasks`.

## Response envelope

### Success (single)
```json
{
  "data": { "id": 1, "name": "Example" },
  "errors": []
}
```

### Success (list)
```json
{
  "data": [{ "id": 1 }, { "id": 2 }],
  "errors": [],
  "pagination": {
    "page": 1,
    "per_page": 20,
    "total": 42,
    "total_pages": 3
  }
}
```

### Validation error
```json
{
  "data": null,
  "errors": [
    { "field": "name", "message": "Name is required" }
  ]
}
```

### Auth / not-found error
```json
{
  "data": null,
  "errors": [
    { "message": "Authentication required" }
  ]
}
```

## HTTP status codes

| Code | When |
|---|---|
| 200 | Success (GET, PUT, PATCH) |
| 201 | Created (POST) |
| 204 | No content (DELETE) |
| 400 | Validation error |
| 401 | Missing or invalid auth |
| 403 | Authorized but not permitted |
| 404 | Resource not found |
| 429 | Rate limited |
| 500 | Internal server error |

## Pagination

- `page` starts at 1.
- `per_page` default 20, max 100.
- Response includes `pagination` object only for list endpoints.
- Invalid page values return 400 with a descriptive error.

## Versioning

- Prefix API routes with `/api/v1/`, `/api/v2/`.
- Bump version only for breaking contract changes.
- Maintain backward compatibility within a version.
- Deprecate old versions with a Sunset header and migration guide.
