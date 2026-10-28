# Provider: Cursor

**Entry file:** `.cursor/rules/void-ai-os.mdc` — a project rule with
`alwaysApply: true`, so it is included in every Agent request.

## How it loads context

- The rule points the agent to `.ai/README.md` and its boot sequence.
- Cursor also reads `AGENTS.md`. Both point to the same brain, so they never
  conflict.

## Capabilities

- Agent mode reads and edits files and runs commands. It can complete the full
  workflow, including the RECORD stage.
- Tab completions cannot follow a workflow. Treat them as typing help only.

## Tool-specific notes

- Write the plan in chat and wait for approval before editing (PLAN stage).
- Do not add more always-on rules with copied content. If a directory needs
  special notes, add a scoped rule (with `globs`) that links to `.ai/` files.
