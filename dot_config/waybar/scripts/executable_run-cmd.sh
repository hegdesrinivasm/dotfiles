#!/usr/bin/env bash
set -euo pipefail

list="$(mktemp)"
trap 'rm -f "$list"' EXIT

compgen -c | sort -u > "$list"

choice="$(fuzzel --dmenu --with-nth=1 --lines=10 --placeholder="Run command" < "$list" 2>/dev/null)"
[ -n "$choice" ] || exit 0

ghostty -e bash -lc "$choice"
