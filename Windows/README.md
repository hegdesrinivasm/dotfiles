# Windows Setup

Run `setup.bat` from **Command Prompt (cmd)** — not PowerShell.

### Steps

1. Open **Command Prompt as Administrator** (Win+R, type `cmd`, Ctrl+Shift+Enter).
2. Navigate to this directory:
   ```
   cd <directory>\dotfiles\Windows
   ```
   (or wherever you've placed this repo)
3. Run the script:
   ```
   setup.bat
   ```

The script installs winget if missing, then installs all apps from the official winget repository (`--source winget`), avoiding the Microsoft Store.
