# Changelog

All notable changes to this project are documented here.
Format follows [Keep a Changelog](https://keepachangelog.com/) and the project
adheres to [Semantic Versioning](https://semver.org/).

## [Unreleased]

### Changed
- Default AI workflow is now token-efficient: `CLAUDE.md` starts in compact lazy-loading mode instead of forcing full `.ai/` preload.
- `.ai/README.md` is now a concise task-to-file lazy-loading index with always-on guardrails.
- Added `.ai/FULL_WORKFLOW.md` as explicit opt-in for large/high-risk work.
- `README.md` now documents compact vs full workflow usage and migration guidance.
- `scripts/validate.sh` now validates presence of `.ai/FULL_WORKFLOW.md`.

## [1.0.0] - 2026-07-06

### Added
- Initial VOID AI OS template: `.ai/` brain (core docs, agents, prompts, memory, tasks),
  document templates, docs skeleton, init/validate scripts, and structure-validation CI.
