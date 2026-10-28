# Memory: Technical

> Hard-won technical knowledge: gotchas, non-obvious behaviors, why things are
> the way they are. If it took effort to figure out, it belongs here (RULES.md #16).
> Every entry gets a date. Delete entries that stop being true.

## Gotchas & non-obvious behavior

<!-- Example:
     - 2026-07-06 — The payment webhook fires twice on retries; handler must be
       idempotent (dedupe on event_id). Cost us a day to find.
-->

- _none yet_

## Why it's built this way

<!-- Context behind non-obvious implementation choices that don't warrant a full ADR. -->

- 2026-10-28 — Entry files (`CLAUDE.md`, `AGENTS.md`, `GEMINI.md`,
  `.github/copilot-instructions.md`, `.cursor/rules/void-ai-os.mdc`) stay thin and
  point to `.ai/`. Edit rules in `.ai/`, never in an entry file, or tools drift
  apart (ADR-0001). `scripts/validate.sh` fails if an entry file stops
  referencing `.ai/README.md`.

## Dependency notes

<!-- Notable dependencies: why chosen, version pins, upgrade landmines. -->

- _none yet_

## Environment & tooling

<!-- Local setup quirks, CI peculiarities, "works on my machine" resolutions. -->

- 2026-10-28 — `scripts/*.sh` must run on macOS's default Bash 3.2 and BSD
  `sed`: no associative arrays, no `mapfile`, no `sed -i` (use `sed_in_place`
  from `scripts/lib.sh`). Escape user input with `sed_escape` before using it
  in a sed replacement — `&`, `|`, and `\` broke the old init.
- 2026-10-28 — `tests/scripts.test.sh` copies the working tree (tracked + new
  files) into a temp git repo per test, so tests never touch the real checkout.
  CI runs it plus `shellcheck -x scripts/*.sh tests/*.sh`.
