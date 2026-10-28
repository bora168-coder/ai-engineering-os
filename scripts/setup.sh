#!/usr/bin/env bash
# VOID AI OS — one-command setup for a project created from this template.
# Checks prerequisites, runs init.sh (first time only), installs the git
# pre-commit hook that runs validate.sh, and validates the result.
# Safe to re-run.
set -euo pipefail

cd "$(dirname "$0")/.."
# shellcheck source=scripts/lib.sh
source scripts/lib.sh

HOOK_MARKER="# VOID AI OS pre-commit hook"

usage() {
  cat <<EOF
Usage: scripts/setup.sh [--no-hook] [init options]

  --no-hook    Do not install the git pre-commit hook
  -h, --help   Show this help

Other options are passed to scripts/init.sh (see scripts/init.sh --help).
EOF
}

INSTALL_HOOK=1
INIT_ARGS=()
while [[ $# -gt 0 ]]; do
  case "$1" in
    --no-hook) INSTALL_HOOK=0; shift ;;
    -h|--help) usage; exit 0 ;;
    *) INIT_ARGS+=("$1"); shift ;;
  esac
done

# 1. Prerequisites.
for tool in git sed awk grep; do
  if ! command -v "$tool" > /dev/null 2>&1; then
    echo "error: '$tool' is required but not installed" >&2
    exit 1
  fi
done
if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
  echo "→ not a git repository yet: running git init"
  git init -q
fi

# 2. Initialize the project (first run only).
if is_template; then
  echo "→ initializing project"
  bash scripts/init.sh ${INIT_ARGS[@]+"${INIT_ARGS[@]}"}
elif [[ ${#INIT_ARGS[@]} -gt 0 ]]; then
  echo "error: project is already initialized; init options are not accepted" >&2
  exit 1
else
  echo "→ project already initialized: skipping init"
fi

# 3. Git pre-commit hook. Never overwrite a hook we did not write.
if [[ $INSTALL_HOOK -eq 1 ]]; then
  HOOK="$(git rev-parse --git-path hooks)/pre-commit"
  if [[ -f "$HOOK" ]] && ! grep -q "$HOOK_MARKER" "$HOOK"; then
    echo "⚠️  $HOOK already exists and is not ours: left unchanged."
    echo "    Add this line to it to validate on commit: ./scripts/validate.sh"
  else
    mkdir -p "$(dirname "$HOOK")"
    cat > "$HOOK" <<EOF
#!/usr/bin/env bash
$HOOK_MARKER — installed by scripts/setup.sh.
# Blocks commits that break the VOID AI OS structure. Bypass: git commit --no-verify
exec bash "\$(git rev-parse --show-toplevel)/scripts/validate.sh"
EOF
    chmod +x "$HOOK"
    echo "→ installed pre-commit hook: $HOOK"
  fi
fi

# 4. Validate.
echo "→ validating"
bash scripts/validate.sh

echo
echo "✅ Setup complete."
