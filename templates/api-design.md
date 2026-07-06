# API Design: [resource or capability]

- **Date:** YYYY-MM-DD
- **Status:** Draft | Approved | Implemented
- **Owner:** [agent/person]

## Purpose

What does this API let clients do, and who are the clients?

## Endpoints

### `METHOD /path/{param}`

- **Purpose:** …
- **Auth:** [required role/scope]
- **Request:**

```json
{ "field": "type — constraints" }
```

- **Response `200`:**

```json
{ "field": "type" }
```

- **Errors:** `400` [when], `401`/`403` [when], `404` [when], `409` [when]

<!-- Repeat per endpoint -->

## Conventions

- Pagination: …
- Filtering/sorting: …
- Versioning: …
- Idempotency: [which mutations are idempotent, how]

## Validation rules

| Field | Rules |
|---|---|
| … | … |

---
*When implemented: copy the final contract into `docs/api/` and keep it current.*
