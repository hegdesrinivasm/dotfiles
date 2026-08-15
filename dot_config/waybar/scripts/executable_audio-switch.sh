#!/usr/bin/env bash
set -euo pipefail

current_sink="$(pactl get-default-sink)"
current_source="$(pactl get-default-source)"
list="$(mktemp)"
trap 'rm -f "$list"' EXIT

pactl list sinks | awk -v cur="$current_sink" '
  /^\tName:/ { name=$2; next }
  /^\tDescription:/ {
    desc=$0; sub(/^\tDescription:\t/, "", desc)
    printf "%s  %s\tSINK\t%s\n", (name==cur ? "✓" : " "), desc, name
    name=""
  }' >> "$list"

pactl list sources | awk -v cur="$current_source" '
  /^\tName:/ { name=$2; next }
  /^\tDescription:/ {
    if (name ~ /\.monitor$/) { name=""; next }
    desc=$0; sub(/^\tDescription:\t/, "", desc)
    printf "%s  %s\tSOURCE\t%s\n", (name==cur ? "✓" : " "), desc, name
    name=""
  }' >> "$list"

choice="$(fuzzel --dmenu --with-nth=1 --placeholder="Select audio device" < "$list" 2>/dev/null)"
[ -n "$choice" ] || exit 0

kind="$(printf '%s\n' "$choice" | cut -f2)"
device="$(printf '%s\n' "$choice" | cut -f3)"

if [ "$kind" = "SINK" ]; then
  pactl set-default-sink "$device"
else
  pactl set-default-source "$device"
fi
