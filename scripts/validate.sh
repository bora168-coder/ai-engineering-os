#!/usr/bin/env bash
# VOID AI OS — validate that the OS structure is intact.
# Exits non-zero if required files are missing. Run locally or in CI.
set -uo pipefail

cd "$(dirname "$0")/.."

ERRORS=0
WARNINGS=0

require() {
  if [[ ! -f "$1" ]]; then
    echo "❌ missing: $1"
    ERRORS=$((ERRORS + 1))
  fi
}

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

# Providers: each entry file must exist and point to the shared brain
for p in README claude chatgpt gemini copilot cursor; do
  require ".ai/providers/${p}.md"
done
for e in CLAUDE.md AGENTS.md GEMINI.md .github/copilot-instructions.md .cursor/rules/void-ai-os.mdc; do
  require "$e"
  if [[ -f "$e" ]] && ! grep -q '\.ai/README\.md' "$e"; then
    echo "❌ entry file does not reference .ai/README.md: $e"
    ERRORS=$((ERRORS + 1))
  fi
done

# Docs skeleton
for d in architecture api deployment database user-guide developer-guide diagrams; do
  require "docs/${d}/README.md"
done

# Warnings: leftover placeholders outside the template itself
if git grep -lq '{{PROJECT_NAME}}' -- '*.md' 2>/dev/null; then
  echo "⚠️  {{PLACEHOLDER}} tokens remain — run ./scripts/init.sh (expected in the template repo itself)"
  WARNINGS=$((WARNINGS + 1))
fi

# Warnings: possible secrets committed
if git ls-files | grep -qE '(^|/)\.env$|\.pem$|\.key$'; then
  echo "❌ potential secret file tracked by git (.env/.pem/.key)"
  ERRORS=$((ERRORS + 1))
fi

echo
if [[ $ERRORS -gt 0 ]]; then
  echo "Validation failed: $ERRORS error(s), $WARNINGS warning(s)."
  exit 1
fi
echo "✅ Structure valid ($WARNINGS warning(s))."
