# Security Policy

This project is a lightweight launcher, **not** a hardened operating system or secure browser sandbox.

## Reporting vulnerabilities

Please do not publish exploitable details or sensitive credentials in public issues. Contact the repository maintainer privately through their GitHub profile to coordinate a report.

## Safe operation

- Use dedicated, unprivileged desktop accounts.
- Keep Chromium and Linux security updates current.
- Do not include credentials or private tokens in kiosk URLs.
- Treat `config/kiosk.conf` as trusted executable shell configuration.
- Do not expose administrative applications on an unattended display.
