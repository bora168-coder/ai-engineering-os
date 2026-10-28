#!/usr/bin/env bash
# VOID AI OS — tests for scripts/init.sh, scripts/validate.sh, scripts/setup.sh.
# Each test runs in a fresh throwaway copy of the repo. Usage: bash tests/scripts.test.sh
set -uo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
WORK="$(mktemp -d)"
trap 'rm -rf "$WORK"' EXIT

PASSED=0
FAILED=0

# Copy the current working tree (tracked + new files) into a fresh git repo.
fresh_copy() {
  local dir="$WORK/$1"
  mkdir -p "$dir"
  (cd "$ROOT" && git ls-files --cached --others --exclude-standard -z |
    while IFS= read -r -d '' f; do
      [[ -f "$f" ]] || continue
      mkdir -p "$dir/$(dirname "$f")" && cp -p "$f" "$dir/$f"
    done)
  (cd "$dir" && git init -q && git add -A &&
    git -c user.name=Test -c user.email=test@example.com commit -qm init)
  echo "$dir"
}

# run_test NAME FUNCTION — the function runs inside a fresh copy.
run_test() {
  local dir output
  dir="$(fresh_copy "$2")"
  if output="$(cd "$dir" && "$2" 2>&1)"; then
    echo "ok   - $1"
    PASSED=$((PASSED + 1))
  else
    echo "FAIL - $1"
    printf '%s\n' "$output" | while IFS= read -r line; do echo "       $line"; done
    FAILED=$((FAILED + 1))
  fi
}

# Each test runs in its own subshell, so exit only ends the current test.
fail() { echo "assertion failed: $*"; exit 1; }

# --- validate.sh ------------------------------------------------------------

t_validate_template() {
  bash scripts/validate.sh > out.txt || { cat out.txt; fail "template should validate"; }
}

t_validate_broken_link() {
  echo "See [missing](does-not-exist.md)." >> docs/README.md
  ! bash scripts/validate.sh > out.txt || fail "broken link not detected"
  grep -q "broken link in docs/README.md: does-not-exist.md" out.txt || { cat out.txt; fail "wrong message"; }
}

t_validate_link_in_code_block_ignored() {
  # shellcheck disable=SC2016 # literal backticks
  printf '\n```\n[x](not-a-real-file.md)\n```\n' >> docs/README.md
  bash scripts/validate.sh > out.txt || { cat out.txt; fail "link inside code block was checked"; }
}

t_validate_unindexed_adr() {
  cp templates/adr.md docs/architecture/decisions/adr-0042-something.md
  ! bash scripts/validate.sh > out.txt || fail "unindexed ADR not detected"
  grep -q "not indexed" out.txt || { cat out.txt; fail "wrong message"; }
}

t_validate_indexed_adr_without_file() {
  awk '{ print } /^\|---\|---\|---\|---\|$/ { print "| ADR-0043 | 2026-01-01 | Ghost | Accepted |" }' \
    .ai/DECISIONS.md > tmp && mv tmp .ai/DECISIONS.md
  ! bash scripts/validate.sh > out.txt || fail "ADR row without file not detected"
  grep -q "ADR-0043 is indexed" out.txt || { cat out.txt; fail "wrong message"; }
}

t_validate_entry_file_reference() {
  sed 's|\.ai/README\.md|.ai/OTHER.md|g' GEMINI.md > tmp && mv tmp GEMINI.md
  ! bash scripts/validate.sh > out.txt || fail "entry file without .ai/README.md not detected"
}

t_validate_rejects_unknown_option() {
  ! bash scripts/validate.sh --nope > /dev/null 2>&1 || fail "unknown option accepted"
}

# --- init.sh ----------------------------------------------------------------

t_init_non_interactive() {
  bash scripts/init.sh --name "Acme" --description "Billing API" --author "Dana" < /dev/null > out.txt ||
    { cat out.txt; fail "init failed"; }
  grep -q "^# Project: Acme$" .ai/PROJECT.md || fail "name not filled"
  grep -q "^Billing API$" .ai/PROJECT.md || fail "description not filled"
  grep -q "| Owner | Dana |" .ai/PROJECT.md || fail "author not filled"
  grep -q "^# Acme$" README.md || fail "project README not generated"
  grep -q "All notable changes to Acme" CHANGELOG.md || fail "CHANGELOG not reset"
  ! git grep -q '{{PROJECT_NAME}}' -- '*.md' || fail "placeholders left"
  bash scripts/validate.sh > out.txt || { cat out.txt; fail "initialized project should validate"; }
}

t_init_special_characters() {
  bash scripts/init.sh --name 'R&D | A/B \ Tools' --description 'x & y' < /dev/null > out.txt ||
    { cat out.txt; fail "init failed"; }
  grep -qF '# Project: R&D | A/B \ Tools' .ai/PROJECT.md || { head -1 .ai/PROJECT.md; fail "special characters mangled"; }
  grep -qxF 'x & y' .ai/PROJECT.md || fail "description mangled"
}

t_init_requires_name_without_terminal() {
  ! bash scripts/init.sh < /dev/null > out.txt 2>&1 || fail "init ran without a name"
  grep -q "project name is required" out.txt || { cat out.txt; fail "wrong message"; }
  git diff --quiet || fail "files changed after a failed init"
}

t_init_runs_only_once() {
  bash scripts/init.sh --name First < /dev/null > /dev/null || fail "first init failed"
  ! bash scripts/init.sh --name Second < /dev/null > out.txt 2>&1 || fail "second init was allowed"
  grep -q "already initialized" out.txt || { cat out.txt; fail "wrong message"; }
  grep -q "^# Project: First$" .ai/PROJECT.md || fail "second init changed files"
}

t_init_selected_providers() {
  bash scripts/init.sh --name Acme --providers claude,cursor < /dev/null > out.txt ||
    { cat out.txt; fail "init failed"; }
  [[ -f CLAUDE.md && -f .cursor/rules/void-ai-os.mdc ]] || fail "kept providers were removed"
  [[ ! -e AGENTS.md && ! -e GEMINI.md && ! -e .github/copilot-instructions.md ]] || fail "unused entry files kept"
  [[ ! -e .ai/providers/chatgpt.md && ! -e .ai/providers/gemini.md ]] || fail "unused provider files kept"
  # shellcheck disable=SC2016 # literal backticks
  ! grep -q '`gemini.md`' .ai/providers/README.md || fail "provider table row not removed"
  bash scripts/validate.sh > out.txt || { cat out.txt; fail "should validate"; }
}

t_init_rejects_unknown_provider() {
  ! bash scripts/init.sh --name Acme --providers claude,skynet < /dev/null > out.txt 2>&1 ||
    fail "unknown provider accepted"
  grep -q "unknown AI assistant 'skynet'" out.txt || { cat out.txt; fail "wrong message"; }
  git diff --quiet && [[ -f AGENTS.md ]] || fail "files changed after a failed init"
}

t_strict_flags_unfilled_docs() {
  bash scripts/init.sh --name Acme < /dev/null > /dev/null || fail "init failed"
  bash scripts/validate.sh > /dev/null || fail "normal mode should pass"
  ! bash scripts/validate.sh --strict > out.txt || fail "strict mode should fail on template example text"
  grep -q "TECH_STACK.md still contains template example text" out.txt || { cat out.txt; fail "wrong message"; }
}

# --- setup.sh ---------------------------------------------------------------

t_setup_end_to_end() {
  bash scripts/setup.sh --name Acme < /dev/null > out.txt || { cat out.txt; fail "setup failed"; }
  grep -q "^# Project: Acme$" .ai/PROJECT.md || fail "init did not run"
  grep -q "VOID AI OS pre-commit hook" .git/hooks/pre-commit || fail "hook not installed"
  [[ -x .git/hooks/pre-commit ]] || fail "hook not executable"
  bash scripts/setup.sh < /dev/null > out.txt || { cat out.txt; fail "re-run failed"; }
  grep -q "already initialized: skipping init" out.txt || fail "re-run did not skip init"
}

t_setup_hook_blocks_bad_commit() {
  bash scripts/setup.sh --name Acme < /dev/null > /dev/null || fail "setup failed"
  git add -A
  git -c user.name=T -c user.email=t@e.x commit -qm ok > /dev/null || fail "valid commit blocked"
  rm .ai/RULES.md
  git add -A
  ! git -c user.name=T -c user.email=t@e.x commit -qm bad > /dev/null 2>&1 || fail "hook did not block a broken commit"
}

t_setup_keeps_foreign_hook() {
  printf '#!/bin/sh\necho mine\n' > .git/hooks/pre-commit
  bash scripts/setup.sh --name Acme < /dev/null > out.txt || { cat out.txt; fail "setup failed"; }
  grep -q "echo mine" .git/hooks/pre-commit || fail "foreign hook overwritten"
  grep -q "not ours: left unchanged" out.txt || fail "no warning about foreign hook"
}

t_setup_outside_git() {
  rm -rf .git
  bash scripts/setup.sh --name Acme < /dev/null > out.txt || { cat out.txt; fail "setup failed"; }
  [[ -d .git ]] || fail "git repo not created"
  grep -q "^# Project: Acme$" .ai/PROJECT.md || fail "placeholders not replaced in a fresh git repo"
  ! grep -rq '{{PROJECT_NAME}}' --include='*.md' . || fail "placeholders left"
}

t_setup_no_hook() {
  bash scripts/setup.sh --no-hook --name Acme < /dev/null > /dev/null || fail "setup failed"
  [[ ! -e .git/hooks/pre-commit ]] || fail "hook installed despite --no-hook"
}

for t in $(declare -F | awk '{print $3}' | grep '^t_'); do
  run_test "${t#t_}" "$t"
done

echo
echo "$PASSED passed, $FAILED failed"
[[ $FAILED -eq 0 ]]
