# {{PROJECT_NAME}}

Use **VOID AI OS** in token-efficient mode by default.

## Default mode: Compact (always)

1. Read `.ai/README.md` only.
2. Load only files needed for the current task (see lazy-loading map in `.ai/README.md`).
3. Do not preload entire directories (`.ai/memory/`, `.ai/agents/`, `.ai/prompts/`, `docs/`) unless the task requires them.

## Quality and safety requirements

- Plan before non-trivial changes.
- Inspect relevant code/docs before editing.
- Run relevant tests/checks after changes.
- Never change architecture silently: record decisions in `.ai/DECISIONS.md` via `templates/adr.md`.
- Update only affected state/docs files (not everything by default).

## Optional mode: Full workflow

When the user explicitly asks for **full workflow** (large/high-risk work), follow:

- `.ai/FULL_WORKFLOW.md`
