# Security Policy

## Supported Versions

Security fixes are provided on the default branch only.

## Reporting a Vulnerability

Please do not open public issues for suspected vulnerabilities.

Email the maintainer with:
- A clear description of the issue
- Steps to reproduce
- Potential impact
- Any suggested remediation

You should receive an acknowledgement within 5 business days and status updates as fixes progress.

## Secrets and Data Handling

- Never commit API keys, tokens, credentials, or private keys.
- Use local `.env` files for secrets (already ignored by `.gitignore`).
- Review generated artifacts before publishing to ensure no sensitive data is embedded.
