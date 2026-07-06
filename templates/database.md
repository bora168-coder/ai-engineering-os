# Database Design: [feature or domain area]

- **Date:** YYYY-MM-DD
- **Status:** Draft | Approved | Implemented
- **Migration:** [file/id once written]

## Purpose

What data does this store and which features depend on it?

## Tables / collections

### `table_name`

| Column | Type | Constraints | Notes |
|---|---|---|---|
| id | … | PK | … |
| … | … | NOT NULL / FK → … / UNIQUE | … |

Indexes:

| Index | Columns | Why (which query) |
|---|---|---|
| … | … | … |

<!-- Repeat per table -->

## Relationships

- `a` 1—N `b` (FK `b.a_id`, on delete: cascade/restrict — say which and why)

## Invariants

Rules the schema must enforce (constraints preferred over app code):

- …

## Data lifecycle

- Growth expectation: …
- Retention/archival/deletion: …
- Sensitive fields (see `SECURITY.md` data classification): …

## Migration plan

- Order of operations, backfill strategy, and rollback path.
- Safe on live data? [locking, table rewrite risk]

---
*When implemented: update `docs/database/` schema docs.*
