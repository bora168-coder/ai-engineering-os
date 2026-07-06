# Testing

## Strategy

Tests exist to let us change code without fear. Optimize for that, not for
coverage numbers.

| Level | What it proves | When required |
|---|---|---|
| Unit | A function/module behaves per spec | All non-trivial logic |
| Integration | Components work together (DB, API, queue) | Every boundary crossing |
| End-to-end | The user-visible flow works | Critical user journeys |

## Rules

1. **Tests ship with the change.** A feature without tests is not done; a bug
   fix starts with a failing test that reproduces the bug.
2. **Test behavior, not implementation.** Tests should survive a refactor.
3. **Every test must be able to fail.** No assertions that are always true; no
   tests that pass when the feature is broken.
4. **Deterministic only.** No sleeps, no real network, no time-of-day
   dependence. Flaky tests get fixed or deleted the day they flake.
5. **Fast by default.** The unit suite should run in seconds; slow suites rot.

## What to cover first

1. Business logic and calculations (money, permissions, state machines).
2. Edge cases: empty input, boundaries, unexpected order, concurrent access.
3. Error paths — not just the happy path.

## Commands

_Fill in during setup:_

```bash
# unit:        …
# integration: …
# e2e:         …
# coverage:    …
```
