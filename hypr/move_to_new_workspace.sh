#!/bin/sh

set -eu

max_scan="${1:-30}"

next_workspace="$(hyprctl -j workspaces | jq -r --argjson max "$max_scan" '
  [.[].id | select(. > 0)] as $used
  | [range(1; $max + 1) | select(($used | index(.)) | not)][0] // ((($used | max) // 0) + 1)
')"

fullscreen_state="$(hyprctl -j activewindow | jq -r '.fullscreen // 0')"

hyprctl --batch "dispatch movetoworkspacesilent $next_workspace; dispatch workspace $next_workspace" >/dev/null

if [ "$fullscreen_state" = "0" ]; then
  hyprctl dispatch fullscreen 1 >/dev/null || true
fi
