#!/usr/bin/env sh
# Sync AGENTS.md from nixos-config to all projects and commit.
# Usage: sync-agents.sh commit="chore(agents): msg" [push=yes]
set -eu

SRC="$HOME/nixos-config/AGENTS.md"
MSG=""
PUSH="no"

for arg in "$@"; do
    case "$arg" in
    commit=*) MSG="${arg#commit=}" ;;
    push=yes|push=no) PUSH="${arg#push=}" ;;
    *)
        echo "usage: sync-agents.sh commit=\"chore(agents): msg\" [push=yes]" >&2
        exit 1
        ;;
    esac
done

[ -n "$MSG" ] || {
    echo "usage: commit message cannot be empty" >&2
    exit 1
}

# push=yes is the only opt-in; anything else stays local to avoid surprise pushes.
push_repo() {
    [ "$PUSH" = yes ] || return 0
    git -C "$1" push
}

find "$HOME" -maxdepth 4 -name AGENTS.md -type f \
    ! -path "$HOME/nixos-config/*" \
    -exec sh -c '
dir="$(dirname "$2")"
base="$(basename "$dir")"
cd "$dir" || exit

if ! git rev-parse --git-dir >/dev/null 2>&1; then
  echo "skip $base (not a git repo)" >&2
  exit 0
fi

cp "$1" "$2"
git add AGENTS.md
git commit -q -m "$3" 2>/dev/null || { echo "skip $base (commit failed)" >&2; exit 0; }
echo "synced $base"
' _ "$SRC" {} "$MSG" \;

# Commit the source repo (nixos-config) itself — it is excluded from the loop above.
# Only AGENTS.md, so unrelated flake edits stay untouched.
git -C "$HOME/nixos-config" add AGENTS.md
if git -C "$HOME/nixos-config" commit -q -m "$MSG" 2>/dev/null; then
    echo "synced nixos-config"
    push_repo "$HOME/nixos-config"
else
    echo "skip nixos-config (no AGENTS.md change to commit)" >&2
fi
