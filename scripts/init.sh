#!/usr/bin/env bash
# VOID AI OS — initialize a new project created from this template.
# Fills {{PLACEHOLDER}} tokens and stamps today's date. Safe to re-run.
set -euo pipefail

cd "$(dirname "$0")/.."

echo "🌟 VOID AI OS — project initialization"
echo

read -rp "Project name: " PROJECT_NAME
read -rp "One-line description: " PROJECT_DESCRIPTION
read -rp "Author/owner [$(git config user.name 2>/dev/null || echo you)]: " AUTHOR
AUTHOR="${AUTHOR:-$(git config user.name 2>/dev/null || echo you)}"
TODAY="$(date +%Y-%m-%d)"

if [[ -z "$PROJECT_NAME" ]]; then
  echo "error: project name is required" >&2
  exit 1
fi

# Replace placeholders in all tracked text files.
FILES=$(git ls-files '*.md' 2>/dev/null || find . -name '*.md' -not -path './.git/*')
for f in $FILES; do
  sed -i \
    -e "s|{{PROJECT_NAME}}|${PROJECT_NAME}|g" \
    -e "s|{{PROJECT_DESCRIPTION}}|${PROJECT_DESCRIPTION}|g" \
    -e "s|{{AUTHOR}}|${AUTHOR}|g" \
    "$f"
done

# Fresh changelog for the new project.
cat > CHANGELOG.md <<EOF
# Changelog

All notable changes to ${PROJECT_NAME} are documented here.
Format follows [Keep a Changelog](https://keepachangelog.com/); versions follow
[Semantic Versioning](https://semver.org/).

## [Unreleased]

### Added
- Project initialized from VOID AI OS template (${TODAY}).
EOF

# Stamp initialization date in task/memory history.
sed -i "s|2026-07-06|${TODAY}|g" \
  .ai/tasks/completed.md .ai/memory/decisions.md .ai/ROADMAP.md .ai/DECISIONS.md 2>/dev/null || true

echo
echo "✅ Initialized '${PROJECT_NAME}'."
echo
echo "Next steps:"
echo "  1. Fill in .ai/PROJECT.md (problem, goals, non-goals)"
echo "  2. Fill in .ai/TECH_STACK.md and .ai/ARCHITECTURE.md"
echo "  3. Run ./scripts/validate.sh"
echo "  4. Open Claude Code — CLAUDE.md takes it from there"
