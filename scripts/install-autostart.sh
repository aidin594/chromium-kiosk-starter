#!/usr/bin/env bash
set -Eeuo pipefail
ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
mkdir -p "$HOME/.config/autostart"
cat > "$HOME/.config/autostart/chromium-kiosk-starter.desktop" <<EOF_DESKTOP
[Desktop Entry]
Type=Application
Name=Chromium Kiosk
Comment=Launch Chromium in kiosk mode
Exec=/bin/bash $ROOT/kiosk.sh
Terminal=false
X-GNOME-Autostart-enabled=true
EOF_DESKTOP
printf 'Autostart installed: %s\n' "$ROOT/kiosk.sh"
printf 'Sign out and back in to test. Avoid multiple kiosk launchers.\n'
