#!/usr/bin/env sh
# Sync AGENTS.md from nixos-config to all projects, then commit

set -eu

SRC="$HOME/nixos-config/AGENTS.md"

# Generate commit message from pi (headless), with fallback chain
if [ -z "${1:-}" ]; then
  DIFF=$(git -C "$HOME/nixos-config" diff HEAD -- AGENTS.md 2>/dev/null || true)
  if [ -z "$DIFF" ]; then
    DIFF=$(git -C "$HOME/nixos-config" diff --cached -- AGENTS.md 2>/dev/null || true)
  fi

  if [ -n "$DIFF" ]; then
    DESC=$(echo "$DIFF" | pi -p "Summarize this diff in a short phrase for a commit message. Output only the description, nothing else. No prefix." 2>/dev/null || true)
    MSG="chore(agents): ${DESC:-manual sync AGENTS.md across repos}"
  else
    MSG="chore(agents): manual sync AGENTS.md across repos"
  fi
else
  MSG="$1"
fi

find "$HOME" -maxdepth 4 -name AGENTS.md -type f \
    ! -path "$HOME/nixos-config/*" \
    -exec sh -c '
dir="$(dirname "$2")"
cd "$dir" || exit

if ! git rev-parse --git-dir >/dev/null 2>&1; then
  echo "skip $dir (not a git repo)" >&2
  exit 0
fi

if ! git diff --quiet HEAD 2>/dev/null; then
  echo "skip $dir (dirty, uncommitted changes)" >&2
  exit 0
fi

cp "$1" "$2"

git add AGENTS.md
git commit -m "$3" 2>/dev/null || true
' _ "$SRC" {} "$MSG" \;
