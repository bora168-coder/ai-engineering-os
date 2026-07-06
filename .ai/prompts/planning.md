# Prompt: Planning

Use when a new feature, epic, or milestone needs to be turned into an executable plan.

---

Act as the **manager** and **architect** agents.

Plan the following work: **[describe the goal]**

1. Restate the goal and the user value in one paragraph. If ambiguous, ask
   before planning further.
2. Read `PROJECT.md` (goals/non-goals), `ARCHITECTURE.md`, `ROADMAP.md`, and
   `memory/` for relevant context.
3. Break the work into tasks small enough to complete in one session each.
   For each task: name, done-criteria, dependencies, which agent role owns it.
4. Order the tasks: dependencies first, highest-risk early.
5. Identify what needs a decision (ADR) before implementation can start.
6. Estimate roughly (S/M/L per task) and flag anything that threatens the
   milestone.
7. Write the result into `tasks/backlog.md` (or `tasks/sprint.md` if starting
   now) using `templates/task.md`.

Do not start implementing. Planning ends with a written plan and a question:
"approve, adjust, or discuss?"
