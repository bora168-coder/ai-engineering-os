# .ai/ — The Brain (Token-Efficient)

This directory is the source of truth for AI-assisted engineering workflow.
Default behavior is **lazy-loading**: load only what the current task needs.

## Modes

### 1) Compact mode (default)

- Read this file first.
- Do **not** preload all core docs, memory files, prompts, or agents.
- Load files from the map below based on task type.

### 2) Full workflow mode (opt-in)

Use only when explicitly requested (or for high-risk/large changes):

- Follow `.ai/FULL_WORKFLOW.md`.

## Lazy-loading map (task → files to read)

| Task type | Read first | Load only if needed |
|---|---|---|
| Small bug/debug | `prompts/debug.md`, relevant code/files | `RULES.md`, `TESTING.md`, `memory/known-issues.md` |
| Code review / QA | `agents/reviewer.md` or `agents/qa.md` | `RULES.md`, `TESTING.md`, `SECURITY.md` |
| Database/data changes | `agents/database.md`, `templates/database.md` | `ARCHITECTURE.md`, `SECURITY.md`, `TESTING.md` |
| Architecture/design changes | `ARCHITECTURE.md`, `DECISIONS.md`, `templates/adr.md` | `TECH_STACK.md`, `ROADMAP.md`, relevant `docs/architecture/*` |
| Deployment/DevOps | `agents/devops.md`, `docs/deployment/README.md` | `SECURITY.md`, `TECH_STACK.md` |
| Documentation updates | target doc(s), `agents/documentation.md` | `PROJECT.md`, `WORKFLOW.md`, glossary memory |

## Always-on guardrails

1. Plan before non-trivial changes.
2. Inspect relevant code/docs before editing.
3. Run relevant tests/checks for changed behavior.
4. Never change architecture silently (use ADR + `DECISIONS.md`).
5. Update only files made stale by your task (not every tracking file by default).

## Directory map

| Path | Purpose |
|---|---|
| `agents/` | Role definitions for specialized work. |
| `prompts/` | Canonical prompts for common workflows. |
| `memory/` | Persistent knowledge; read selectively unless in full mode. |
| `tasks/` | Backlog, sprint, todo, completed state. |
