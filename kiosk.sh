#!/usr/bin/env bash
set -Eeuo pipefail

APP_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_FILE="${KIOSK_CONFIG:-$APP_DIR/config/kiosk.conf}"
if [[ ! -f "$CONFIG_FILE" ]]; then
  printf 'Missing configuration: %s\n' "$CONFIG_FILE" >&2
  exit 1
fi

# Source only trusted local configuration.
# shellcheck source=config/kiosk.conf.example
source "$CONFIG_FILE"
: "${KIOSK_URL:?Set KIOSK_URL in config/kiosk.conf}"
if [[ ! "$KIOSK_URL" =~ ^https?:// ]]; then
  echo 'KIOSK_URL must start with http:// or https://' >&2
  exit 1
fi

: "${DISPLAY:=:0}"
export DISPLAY
if command -v xset >/dev/null 2>&1; then
  xset -dpms >/dev/null 2>&1 || true
  xset s off >/dev/null 2>&1 || true
  xset s noblank >/dev/null 2>&1 || true
fi

if [[ -n "${KIOSK_BROWSER:-}" ]]; then
  BROWSER_BIN="$KIOSK_BROWSER"
else
  BROWSER_BIN=""
  for candidate in chromium-browser chromium; do
    if command -v "$candidate" >/dev/null 2>&1; then
      BROWSER_BIN="$candidate"
      break
    fi
  done
fi
if [[ -z "$BROWSER_BIN" ]] || ! command -v "$BROWSER_BIN" >/dev/null 2>&1; then
  echo 'Chromium not found. Install it separately.' >&2
  exit 1
fi

PROFILE_DIR="${KIOSK_PROFILE_DIR:-${XDG_DATA_HOME:-$HOME/.local/share}/chromium-kiosk-starter/profile}"
mkdir -p -- "$PROFILE_DIR"

args=(
  --kiosk
  --no-first-run
  --no-default-browser-check
  --noerrdialogs
  --disable-session-crashed-bubble
  --disable-infobars
  --disable-features=Translate,TranslateUI
  --user-data-dir="$PROFILE_DIR"
)
if [[ -n "${KIOSK_LANGUAGE:-}" ]]; then
  args+=("--lang=$KIOSK_LANGUAGE")
fi

while true; do
  "$BROWSER_BIN" "${args[@]}" "$KIOSK_URL" || true
  sleep "${KIOSK_RESTART_DELAY:-3}"
done
