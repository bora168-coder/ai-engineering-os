#!/usr/bin/env bash
# VOID AI OS — initialize a new project created from this template.
# Fills {{PLACEHOLDER}} tokens, keeps only the chosen AI assistants, writes a
# project README and CHANGELOG, and stamps today's date. Runs once per project.
set -euo pipefail

cd "$(dirname "$0")/.."
# shellcheck source=scripts/lib.sh
source scripts/lib.sh

usage() {
  cat <<EOF
Usage: scripts/init.sh [options]

Options (any option not given is asked for interactively):
  --name NAME             Project name (required)
  --description TEXT      One-line project description
  --author NAME           Owner/author (default: git user.name)
  --providers LIST        Comma-separated AI assistants to keep, or "all"
                          (default: all). Choices: ${PROVIDERS// /, }
  -h, --help              Show this help

Without a terminal (CI, scripts), --name is required and nothing is asked.
EOF
}

PROJECT_NAME=""
PROJECT_DESCRIPTION=""
AUTHOR=""
PROVIDER_LIST=""
HAS_NAME=0 HAS_DESCRIPTION=0 HAS_AUTHOR=0

need_value() {
  if [[ $# -lt 2 ]]; then
    echo "error: $1 needs a value" >&2
    exit 2
  fi
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --name)        need_value "$@"; PROJECT_NAME="$2"; HAS_NAME=1; shift 2 ;;
    --description) need_value "$@"; PROJECT_DESCRIPTION="$2"; HAS_DESCRIPTION=1; shift 2 ;;
    --author)      need_value "$@"; AUTHOR="$2"; HAS_AUTHOR=1; shift 2 ;;
    --providers)   need_value "$@"; PROVIDER_LIST="$2"; shift 2 ;;
    -h|--help)     usage; exit 0 ;;
    *) echo "error: unknown option: $1" >&2; usage >&2; exit 2 ;;
  esac
done

if ! is_template; then
  echo "error: this project is already initialized (.ai/PROJECT.md has no {{PROJECT_NAME}})." >&2
  echo "Edit the files directly instead of re-running init." >&2
  exit 1
fi

INTERACTIVE=0
[[ -t 0 ]] && INTERACTIVE=1
GIT_USER="$(git config user.name 2>/dev/null || true)"
GIT_USER="${GIT_USER:-you}"

echo "🌟 VOID AI OS — project initialization"
echo

if [[ $HAS_NAME -eq 0 && $INTERACTIVE -eq 1 ]]; then
  read -rp "Project name: " PROJECT_NAME
fi
if [[ $HAS_DESCRIPTION -eq 0 && $INTERACTIVE -eq 1 ]]; then
  read -rp "One-line description: " PROJECT_DESCRIPTION
fi
if [[ $HAS_AUTHOR -eq 0 && $INTERACTIVE -eq 1 ]]; then
  read -rp "Author/owner [${GIT_USER}]: " AUTHOR
fi
if [[ -z "$PROVIDER_LIST" && $INTERACTIVE -eq 1 ]]; then
  read -rp "AI assistants to keep (${PROVIDERS// /,}) [all]: " PROVIDER_LIST
fi
AUTHOR="${AUTHOR:-$GIT_USER}"
PROVIDER_LIST="${PROVIDER_LIST:-all}"

if [[ -z "$PROJECT_NAME" ]]; then
  echo "error: project name is required (use --name)" >&2
  exit 1
fi
for value in "$PROJECT_NAME" "$PROJECT_DESCRIPTION" "$AUTHOR"; do
  if [[ "$value" == *$'\n'* ]]; then
    echo "error: values must be a single line" >&2
    exit 1
  fi
done

# Resolve the provider list before changing anything.
if [[ "$PROVIDER_LIST" == "all" ]]; then
  KEEP="$PROVIDERS"
else
  KEEP=""
  for p in ${PROVIDER_LIST//,/ }; do
    if ! provider_files "$p" > /dev/null; then
      echo "error: unknown AI assistant '$p' (choices: ${PROVIDERS// /, })" >&2
      exit 1
    fi
    KEEP="$KEEP $p"
  done
  if [[ -z "${KEEP// /}" ]]; then
    echo "error: keep at least one AI assistant" >&2
    exit 1
  fi
fi

TODAY="$(date +%Y-%m-%d)"

# 1. Remove the AI assistants that were not chosen.
for p in $PROVIDERS; do
  case " $KEEP " in *" $p "*) continue ;; esac
  read -r entry pfile <<< "$(provider_files "$p")"
  rm -f "$entry" "$pfile"
  sed_in_place "/| \`$(basename "$pfile")\` |/d" .ai/providers/README.md
  echo "removed: $entry, $pfile"
done
rmdir .cursor/rules .cursor 2>/dev/null || true

# 2. Replace placeholders in all Markdown files.
NAME_ESC="$(sed_escape "$PROJECT_NAME")"
DESC_ESC="$(sed_escape "$PROJECT_DESCRIPTION")"
AUTHOR_ESC="$(sed_escape "$AUTHOR")"
md_files |
  while IFS= read -r f; do
    sed_in_place "s|{{PROJECT_NAME}}|${NAME_ESC}|g; s|{{PROJECT_DESCRIPTION}}|${DESC_ESC}|g; s|{{AUTHOR}}|${AUTHOR_ESC}|g" "$f"
  done

# 3. Fresh README and CHANGELOG for the new project (the template's own README
#    describes VOID AI OS, not this project).
cat > README.md <<EOF
# ${PROJECT_NAME}

${PROJECT_DESCRIPTION}

## Working on this project

This project uses [VOID AI OS](https://github.com/bora168-coder/ai-engineering-os),
a version-controlled engineering workflow for AI-assisted development.

- Project knowledge, rules, and current state live in \`.ai/\`. Start with \`.ai/README.md\`.
- AI assistants load their entry file automatically; see \`.ai/providers/README.md\`.
- Human-facing documentation lives in \`docs/\`.
- Run \`./scripts/validate.sh\` before committing.
EOF

cat > CHANGELOG.md <<EOF
# Changelog

All notable changes to ${PROJECT_NAME} are documented here.
Format follows [Keep a Changelog](https://keepachangelog.com/); versions follow
[Semantic Versioning](https://semver.org/).

## [Unreleased]

### Added
- Project initialized from VOID AI OS template (${TODAY}).
EOF

# 4. Stamp the initialization date in task/memory history.
for f in .ai/tasks/completed.md .ai/memory/decisions.md .ai/ROADMAP.md .ai/DECISIONS.md; do
  [[ -f "$f" ]] && sed_in_place "s|2026-07-06|${TODAY}|g" "$f"
done

echo
echo "✅ Initialized '${PROJECT_NAME}' with AI assistants:${KEEP}."
echo
echo "Next steps:"
echo "  1. Fill in .ai/PROJECT.md (problem, goals, non-goals)"
echo "  2. Fill in .ai/TECH_STACK.md and .ai/ARCHITECTURE.md"
echo "  3. Run ./scripts/validate.sh --strict when they are filled in"
echo "  4. Open your AI assistant — its entry file takes it from there"
