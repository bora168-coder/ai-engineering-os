#!/usr/bin/env bash
# VOID AI OS — validate that the OS structure and documentation are intact.
# Exits non-zero on errors. Run locally, in the pre-commit hook, or in CI.
#   --strict   treat warnings as errors (use once the project is filled in)
set -uo pipefail

cd "$(dirname "$0")/.." || exit 1
# shellcheck source=scripts/lib.sh
source scripts/lib.sh

STRICT=0
case "${1:-}" in
  "") ;;
  --strict) STRICT=1 ;;
  -h|--help) echo "Usage: scripts/validate.sh [--strict]"; exit 0 ;;
  *) echo "error: unknown option: $1" >&2; exit 2 ;;
esac

ERRORS=0
WARNINGS=0

error() { echo "❌ $1"; ERRORS=$((ERRORS + 1)); }
warn()  { echo "⚠️  $1"; WARNINGS=$((WARNINGS + 1)); }

require() {
  [[ -f "$1" ]] || error "missing: $1"
}

# --- Structure --------------------------------------------------------------

# Root
require README.md
require CHANGELOG.md
require LICENSE

# .ai core
for f in README PROJECT WORKFLOW ARCHITECTURE RULES ROADMAP DECISIONS SECURITY TESTING STYLE_GUIDE TECH_STACK; do
  require ".ai/${f}.md"
done

# Agents
for a in manager product_owner researcher architect backend frontend database mobile devops security reviewer qa documentation uiux; do
  require ".ai/agents/${a}.md"
done

# Prompts
for p in planning implement review research debug refactor documentation testing release; do
  require ".ai/prompts/${p}.md"
done

# Memory & tasks
for m in business technical decisions known-issues glossary; do
  require ".ai/memory/${m}.md"
done
for t in backlog sprint todo completed; do
  require ".ai/tasks/${t}.md"
done

# Templates
for t in feature-request bug-report adr api-design database meeting-notes sprint epic story task; do
  require "templates/${t}.md"
done

# Docs skeleton
for d in architecture api deployment database user-guide developer-guide diagrams; do
  require "docs/${d}/README.md"
done

# Providers: at least one assistant; each kept entry file needs its provider
# file and must point to the shared brain. (init.sh may remove unused ones.)
require .ai/providers/README.md
PROVIDER_COUNT=0
for p in $PROVIDERS; do
  read -r entry pfile <<< "$(provider_files "$p")"
  [[ -f "$entry" || -f "$pfile" ]] || continue
  PROVIDER_COUNT=$((PROVIDER_COUNT + 1))
  require "$entry"
  require "$pfile"
  if [[ -f "$entry" ]] && ! grep -q '\.ai/README\.md' "$entry"; then
    error "entry file does not reference .ai/README.md: $entry"
  fi
done
[[ $PROVIDER_COUNT -gt 0 ]] || error "no AI assistant entry file found (see .ai/providers/README.md)"

# --- Documentation ----------------------------------------------------------

# Relative Markdown links must point to an existing file or directory.
BROKEN_LINKS="$(
  while IFS= read -r f; do
    dir="$(dirname "$f")"
    # Pull every ](target) out of the file, skipping fenced code blocks.
    awk '/^```/ { code = !code; next } !code' "$f" |
      grep -oE '\]\([^) ]+' | sed 's/^](//' |
      while IFS= read -r target; do
        case "$target" in
          http://*|https://*|mailto:*|\#*) continue ;;
        esac
        path="${target%%#*}"
        [[ -z "$path" || -e "$dir/$path" ]] || echo "❌ broken link in $f: $target"
      done
  done < <(md_files)
)"
if [[ -n "$BROKEN_LINKS" ]]; then
  echo "$BROKEN_LINKS"
  ERRORS=$((ERRORS + $(printf '%s\n' "$BROKEN_LINKS" | wc -l)))
fi

# ADR index and ADR files must match. ADR-0000 is the bootstrap entry and has
# no file of its own.
if [[ -f .ai/DECISIONS.md ]]; then
  for adr in docs/architecture/decisions/adr-[0-9][0-9][0-9][0-9]-*.md; do
    [[ -f "$adr" ]] || continue
    id="$(basename "$adr" | cut -c5-8)"
    grep -q "| ADR-${id} |" .ai/DECISIONS.md ||
      error "ADR file not indexed in .ai/DECISIONS.md: $adr"
  done
  while IFS= read -r id; do
    [[ "$id" == "0000" ]] && continue
    compgen -G "docs/architecture/decisions/adr-${id}-*.md" > /dev/null ||
      error "ADR-${id} is indexed in .ai/DECISIONS.md but has no file in docs/architecture/decisions/"
  done < <(grep -oE '^\| ADR-[0-9]{4} \|' .ai/DECISIONS.md | grep -oE '[0-9]{4}')
fi

# The changelog keeps an Unreleased section for work in progress.
if [[ -f CHANGELOG.md ]] && ! grep -q '^## \[Unreleased\]' CHANGELOG.md; then
  warn "CHANGELOG.md has no '## [Unreleased]' section"
fi

# Placeholders: expected in the template repo, a problem after init.
if is_template; then
  echo "ℹ️  template repo: {{PLACEHOLDER}} tokens are expected — run ./scripts/init.sh in new projects"
else
  while IFS= read -r f; do
    grep -q '{{[A-Z_]*}}' "$f" && warn "{{PLACEHOLDER}} token left in $f"
  done < <(md_files)
  # Core docs still showing the template's example text (e.g. "_e.g. Next.js_").
  for f in .ai/PROJECT.md .ai/ARCHITECTURE.md .ai/TECH_STACK.md; do
    [[ -f "$f" ]] && grep -qE '_(e\.g\.|…_|One paragraph)' "$f" &&
      warn "$f still contains template example text — fill it in"
  done
fi

# Secrets must never be tracked.
if git ls-files 2>/dev/null | grep -qE '(^|/)\.env$|\.pem$|\.key$'; then
  error "potential secret file tracked by git (.env/.pem/.key)"
fi

echo
if [[ $STRICT -eq 1 && $WARNINGS -gt 0 ]]; then
  echo "Validation failed (--strict): $ERRORS error(s), $WARNINGS warning(s)."
  exit 1
fi
if [[ $ERRORS -gt 0 ]]; then
  echo "Validation failed: $ERRORS error(s), $WARNINGS warning(s)."
  exit 1
fi
echo "✅ Validation passed ($WARNINGS warning(s))."
