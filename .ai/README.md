# .ai/ — The Brain

This directory is the single source of truth for how AI assistants work on this
project. If you are an AI assistant reading this: **follow this file exactly.**

## Boot sequence

Read these files in this order before doing any work:

0. `providers/<your-tool>.md` — notes for the assistant you are (Claude, Codex,
   ChatGPT, Gemini, Copilot, Cursor). Not listed? Read `providers/README.md`.
1. `PROJECT.md` — what this project is, who it's for, what success means.
2. `ARCHITECTURE.md` — how the system is designed. Do not violate it.
3. `TECH_STACK.md` — the approved languages, frameworks, and tools.
4. `WORKFLOW.md` — how every task flows from idea to done.
5. `RULES.md` — non-negotiable engineering rules.
6. `memory/` — all five files. Knowledge from previous sessions lives here.
7. `ROADMAP.md` — where the project is going.
8. `tasks/sprint.md` and `tasks/todo.md` — the current state of work.

Consult as needed: `STYLE_GUIDE.md`, `TESTING.md`, `SECURITY.md`, `DECISIONS.md`.

## Your responsibilities

1. Understand the project before acting.
2. **Create an implementation plan before writing code. Never code before planning.**
3. Never change architecture without documenting the decision in `DECISIONS.md`.
4. Follow the coding standards in `STYLE_GUIDE.md` and rules in `RULES.md`.
5. After every completed task, update whichever of these changed:
   - `memory/` (new knowledge, resolved issues, new terms)
   - `tasks/` (move items: todo → completed; keep sprint.md accurate)
   - `ROADMAP.md` (progress against milestones)
   - `CHANGELOG.md` at the repo root (user-visible changes)
   - `docs/` (anything a human reader would now find stale)
6. Always work like a senior software engineer on a production project.

## Directory map

| Path | Purpose |
|---|---|
| `agents/` | Role definitions. Adopt the matching role for specialized work. |
| `prompts/` | Canonical prompts for recurring workflows (implement, debug, release, …). |
| `memory/` | Persistent knowledge base. Read at session start, update at task end. |
| `tasks/` | Backlog, sprint, todo, completed. The project's working state. |
| `providers/` | Per-assistant notes and the list of entry files (`CLAUDE.md`, `AGENTS.md`, …). |

## For humans

Everything here is plain Markdown under version control. Edit it like code:
review changes, keep it current, delete what's obsolete. A stale brain is worse
than no brain.
