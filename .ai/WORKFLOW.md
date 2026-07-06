# Workflow

Every task — feature, bug fix, refactor — flows through the same five stages.
No stage may be skipped. Prompts for each stage live in `prompts/`.

## The loop

```
UNDERSTAND → PLAN → IMPLEMENT → VERIFY → RECORD
```

### 1. Understand

- Read the task definition (`tasks/`, issue, or user request).
- Read relevant `memory/` entries and existing code before proposing anything.
- If requirements are ambiguous, ask — do not guess on decisions that are
  expensive to reverse.

### 2. Plan

- Write an implementation plan: what changes, which files, in what order,
  what could break, how it will be tested.
- For architectural changes, draft an ADR (`templates/adr.md`) first and get it
  approved before implementation.
- Small fixes need a small plan (2–3 sentences), not a ceremony. Scale the
  planning to the risk.

### 3. Implement

- Work in small, coherent increments that could each be reviewed alone.
- Follow `RULES.md`, `STYLE_GUIDE.md`, and the existing patterns in the codebase.
- Keep the plan updated if reality diverges from it.

### 4. Verify

- Write/update tests per `TESTING.md`. Run the full relevant test suite.
- Exercise the changed behavior end-to-end, not just unit tests.
- Run linters/formatters. A task with failing checks is not done.

### 5. Record

Update everything the task made stale — this is part of the task, not optional cleanup:

- [ ] `tasks/` — move the item to `completed.md`, update `sprint.md`
- [ ] `memory/` — new technical knowledge, decisions, known issues, glossary terms
- [ ] `CHANGELOG.md` — user-visible changes
- [ ] `docs/` — anything a reader would now find wrong
- [ ] `ROADMAP.md` — milestone progress
- [ ] `DECISIONS.md` — if an architectural decision was made

## Git conventions

- Branch per task: `feature/<slug>`, `fix/<slug>`, `refactor/<slug>`, `docs/<slug>`.
- [Conventional Commits](https://www.conventionalcommits.org/): `feat:`, `fix:`,
  `refactor:`, `docs:`, `test:`, `chore:`.
- Commits are small and atomic; the message body explains *why*.
- Never commit directly to `main` once the project has users.

## Definition of Done

A task is done when: code merged, tests green, docs and memory updated,
changelog entry written, task moved to `completed.md`.
