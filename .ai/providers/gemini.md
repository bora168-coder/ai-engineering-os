# Provider: Gemini (Gemini CLI)

**Entry file:** `GEMINI.md` (repo root) — loaded automatically by Gemini CLI.

## How it loads context

- Gemini CLI loads `GEMINI.md` files from the project root and its parents,
  and from subdirectories it works in. Follow the boot sequence in
  `.ai/README.md`.
- Gemini CLI can also be configured to read `AGENTS.md` instead (via the
  `context.fileName` setting). Either file works; both point to the same brain.

## Capabilities

- Reads and edits files and runs shell commands (with user approval).
- Can complete the full workflow alone, including the RECORD stage.

## Tool-specific notes

- Gemini in a browser chat (gemini.google.com) cannot see the repository.
  Use the chat-only workflow in `chatgpt.md` (section B) instead.
- Write the plan in chat and wait for approval before editing (PLAN stage).
