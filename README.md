# Bash Scripting Foundations

Beginner-friendly Bash scripts for learning shell fundamentals, Linux command-line practice, and safe automation.

## Purpose

This repository collects small Bash scripts for learning practical command-line automation.

The goal is to practice readable shell scripting, simple Linux administration, file operations, package maintenance, network visibility, and safe command-line workflows.

## Repository Focus

This repository focuses on:

- Bash basics
- Script readability
- Safe command-line habits
- Linux administration practice
- File and directory operations
- Simple automation
- Defensive and authorized system maintenance

## How to Run a Script

Review a script before running it:

```bash
cat script-name.sh
```

Make it executable:

```bash
chmod +x script-name.sh
```

Run it:

```bash
./script-name.sh
```

## Safety Notes

These scripts are educational examples. Only run scripts on systems you own, administer, or have explicit permission to use. Do not run system maintenance scripts without understanding what each command does.

## Current Script Categories

| Script | Purpose |
|---|---|
| `extract-ext-IP-using-dig.sh` | Show external IP address using DNS |
| `file-owner.sh` | Check whether the current user owns a file |
| `fix-zsh-corrupt-history.sh` | Help repair a corrupted Zsh history file |
| `install-vbox-guest-additions.sh` | Assist with VirtualBox Guest Additions setup |
| `ips-connected-to-port-80.sh` | Show IPs connected to port 80 |
| `number-sequence-generator.sh` | Print a simple number sequence |
| `rename-to-lowercase.sh` | Rename files in a directory to lowercase |
| `update-n-upgrade.sh` | Run package update and upgrade commands |
| `clean-n-reboot.sh` | Safe system cleanup helper with dry-run behavior by default |

## Archived Unsafe Scripts

Scripts that resemble credential capture, unauthorized access, log tampering, or offensive payloads are not maintained as runnable tools in this beginner repository.

See `archive/unsafe/README.md` for the archive note.

## Responsible Use

This repository is for legal, ethical, educational, and authorized administration only.

## Final Principle

Readable scripts first.  
Safe commands first.  
Understand before running.
