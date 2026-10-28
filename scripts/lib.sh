#!/usr/bin/env bash
# VOID AI OS — shared helpers for scripts/*.sh. Source it; do not run it.
# Portable to macOS bash 3.2 and BSD sed: no associative arrays, no `sed -i`.

# Supported assistants (see .ai/providers/README.md). Used by the sourcing scripts.
# shellcheck disable=SC2034
PROVIDERS="claude openai gemini copilot cursor"

# Print "<entry file> <provider file>" for a provider, or fail if unknown.
provider_files() {
  case "$1" in
    claude)  echo "CLAUDE.md .ai/providers/claude.md" ;;
    openai)  echo "AGENTS.md .ai/providers/chatgpt.md" ;;
    gemini)  echo "GEMINI.md .ai/providers/gemini.md" ;;
    copilot) echo ".github/copilot-instructions.md .ai/providers/copilot.md" ;;
    cursor)  echo ".cursor/rules/void-ai-os.mdc .ai/providers/cursor.md" ;;
    *) return 1 ;;
  esac
}

# Escape a string for use as a sed replacement with `|` as the delimiter.
sed_escape() {
  printf '%s' "$1" | sed -e 's/[\\|&]/\\&/g'
}

# Run a sed expression on a file in place (portable replacement for `sed -i`).
sed_in_place() {
  local expr="$1" file="$2" tmp
  tmp="$(mktemp)"
  sed -e "$expr" "$file" > "$tmp" && cat "$tmp" > "$file"
  local status=$?
  rm -f "$tmp"
  return $status
}

# List Markdown files: tracked and new (not ignored) files when in git,
# otherwise everything. Untracked files matter: a fresh `git init` tracks nothing.
md_files() {
  if git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
    git ls-files --cached --others --exclude-standard '*.md' |
      while IFS= read -r f; do [[ -f "$f" ]] && echo "$f"; done
  else
    find . -name '*.md' -not -path './.git/*' | sed 's|^\./||'
  fi
}

# True if this checkout has not been initialized yet.
is_template() {
  grep -q '{{PROJECT_NAME}}' .ai/PROJECT.md 2>/dev/null
}
