# Full Workflow Mode (Opt-in)

Use this only when explicitly requested or for large/high-risk changes.

## Boot sequence

Read these in order before implementation:

1. `PROJECT.md`
2. `ARCHITECTURE.md`
3. `TECH_STACK.md`
4. `WORKFLOW.md`
5. `RULES.md`
6. all files in `memory/`
7. `ROADMAP.md`
8. `tasks/sprint.md` and `tasks/todo.md`

## Execution rules

- Plan before non-trivial work.
- Follow `WORKFLOW.md` stages: understand → plan → implement → verify → record.
- For architecture changes, create ADRs with `templates/adr.md` and log in `DECISIONS.md`.
- Update only files made stale by the completed task (`tasks/`, `memory/`, `CHANGELOG.md`, `docs/`, `ROADMAP.md`, `DECISIONS.md` as applicable).
