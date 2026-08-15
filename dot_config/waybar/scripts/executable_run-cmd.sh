#!/usr/bin/env bash
set -euo pipefail

list="$(mktemp)"
trap 'rm -f "$list"' EXIT

compgen -c | sort -u > "$list"

choice="$(wofi --dmenu --lines 10 --prompt "Run command" < "$list" 2>/dev/null)"
[ -n "$choice" ] || exit 0

ghostty -e bash -lc "$choice"
