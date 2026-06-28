#!/usr/bin/env sh
# Sync AGENTS.md from nixos-config to all projects, then commit

SRC="$HOME/nixos-config/AGENTS.md"
MSG="chore(agents): updated AGENTS.md and synced with automated script"

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
