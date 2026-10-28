#!/usr/bin/env sh
# Sync AGENTS.md from nixos-config to the root of every git repo under $HOME.
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

# Nested AGENTS.md (subdirectory or submodule) is skipped silently: only a repo
# root is ours to overwrite.
find "$HOME" -maxdepth 4 -name AGENTS.md -type f \
    ! -path "$HOME/nixos-config/*" \
    -exec sh -c '
dir="$(dirname "$2")"
base="$(basename "$dir")"
[ "$(git -C "$dir" rev-parse --show-toplevel 2>/dev/null)" = "$dir" ] || exit 0
cmp -s "$1" "$2" && git -C "$dir" diff --quiet -- AGENTS.md && exit 0

cp "$1" "$2"
git -C "$dir" add -- AGENTS.md
git -C "$dir" commit -q -m "$3" -- AGENTS.md >/dev/null 2>&1 ||
  { echo "skip $base (commit failed)" >&2; exit 0; }
echo "synced $base"
' _ "$SRC" {} "$MSG" \;

# Commit the source repo (nixos-config) itself — it is excluded from the loop above.
# Only AGENTS.md, so unrelated flake edits stay untouched.
git -C "$HOME/nixos-config" add -- AGENTS.md
if git -C "$HOME/nixos-config" commit -q -m "$MSG" -- AGENTS.md >/dev/null 2>&1; then
    echo "synced nixos-config"
    push_repo "$HOME/nixos-config"
else
    echo "skip nixos-config (no AGENTS.md change to commit)" >&2
fi
