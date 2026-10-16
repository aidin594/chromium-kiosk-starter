# Troubleshooting

## Browser fails to start

Check that Chromium is installed:

```bash
command -v chromium-browser || command -v chromium
```

Launch as the same user who owns the graphical X11 session and check `DISPLAY` and Xauthority permissions.

## Blank display

Confirm the remote URL is reachable and that the desktop is using X11, not Wayland. The launcher cannot create an X session.

## Multiple Chromium windows

Disable other autostart scripts or systemd services that launch Chromium. Run only one kiosk launcher per desktop session.

## Translation prompt

The launcher passes `--disable-features=Translate,TranslateUI`, but Chromium versions may differ. Close the browser fully before changing preferences within the isolated kiosk profile. Do not copy a personal browser profile into the project.

## Browser continually restarts

Try opening the configured URL in a standard Chromium session, check user access to the configured profile directory, and inspect output from `./kiosk.sh`.

## Stop the launcher

Press Ctrl+C if launched in a terminal, or stop the autostart-launched process from your session manager. Removing autostart prevents a new launch at the next graphical login; it does not necessarily terminate a running browser.
