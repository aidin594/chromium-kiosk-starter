#!/usr/bin/env bash
set -Eeuo pipefail
rm -f -- "$HOME/.config/autostart/chromium-kiosk-starter.desktop"
echo 'Autostart removed. Local configuration and browser profile preserved.'
