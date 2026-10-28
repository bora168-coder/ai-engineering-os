# Copilot instructions — {{PROJECT_NAME}}

This project runs on **VOID AI OS**. The rules live in `.ai/`, not here.

Before any non-trivial task (agent mode or coding agent):

1. Read `.ai/README.md` and follow its boot sequence.
2. Read `.ai/providers/copilot.md` for Copilot-specific notes.
3. Plan before code. Never change architecture without an ADR in `.ai/DECISIONS.md`.
4. After the task, update `.ai/memory/`, `.ai/tasks/`, `CHANGELOG.md`, and `docs/`
   as described in `.ai/WORKFLOW.md` (RECORD stage).

Always: follow `.ai/RULES.md` and `.ai/STYLE_GUIDE.md`. Never commit secrets.
