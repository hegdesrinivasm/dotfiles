@echo off
setlocal enabledelayedexpansion

set "APPS=Mozilla.Firefox ente-io.auth-desktop Bitwarden.Bitwarden Valve.Steam Microsoft.VisualStudioCode Notion.Notion Tailscale.Tailscale OpenJS.NodeJS.LTS EclipseAdoptium.Temurin.21.JDK Python.Python.3.12 BrechtSanders.WinLibs.POSIX.UCRT GitHub.cli Docker.DockerDesktop Microsoft.PowerToys SST.opencode twpayne.chezmoi Nushell.Nushell"

echo [1/2] Checking for winget...
where winget >nul 2>&1
if %errorlevel% neq 0 (
    echo winget not found. Downloading App Installer...
    curl -L -o "%TEMP%\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle"^
      "https://github.com/microsoft/winget-cli/releases/latest/download/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle"
    if !errorlevel! neq 0 (
        echo Failed to download winget. Please install manually.
        pause
        exit /b 1
    )
    echo Installing App Installer [winget]...
    powershell -Command "Add-AppxPackage -Path '%TEMP%\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle'"
    if !errorlevel! neq 0 (
        echo Failed to install winget. Try running as Administrator.
        pause
        exit /b 1
    )
)

echo [2/2] Installing apps from official winget repository [--source winget]...
for %%a in (%APPS%) do (
    echo Installing %%a...
    winget install --exact --id %%a --source winget --accept-package-agreements --accept-source-agreements
    echo(
)

echo All done!
pause
