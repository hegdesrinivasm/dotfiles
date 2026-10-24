# dotfiles

Personal dotfiles and system provisioning for a three-machine setup
(Manjaro/Fedora, macOS, Windows). This repo is the chezmoi source state;
Ansible layers Unix system provisioning on top of it.

## What this repo manages

- **chezmoi** — dotfiles and app configs (shells, Ghostty, Neovim, Zed,
  starship, opencode), Windows app provisioning via `run_once_after_*.ps1.tmpl`
  scripts, and user-CLI tools on Unix (e.g. opencode) via
  `.chezmoiscripts/run_once_*.sh.tmpl`.
- **Ansible** — Unix system provisioning in `ansible/`: Homebrew / package
  installs, GUI apps (casks, AUR, Flatpak), the Papirus icon theme (Linux),
  dotfiles convergence via `chezmoi init --apply`, and fish as the default
  shell.

Shared template data (git identity, winget app list, Zed shell, canonical
PATH policy) lives in `.chezmoidata.yaml`.

## Machines

| Machine | Converged by |
|---|---|
| Manjaro / Fedora (Linux) | itself via `ansible/bootstrap.sh` |
| macOS | itself via `ansible/bootstrap.sh` |
| Windows (stationary desktop) | itself via `bootstrap.ps1` (pure chezmoi) |

> The Hyprland desktop stack (hypr/waybar/wofi configs + `hypr_packages`)
> was retired from the main line and lives on the [`hyprland`](/../../tree/hyprland)
> branch if ever needed again.

## How it works

The two tools never run side by side. On Unix, **Ansible runs first and
invokes chezmoi itself** (mid-playbook); on Windows Ansible isn't involved
at all and pure chezmoi does everything.

### Unix pipeline (Manjaro / Fedora / macOS)

    ansible/bootstrap.sh
      ├─ 1. install Ansible if missing (pacman / dnf / pip --user)
      ├─ 2. clone or update this repo → ~/.local/share/chezmoi
      │       (chezmoi's source state — the only checkout, shared by both tools)
      ├─ 3. ansible-galaxy collection install community.general
      └─ 4. ansible-playbook -c local ansible/playbooks/site.yml
            ├─ common         bootstrap Homebrew (macOS); CLI packages via pacman/dnf/brew
            ├─ apps           GUI apps: brew casks (macOS), AUR + Flatpak (Linux),
            │                  extra Fedora repos (ghostty, VS Code, gh, Ollama),
            │                  Ghostty as default terminal via duti (macOS)
            ├─ papirus-icons  Linux-only: Papirus icon theme, set as KDE default
            ├─ dotfiles       install chezmoi, then `chezmoi init --apply`  ← chezmoi runs here
            │     ├─ run_once_before_install-opencode.sh.tmpl   install opencode → ~/.opencode/bin
            │     ├─ apply source state                          shell rc's, dot_config/*,
            │     │                                              Library/ symlinks (macOS only)
            │     └─ run_once_after_starship.sh.tmpl            starship init.nu for nushell
            └─ shell          add fish to /etc/shells, set fish as the login shell

### Windows pipeline (pure chezmoi)

    bootstrap.ps1
      ├─ 1. install chezmoi via winget if missing
      └─ 2. chezmoi init --apply  ← everything happens inside chezmoi
            ├─ apply source state                         nushell, opencode, gitconfig, dot_config/*
            ├─ run_once_after_install-apps.ps1.tmpl       winget apps (list in .chezmoidata.yaml) + pyenv-win
            └─ run_once_after_windows-terminal.ps1.tmpl   nushell as default Windows Terminal profile

On both platforms the `run_once_*` scripts execute at most once per
machine; everything else (Ansible roles, template application) is
idempotent and re-converges on every run.

## Fresh setup on Unix (Manjaro / Fedora / macOS)

One command installs Ansible, clones this repo to `~/.local/share/chezmoi`
(chezmoi's source state — the only checkout), and converges the machine
(packages, apps, icons, shell, dotfiles via chezmoi):

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

    .chezmoidata.yaml                          shared template data (git identity, winget apps, PATH policy)
    .chezmoiignore                             files excluded from the chezmoi source state
    .chezmoiscripts/                           chezmoi lifecycle scripts (Unix)
      run_once_before_install-opencode.sh.tmpl  install opencode (Windows uses winget instead)
      run_once_after_starship.sh.tmpl           generate starship init.nu for nushell
    bootstrap.ps1                              one-command bootstrap (Windows)
    run_once_after_install-apps.ps1.tmpl       winget apps + pyenv-win (Windows)
    run_once_after_windows-terminal.ps1.tmpl   nushell as default Windows Terminal profile
    dot_zshrc.tmpl dot_bashrc.tmpl dot_profile.tmpl
    dot_gitconfig.tmpl dot_gitignore_global
    dot_config/                                app configs
      fish/        conf.d env bootstrap (PATH from .chezmoidata.yaml)
      shell/       shared env.sh sourced by bash/zsh/profile
      nushell/     config.nu, env.nu
      ghostty/     config + Spiderman themes (symlinked on macOS via Library/)
      nvim/        init.lua + Spiderman colorscheme
      starship.toml (+ spiderman/gruvbox theme variants)
      zed/         private settings (OS-conditional terminal shell)
      opencode/    opencode.jsonc, AGENTS.md, tui.json
    Library/                                  macOS-only symlinks (nushell, ghostty)
    ansible/                                  Unix system provisioning
      bootstrap.sh                            one-command installer + converge
      ansible.cfg requirements.yml            ansible config + community.general dep
      playbooks/site.yml                      common → apps → papirus-icons → dotfiles → shell
      inventories/group_vars/*.yml            per-OS package/app lists (all, manjaro, fedora, macos)
      roles/                                  common, apps, papirus-icons, dotfiles, shell
