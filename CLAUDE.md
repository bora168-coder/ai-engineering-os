# {{PROJECT_NAME}}

This project runs on **VOID AI OS** — a version-controlled engineering workflow
that you are required to follow.

## Boot sequence (do this before anything else)

1. Read `.ai/README.md` and follow every instruction in it.
2. Read the core docs it lists, in order: `PROJECT.md`, `ARCHITECTURE.md`,
   `TECH_STACK.md`, `WORKFLOW.md`, `RULES.md`.
3. Read `.ai/memory/` — it contains knowledge from previous sessions.
4. Read `.ai/tasks/sprint.md` and `.ai/tasks/todo.md` for current state.
5. Continue from the current project state. Never start from scratch.

Claude-specific notes: `.ai/providers/claude.md`.

## Operating rules (summary — full rules in .ai/RULES.md)

- **Never code before planning.** Present a plan for any non-trivial task first.
- **Never change architecture silently.** Record decisions in `.ai/DECISIONS.md`
  using `templates/adr.md`.
- **After every completed task**, update whichever of these changed:
  `.ai/memory/`, `.ai/tasks/`, `.ai/ROADMAP.md`, `CHANGELOG.md`, and `docs/`.
- Work like a senior software engineer on a production project.

## Role and prompt libraries

- Acting on a specialized task? Adopt the matching role from `.ai/agents/`
  (e.g. `.ai/agents/reviewer.md` for code review).
- Common workflows have canonical prompts in `.ai/prompts/`
  (e.g. `.ai/prompts/debug.md` for bug fixing).
