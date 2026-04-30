#!/bin/sh

set -eu

choice="$(printf '%s\n' \
  'Sperren' \
  'Abmelden' \
  'Neustart' \
  'Herunterfahren' \
  | rofi -dmenu -i -p 'Power')"

case "${choice:-}" in
  "Sperren")
    hyprlock
    ;;
  "Abmelden")
    hyprctl dispatch exit
    ;;
  "Neustart")
    systemctl reboot
    ;;
  "Herunterfahren")
    systemctl poweroff
    ;;
esac
