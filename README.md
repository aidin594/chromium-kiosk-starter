# Chromium Kiosk Starter

![Checks](https://github.com/aidin594/chromium-kiosk-starter/actions/workflows/checks.yml/badge.svg)
![License](https://img.shields.io/badge/license-MIT-blue)
![Platform](https://img.shields.io/badge/platform-Linux%20X11-informational)

A lightweight, white-label Chromium kiosk launcher for **Linux X11 desktops**. Display any website in full-screen mode, configure behavior without changing the script, and automatically relaunch Chromium when it closes.

> Independent community project. Not affiliated with Google or the Chromium project.

## Features

- Full-screen Chromium kiosk mode
- Configurable URL and browser language
- Dedicated Chromium user profile
- Automatic browser relaunch with configurable delay
- X11 display blanking prevention (when `xset` is available)
- XDG desktop autostart setup and removal
- No telemetry, accounts, bundled credentials or tracking code

## Requirements

- Linux with an active **X11** graphical session
- Bash and Chromium (`chromium-browser` or `chromium`)
- Optional: `xset` for display power management
- Network connectivity when displaying online content

**Wayland and headless sessions are not supported by this starter release.** Chromium must be installed separately.

## Quick start

```bash
git clone https://github.com/aidin594/chromium-kiosk-starter.git
cd chromium-kiosk-starter
cp config/kiosk.conf.example config/kiosk.conf
nano config/kiosk.conf
bash kiosk.sh
```

Set `KIOSK_URL` to the page you want to display. Run the launcher as the user logged into the graphical session. When launching from SSH, ensure the same user has access to the X11 display (for example `DISPLAY=:0 ./kiosk.sh`).

## Start automatically at login

```bash
bash scripts/install-autostart.sh
```

Sign out and back in to test. Do **not** run two independent kiosk launchers at the same time.

Remove automatic startup (without deleting your profile or configuration):

```bash
bash scripts/uninstall-autostart.sh
```

## Configuration

Copy `config/kiosk.conf.example` to `config/kiosk.conf`. The latter is excluded from version control.

| Setting | Purpose | Default |
| --- | --- | --- |
| `KIOSK_URL` | Destination page | Required |
| `KIOSK_LANGUAGE` | Browser locale | Unset |
| `KIOSK_BROWSER` | Chromium executable | Auto-detected |
| `KIOSK_PROFILE_DIR` | Isolated browser profile | User-local data directory |
| `KIOSK_RESTART_DELAY` | Seconds between launches | `3` |

**Security notice:** configuration is a local Bash file that is sourced by the launcher. Only use trusted configuration.

## Translation popups

The launcher requests Chromium's translation UI to be disabled. Browser packaging and versions may behave differently. If a translation popup remains visible, close Chromium before adjusting settings within the **dedicated kiosk profile**. See [Troubleshooting](docs/TROUBLESHOOTING.md).

## Privacy and safety

Never commit local configuration containing private URLs, login tokens, passwords, IP addresses or browser data. Kiosk mode is **not** a complete OS security boundary; use operating-system restrictions for publicly accessible terminals.

## Contributing

Run `bash -n kiosk.sh scripts/*.sh` before submitting a change. See [CONTRIBUTING.md](CONTRIBUTING.md) and [SECURITY.md](SECURITY.md).

## License

MIT — see [LICENSE](LICENSE).
