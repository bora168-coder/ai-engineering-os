# ADR-0001: Support multiple AI assistants through thin entry files

- **Status:** Accepted
- **Date:** 2026-10-28
- **Deciders:** VOID AI OS maintainers

## Context

VOID AI OS v1 targeted Claude Code only: `CLAUDE.md` booted the assistant into
`.ai/`. Teams also use OpenAI Codex/ChatGPT, Gemini CLI, GitHub Copilot, and
Cursor. Each tool auto-loads a different file (`AGENTS.md`, `GEMINI.md`,
`.github/copilot-instructions.md`, `.cursor/rules/*.mdc`), and some (ChatGPT
web) cannot read the repository at all. The workflow must stay identical across
tools, or the shared memory and task state stop being trustworthy.

## Decision

We will keep `.ai/` as the single source of truth and add one thin **entry file**
per assistant at its native path, plus one **provider file** per assistant in
`.ai/providers/` for tool-specific notes. Entry files only point to `.ai/`;
they never contain their own copy of the rules beyond a short summary.

## Options considered

### Option A — Thin entry files + `.ai/providers/` (chosen)

- Pros: one brain, no rule drift; each tool still auto-loads its context;
  adding a tool is two small files.
- Cons: several root-level files; tools that do not follow links may miss
  details (mitigated by the summary in each entry file and provider notes).

### Option B — Generate full entry files from a template with a script

- Pros: each tool gets the full rules inline.
- Cons: generated copies drift when someone edits them by hand; needs a sync
  step in CI; more moving parts.
- Rejected because: the duplication is the problem we want to avoid.

### Option C — Only `AGENTS.md` for every tool

- Pros: one file.
- Cons: not every tool reads it (Claude Code uses `CLAUDE.md`; Copilot Chat and
  Gemini CLI default to their own files); chat-only tools still need a manual flow.
- Rejected because: the OS would silently not load for some tools.

## Consequences

- **Positive:** the same workflow, memory, and tasks work with any supported
  assistant; chat-only assistants have a documented manual flow.
- **Negative:** five entry files to keep in sync (the short summary); tool
  conventions can change, so provider files need occasional review.
- **Follow-up:** `scripts/validate.sh` checks that every entry file exists and
  references `.ai/README.md`.
