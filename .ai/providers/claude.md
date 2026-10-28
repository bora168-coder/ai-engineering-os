# Provider: Claude (Claude Code)

**Entry file:** `CLAUDE.md` (repo root) — loaded automatically at session start.

## How it loads context

- Claude Code reads `CLAUDE.md` on start. Follow its boot sequence:
  `.ai/README.md` first, then everything it lists.
- Nested `CLAUDE.md` files in subdirectories are also loaded when Claude works
  there. Use them only for directory-specific notes, never for copies of rules.

## Capabilities

- Reads and edits files, runs shell commands, runs tests.
- Can complete the full workflow alone, including the RECORD stage.

## Tool-specific notes

- Use plan mode (or a written plan in chat) for the PLAN stage before editing.
- Use subagents only for large, separable research; the main session owns
  the plan and the RECORD stage.
- Keep personal preferences in your user-level `~/.claude/CLAUDE.md`, not in
  the project `CLAUDE.md`.
