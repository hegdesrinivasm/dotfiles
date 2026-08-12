#!/usr/bin/env powershell
# One-command bootstrap for Windows: installs chezmoi and converges dotfiles.
# Usage:
#   powershell -ExecutionPolicy Bypass -c "irm https://raw.githubusercontent.com/hegdesrinivasm/dotfiles/chezmoi/bootstrap.ps1 | iex"

$ErrorActionPreference = "Stop"

$RepoUrl = if ($args.Count -gt 0) { $args[0] } else { "https://github.com/hegdesrinivasm/dotfiles.git" }

function Install-Chezmoi {
    if (Get-Command winget -ErrorAction SilentlyContinue) {
        winget install --id twpayne.chezmoi --silent --accept-package-agreements --accept-source-agreements
        if ($LASTEXITCODE -ne 0) { throw "winget install failed for twpayne.chezmoi" }
    } else {
        throw "winget not found. bootstrap.ps1 requires winget (Windows 10 1809+ or Windows 11)."
    }
}

if (-not (Get-Command chezmoi -ErrorAction SilentlyContinue)) {
    Write-Host "chezmoi not found; installing via winget..." -ForegroundColor Yellow
    Install-Chezmoi
}

# Ensure the freshly installed chezmoi is on PATH for this session.
if (-not (Get-Command chezmoi -ErrorAction SilentlyContinue)) {
    $env:Path = "$env:LOCALAPPDATA\Microsoft\WinGet\Links;$env:Path"
}

if (-not (Get-Command chezmoi -ErrorAction SilentlyContinue)) {
    throw "chezmoi not found on PATH after install; start a new shell and re-run this script."
}

chezmoi init --apply $RepoUrl
if ($LASTEXITCODE -ne 0) { throw "chezmoi init --apply failed" }

Write-Host "Bootstrap complete." -ForegroundColor Green
