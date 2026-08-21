# dotfiles

Personal dotfiles and system provisioning for a three-machine setup
(Manjaro/Fedora, macOS, Windows).

## What this repo manages

- **chezmoi** — dotfiles (shell configs, editor, terminal, opencode), Windows
  app provisioning via `run_once_after_*.ps1.tmpl` scripts, and user-CLI tools
  on Unix (e.g. opencode) via `run_once_before_*.sh.tmpl` scripts.
- **Ansible** — Unix system provisioning (apps, developer tools, default
  shell) in `ansible/`.

## Machines

| Machine | Converged by |
|---|---|
| Manjaro / Fedora (Linux) | itself via `ansible/bootstrap.sh` |
| macOS | itself via `ansible/bootstrap.sh` |
| Windows (stationary desktop) | itself via `bootstrap.ps1` (pure chezmoi) |

## Fresh setup on Unix (Manjaro / Fedora / macOS)

One command installs Ansible, clones this repo to `~/.local/share/chezmoi`
(chezmoi's source state — the only checkout), and converges the machine
(apps, developer tools, shell, dotfiles via chezmoi):

    curl -fsSL https://raw.githubusercontent.com/hegdesrinivasm/dotfiles/chezmoi/ansible/bootstrap.sh | bash

## Fresh setup on Windows

One command installs chezmoi and converges the machine (dotfiles, winget apps,
Windows Terminal, pyenv-win) — no SSH or second machine required:

    powershell -ExecutionPolicy Bypass -c "irm https://raw.githubusercontent.com/hegdesrinivasm/dotfiles/chezmoi/bootstrap.ps1 | iex"

## Re-run to converge

Unix:

    ~/.local/share/chezmoi/ansible/bootstrap.sh

Windows:

    powershell -ExecutionPolicy Bypass -c "irm https://raw.githubusercontent.com/hegdesrinivasm/dotfiles/chezmoi/bootstrap.ps1 | iex"

Safe to re-run anytime; installs anything missing since the last run.

## Layout

    ansible/
      bootstrap.sh                       one-command installer + converge (Unix)
      playbooks/site.yml                 the playbook (common → apps → dotfiles → shell)
      inventories/group_vars/*.yml       per-OS app lists
      roles/                             common, apps, dotfiles, shell
    bootstrap.ps1                        one-command bootstrap (Windows)
    run_once_after_install-apps.ps1.tmpl winget apps + pyenv-win on Windows
    run_once_after_windows-terminal.ps1.tmpl nushell as default Windows Terminal profile
