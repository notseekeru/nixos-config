#!/usr/bin/env sh
# Sync AGENTS.md from nixos-config to all projects, commit, ask push per repo y/n/q
# Usage: sync-agents.sh commit="chore(agents): msg"
set -eu

SRC="$HOME/nixos-config/AGENTS.md"

case "${1:-}" in
commit=*) MSG="${1#commit=}" ;;
*)
    echo "usage: sync-agents.sh commit=\"chore(agents): msg\"" >&2
    exit 1
    ;;
esac

[ -n "$MSG" ] || {
    echo "usage: commit message cannot be empty" >&2
    exit 1
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
msg="$3"
git commit -q -m "$msg" 2>/dev/null || { echo "skip $base (commit failed)" >&2; exit 0; }
echo "synced $base"

while :; do
  printf "push %s? [y/n/q] " "$base"
  read ans || exit 0
  case "$ans" in
    y|Y) git push && break ;;
    n|N) break ;;
    q|Q) exit 0 ;;
    *) ;;
  esac
done
' _ "$SRC" {} "$MSG" \;

# Commit the source repo (nixos-config) itself — it is excluded from the loop above.
# Only AGENTS.md, so unrelated flake edits stay untouched.
git -C "$HOME/nixos-config" add AGENTS.md
if git -C "$HOME/nixos-config" commit -q -m "$MSG" 2>/dev/null; then
  echo "synced nixos-config"
  base=nixos-config
  while :; do
    printf "push %s? [y/n/q] " "$base"
    read ans || exit 0
    case "$ans" in
      y|Y) git -C "$HOME/nixos-config" push && break ;;
      n|N) break ;;
      q|Q) exit 0 ;;
      *) ;;
    esac
  done
else
  echo "skip nixos-config (no AGENTS.md change to commit)" >&2
fi
