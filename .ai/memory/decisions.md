# Memory: Decisions

> Quick log of small-to-medium decisions with their reasoning — the ones too
> small for a formal ADR but too important to forget. Big decisions go through
> `templates/adr.md` → `DECISIONS.md` instead.

Format: `date — decision — why — alternatives rejected`

<!-- Example:
     - 2026-07-06 — Use UUIDs over auto-increment IDs — avoids enumeration and
       merge conflicts across environments — rejected: int IDs (leaks volume).
-->

- 2026-10-28 — Scripts stay plain Bash with no dependencies; tests are a plain
  Bash file — every project can run them with no install step — rejected:
  bats (extra dependency), Makefile (adds a tool for no gain).
- 2026-10-28 — `init.sh` refuses to run twice instead of offering `--force` —
  after the first run no placeholders remain, so a re-run could only damage
  the project — rejected: `--force` flag.
- 2026-07-06 — Project initialized from VOID AI OS template — standard
  engineering workflow across all projects — rejected: ad-hoc per-project setup.
