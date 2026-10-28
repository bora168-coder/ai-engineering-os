# Changelog

All notable changes to this project are documented here.
Format follows [Keep a Changelog](https://keepachangelog.com/) and the project
adheres to [Semantic Versioning](https://semver.org/).

## [Unreleased]

### Added
- Multi-assistant support (v3.0 roadmap item): entry files for OpenAI Codex
  (`AGENTS.md`), Gemini CLI (`GEMINI.md`), GitHub Copilot
  (`.github/copilot-instructions.md`), and Cursor (`.cursor/rules/void-ai-os.mdc`).
- `.ai/providers/` with per-assistant notes for Claude, OpenAI (Codex and
  ChatGPT web), Gemini, Copilot, and Cursor, plus a guide to add or remove providers.
- ChatGPT web (chat-only) workflow: Project setup and diff-based RECORD stage.
- ADR-0001: Support multiple AI assistants through thin entry files.

### Changed
- `.ai/README.md` boot sequence starts with the assistant's provider file.
- `scripts/validate.sh` checks provider files and that every entry file
  references `.ai/README.md`.

## [1.0.0] - 2026-07-06

### Added
- Initial VOID AI OS template: `.ai/` brain (core docs, agents, prompts, memory, tasks),
  document templates, docs skeleton, init/validate scripts, and structure-validation CI.
