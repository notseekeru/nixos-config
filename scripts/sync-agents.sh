#!/usr/bin/env sh
# Sync AGENTS.md from nixos-config to all projects

SRC="$HOME/nixos-config/AGENTS.md"

find "$HOME" -maxdepth 4 -name AGENTS.md -type f \
  ! -path "$HOME/nixos-config/*" \
  -exec cp "$SRC" {} \;
