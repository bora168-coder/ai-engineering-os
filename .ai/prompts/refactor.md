# Prompt: Refactor

Use when improving code structure without changing behavior.

---

Refactor target: **[file / module / pattern]**
Motivation: **[why — duplication, complexity, upcoming feature needs it, …]**

Rules of engagement:

1. **Behavior must not change.** If you find a bug while refactoring, file it
   (`templates/bug-report.md`) — fixing it here hides it in the diff.
2. **Tests first.** Confirm existing test coverage of the target. If coverage is
   too thin to prove behavior is preserved, write characterization tests before
   touching anything.
3. Plan the refactor as a sequence of small, individually-safe steps. Commit
   after each step with the suite green.
4. Stay in scope: only the named target. Adjacent temptations go to
   `tasks/backlog.md`.
5. Respect `ARCHITECTURE.md` — a refactor that moves boundaries is an
   architecture change and needs an ADR first.
6. Verify: full suite green, no public API/contract changes (or they were
   explicitly approved), diff reviewed with `prompts/review.md`.
7. Record: `memory/technical.md` if the new structure changes how future code
   should be written; docs updated if structure docs exist.

Success = the diff is boring and everything still works.
