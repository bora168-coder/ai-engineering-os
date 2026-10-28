# Provider: OpenAI (Codex and ChatGPT)

There are two ways to use OpenAI models with this project. They work differently.

## A. Codex (CLI, IDE extension, or cloud agent)

**Entry file:** `AGENTS.md` (repo root) — loaded automatically.

- Codex can read and edit files and run commands.
- Follow the boot sequence in `.ai/README.md` and the full workflow,
  including the RECORD stage.
- Show the plan in chat and wait for approval before editing (PLAN stage).

## B. ChatGPT (web or desktop chat)

**Entry file:** none. ChatGPT cannot see the repository by itself.

### Setup (once per project)

1. Create a ChatGPT **Project** for this repository.
2. Upload these files to the Project: `.ai/README.md`, `.ai/PROJECT.md`,
   `.ai/ARCHITECTURE.md`, `.ai/TECH_STACK.md`, `.ai/WORKFLOW.md`,
   `.ai/RULES.md`, and the files in `.ai/memory/` and `.ai/tasks/`.
3. Paste this into the Project instructions:

   ```
   You work on this project using VOID AI OS. The uploaded .ai/ files are the
   source of truth. Follow .ai/README.md and .ai/WORKFLOW.md exactly. You cannot
   edit files: give every change as a complete file or a unified diff, with its
   path. At the end of every task, list the RECORD-stage updates (memory, tasks,
   CHANGELOG, docs) as diffs too.
   ```

### Rules for chat-only use

- **The human applies all changes.** ChatGPT outputs full files or diffs with
  exact paths; the human copies them into the repo and commits.
- **Re-upload after changes.** Uploaded files are snapshots. When `.ai/`
  files change in git, upload the new versions, or ChatGPT works from stale state.
- **RECORD is still required.** ChatGPT must output the memory/tasks/changelog
  updates; the human must apply them. Skipping this breaks the next session.
