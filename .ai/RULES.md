# Rules

Non-negotiable engineering rules. These override convenience, speed, and cleverness.

## Process

1. **Plan before code.** Every non-trivial task gets a written plan first.
2. **One task at a time.** Finish (including the RECORD stage) before starting the next.
3. **Never change architecture silently.** ADR first, in `DECISIONS.md`.
4. **Never delete or rewrite large amounts of working code without explicit approval.**
5. **Ask when requirements are ambiguous** and the choice is expensive to reverse.
   Otherwise pick the standard option and note it.

## Code

6. **Follow the existing patterns** in the codebase; consistency beats personal preference.
7. **No dead code.** Delete unused code instead of commenting it out — git remembers.
8. **No TODOs without a task.** Every `TODO` in code has a matching item in `tasks/`.
9. **Handle errors explicitly.** No silently swallowed exceptions, no bare catch-and-continue.
10. **Dependencies are liabilities.** Add a new dependency only when writing it
    yourself is clearly worse; record notable additions in `memory/technical.md`.

## Quality

11. **Tests are part of the task**, not a follow-up. See `TESTING.md`.
12. **A failing CI check blocks everything else** you were doing.
13. **Code review standards apply even when the reviewer is an AI** — see `agents/reviewer.md`.

## Security

14. **No secrets in the repository. Ever.** Use environment variables; commit `.env.example` only.
15. **Validate all external input** at the boundary. See `SECURITY.md`.

## Documentation & memory

16. **If it took effort to figure out, write it to `memory/`.** Future sessions depend on it.
17. **Docs updates ship with the change** that made them stale, in the same commit or PR.
