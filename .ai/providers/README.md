# Providers — Multi-Assistant Support

VOID AI OS works with more than one AI assistant. All of them share the same
brain (`.ai/`). Only the **entry file** and a few tool-specific notes differ.

## How it works

```
Assistant starts ──▶ its entry file (auto-loaded) ──▶ .ai/README.md ──▶ boot sequence
                                       └──────────▶ .ai/providers/<name>.md (tool notes)
```

- **Entry file** — a short file at the path the tool loads by itself. It only
  points to `.ai/README.md` and to the provider file. Keep it thin.
- **Provider file** — notes for one assistant: how it loads context, what it
  can and cannot do, and how it completes the RECORD stage.
- **Shared rules** — everything else lives once in `.ai/`. Never copy rules
  into entry files; copies drift.

## Supported assistants

| Assistant | Entry file (auto-loaded) | Provider file | Can edit repo files? |
|---|---|---|---|
| Claude Code | `CLAUDE.md` | `claude.md` | Yes |
| OpenAI Codex / ChatGPT | `AGENTS.md` (Codex) · manual prompt (ChatGPT web) | `chatgpt.md` | Codex: yes · ChatGPT web: no |
| Gemini CLI | `GEMINI.md` | `gemini.md` | Yes |
| GitHub Copilot | `.github/copilot-instructions.md` | `copilot.md` | Yes (agent mode / coding agent) |
| Cursor | `.cursor/rules/void-ai-os.mdc` | `cursor.md` | Yes |
| Any other assistant | none — paste the generic prompt below | — | Depends |

`AGENTS.md` is an open convention. Several tools besides Codex read it, so it
is also the fallback entry file for assistants not listed here.

## Generic boot prompt

For any assistant without an entry file, start the session with:

```
Read .ai/README.md. Follow every instruction. Continue from the current project state.
```

If the assistant cannot read files (for example a chat window), use the
manual workflow in `chatgpt.md` — it works for any chat-only assistant.

## Adding a new provider

1. Create `.ai/providers/<name>.md` from an existing provider file.
2. Create the tool's entry file at its documented path. It must reference
   `.ai/README.md` and `.ai/providers/<name>.md`, and nothing more.
3. Add a row to the table above.
4. Add both files to `scripts/validate.sh`.
5. Note the change in `CHANGELOG.md`.

## Removing a provider

Your team doesn't use one of these tools? Delete its entry file and provider
file, remove its row above, and remove it from `scripts/validate.sh`.
