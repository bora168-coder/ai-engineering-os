# Prompt: Implement

Use when starting implementation of a planned task.

---

Implement the following task: **[task name / link to tasks entry]**

Follow `WORKFLOW.md` strictly:

1. **Understand** — read the task's done-criteria, the relevant code, and any
   related `memory/` entries. Confirm the plan still matches reality.
2. **Plan** — list the files you will change and in what order. For anything
   architectural, stop and check `DECISIONS.md` — is there an approved ADR?
3. **Implement** — smallest coherent increments. Follow `STYLE_GUIDE.md`,
   `RULES.md`, and existing code patterns. Adopt the matching agent role from
   `agents/` (backend, frontend, database, …).
4. **Verify** — write/update tests per `TESTING.md`, run the suite, run linters,
   and exercise the changed behavior end-to-end. Show the results.
5. **Record** — update `tasks/`, `memory/`, `CHANGELOG.md`, and `docs/` as
   applicable. This is part of the task.

Constraints:
- Do not expand scope. New ideas go to `tasks/backlog.md`.
- If blocked or the plan proves wrong, stop and report — don't improvise around it.
