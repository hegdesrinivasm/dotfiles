# dotfiles

Personal dotfiles and system provisioning for a three-machine setup
(Manjaro/Fedora, macOS, Windows).

## What this repo manages

- **chezmoi** — dotfiles (shell configs, editors, terminal, opencode).
- **Ansible** — system provisioning (apps, developer tools, default shell) in `ansible/`.

## Machines

| Machine | Converged by |
|---|---|
| Manjaro / Fedora (Linux) | itself via `bootstrap.sh` |
| macOS | itself via `bootstrap.sh` (also the control node for Windows) |
| Windows (stationary desktop) | pushed from the Mac over SSH |

## Fresh setup on Unix (Manjaro / Fedora / macOS)

One command installs Ansible, clones this repo to `~/dotfiles`, and converges the
machine (apps, developer tools, shell, dotfiles via chezmoi):

    curl -fsSL https://raw.githubusercontent.com/hegdesrinivasm/dotfiles/chezmoi/ansible/bootstrap.sh | bash

## Re-run to converge

    ~/dotfiles/ansible/bootstrap.sh

Safe to re-run anytime; installs anything missing since the last run.

## Windows

Windows cannot run Ansible itself, so the Mac converges it over SSH.

One-time setup on Windows (admin PowerShell), only for a brand-new machine:

    Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0
    Start-Service sshd
    Set-Service -Name sshd -StartupType Automatic
    # Then add the Mac's public key to C:\ProgramData\ssh\administrators_authorized_keys

From the Mac, converge Windows:

    ansible-playbook -i ~/dotfiles/ansible/inventories/hosts.yml --limit windows ~/dotfiles/ansible/playbooks/site.yml

## Layout

    ansible/
      bootstrap.sh                       one-command installer + converge
      playbooks/site.yml                 the playbook (common → apps → dotfiles → shell)
      inventories/hosts.yml              Windows host (for the Mac push)
      inventories/group_vars/*.yml       per-OS app lists
      roles/                             common, apps, dotfiles, shell
