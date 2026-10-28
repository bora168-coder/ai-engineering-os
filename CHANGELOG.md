# Changelog

All notable changes to this project are documented here.
Format follows [Keep a Changelog](https://keepachangelog.com/) and the project
adheres to [Semantic Versioning](https://semver.org/).

## [Unreleased]

### Added
- `scripts/setup.sh` (v2.0 roadmap item): one-command setup — checks
  prerequisites, runs init on first use, installs a git pre-commit hook that
  runs `validate.sh`, and validates. Safe to re-run; never overwrites a
  pre-commit hook it did not write.
- `scripts/init.sh` flags for non-interactive use (`--name`, `--description`,
  `--author`, `--providers`) and `--help`. `--providers` keeps only the chosen
  AI assistants. Init now writes a project README.
- `scripts/validate.sh` documentation checks: broken relative Markdown links,
  ADR files vs. the `.ai/DECISIONS.md` index, leftover placeholders after init,
  and the CHANGELOG `[Unreleased]` section. New `--strict` mode fails on warnings.
- `tests/scripts.test.sh`: 19 tests for the scripts. CI now also runs
  ShellCheck and these tests.
- Multi-assistant support (v3.0 roadmap item): entry files for OpenAI Codex
  (`AGENTS.md`), Gemini CLI (`GEMINI.md`), GitHub Copilot
  (`.github/copilot-instructions.md`), and Cursor (`.cursor/rules/void-ai-os.mdc`).
- `.ai/providers/` with per-assistant notes for Claude, OpenAI (Codex and
  ChatGPT web), Gemini, Copilot, and Cursor, plus a guide to add or remove providers.
- ChatGPT web (chat-only) workflow: Project setup and diff-based RECORD stage.
- ADR-0001: Support multiple AI assistants through thin entry files.

### Changed
- `scripts/validate.sh` no longer requires every AI assistant's entry file;
  it requires at least one, and checks each one that is present.
- `.ai/README.md` boot sequence starts with the assistant's provider file.
- `scripts/validate.sh` checks provider files and that every entry file
  references `.ai/README.md`.

### Fixed
- `scripts/init.sh` corrupted values containing `&`, `|`, or `\` (sed escaping).
- `scripts/init.sh` failed on macOS (GNU-only `sed -i`).
- `scripts/init.sh` could be re-run on an initialized project and overwrite
  its CHANGELOG; it now refuses.

## [1.0.0] - 2026-07-06

### Added
- Initial VOID AI OS template: `.ai/` brain (core docs, agents, prompts, memory, tasks),
  document templates, docs skeleton, init/validate scripts, and structure-validation CI.
