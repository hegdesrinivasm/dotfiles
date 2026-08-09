#!/usr/bin/env zsh
setopt PIPE_FAIL

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

info()  { echo -e "${GREEN}[✓]${NC} $1"; }
warn()  { echo -e "${YELLOW}[!]${NC} $1"; }
error() { echo -e "${RED}[✗]${NC} $1"; }

app_installed() {
    local cmd="$1"
    if command -v "$cmd" &>/dev/null; then
        return 0
    fi
    local search_paths=(
        "/usr/local/bin/$cmd"
        "$HOME/.local/bin/$cmd"
        "$HOME/.opencode/bin/$cmd"
        "/usr/bin/$cmd"
    )
    for p in "${search_paths[@]}"; do
        if [[ -x "$p" ]]; then
            return 0
        fi
    done
    return 1
}

check_root() {
    if [[ $EUID -ne 0 ]]; then
        error "This script must be run as root (use sudo)."
        exit 1
    fi
}

preflight_check() {
    echo ""
    echo "==================================="
    echo "   Pre-flight Status Check"
    echo "==================================="
    echo ""
    local apps=("code" "opencode" "gh" "ollama" "nu" "ghostty" "chezmoi" "node" "java" "pyenv" "git")
    for app in "${apps[@]}"; do
        if app_installed "$app"; then
            warn "$app is already installed."
        else
            info "$app is NOT installed (will install)."
        fi
    done

    local flatpak_apps=("com.bitwarden.desktop" "io.ente.auth")
    for app in "${flatpak_apps[@]}"; do
        if flatpak list --columns=application 2>/dev/null | grep -q "$app"; then
            warn "$app is already installed."
        else
            info "$app is NOT installed (will install)."
        fi
    done
    echo ""
}

install_dev_tools() {
    info "Installing development tools..."
    dnf group install -y development-tools \
        || { error "Failed to install development tools group"; return 1; }

    dnf install -y -q nodejs java-latest-openjdk zlib-devel bzip2 bzip2-devel \
        readline-devel sqlite-devel openssl-devel tk-devel libffi-devel xz-devel \
        || { error "Failed to install Node.js, OpenJDK, or pyenv build dependencies"; return 1; }

    if app_installed "pyenv"; then
        warn "pyenv is already installed. Skipping."
    else
        info "Installing pyenv..."
        local pyenv_user="${SUDO_USER:-$USER}"
        sudo -H -u "$pyenv_user" bash -c 'curl -fsSL https://pyenv.run | bash' \
            || { error "Failed to install pyenv"; return 1; }
        info "pyenv installed. Restart your shell to use it."
    fi

    info "Development tools installed."
}

install_vscode() {
    if app_installed "code"; then
        warn "Visual Studio Code is already installed. Skipping."
        return 0
    fi

    info "Installing Visual Studio Code..."
    rpm --import https://packages.microsoft.com/keys/microsoft.asc || { error "Failed to import VS Code GPG key"; return 1; }

    echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" \
        > /etc/yum.repos.d/vscode.repo

    dnf install -y -q code || { error "Failed to install VS Code"; return 1; }
    info "Visual Studio Code installed."
}

install_opencode() {
    if app_installed "opencode"; then
        warn "Opencode is already installed. Skipping."
        return 0
    fi

    info "Installing Opencode..."
    curl -fsSL https://opencode.ai/install | bash || { error "Failed to install Opencode"; return 1; }
    info "Opencode installed."
}

install_ollama() {
    if app_installed "ollama"; then
        warn "Ollama Desktop App is already installed. Skipping."
        return 0
    fi

    info "Installing Ollama Desktop App..."

    curl -fsSL https://ollama.com/download/ollama-linux-amd64.rpm -o /tmp/ollama-linux-amd64.rpm \
        || { error "Failed to download Ollama RPM"; return 1; }
    dnf install -y -q /tmp/ollama-linux-amd64.rpm || { error "Failed to install Ollama"; rm -f /tmp/ollama-linux-amd64.rpm; return 1; }
    rm -f /tmp/ollama-linux-amd64.rpm

    info "Ollama Desktop App installed."
}

install_gh_cli() {
    if app_installed "gh"; then
        warn "GitHub CLI is already installed. Skipping."
        return 0
    fi

    info "Installing GitHub CLI..."
    dnf config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo \
        || { error "Failed to add GitHub CLI repo"; return 1; }

    dnf install -y -q gh || { error "Failed to install GitHub CLI"; return 1; }
    info "GitHub CLI installed."
}

install_nushell() {
    if app_installed "nu"; then
        warn "Nushell is already installed. Skipping."
        return 0
    fi

    info "Installing Nushell..."
    dnf install -y -q nushell || { error "Failed to install Nushell"; return 1; }
    info "Nushell installed."
}

install_ghostty() {
    if app_installed "ghostty"; then
        warn "Ghostty is already installed. Skipping."
        return 0
    fi

    info "Installing Ghostty terminal..."
    dnf copr enable pgdev/ghostty -y || { error "Failed to enable Ghostty COPR"; return 1; }
    dnf install -y -q ghostty || { error "Failed to install Ghostty"; return 1; }
    info "Ghostty terminal installed."
}

install_bitwarden() {
    if flatpak list --columns=application 2>/dev/null | grep -q "com.bitwarden.desktop"; then
        warn "Bitwarden is already installed. Skipping."
        return 0
    fi

    info "Installing Bitwarden..."
    flatpak install -y flathub com.bitwarden.desktop || { error "Failed to install Bitwarden"; return 1; }
    info "Bitwarden installed."
}

install_ente_auth() {
    if flatpak list --columns=application 2>/dev/null | grep -q "io.ente.auth"; then
        warn "Ente Auth is already installed. Skipping."
        return 0
    fi

    info "Installing Ente Auth..."
    flatpak install -y flathub io.ente.auth || { error "Failed to install Ente Auth"; return 1; }
    info "Ente Auth installed."
}

install_chezmoi() {
    if app_installed "chezmoi"; then
        warn "Chezmoi is already installed. Skipping."
        return 0
    fi

    info "Installing Chezmoi..."
    dnf install -y -q chezmoi || { error "Failed to install Chezmoi"; return 1; }
    info "Chezmoi installed."
}

main() {
    check_root
    preflight_check

    echo ""
    echo "==================================="
    echo "   Application Installer Script"
    echo "==================================="
    echo ""

    dnf check-update -q || true

    local failed=0

    flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

    install_dev_tools || { error "Failed to install development tools. Aborting."; exit 1; }

    install_vscode    || (( failed++ ))
    install_opencode  || (( failed++ ))
    install_gh_cli    || (( failed++ ))
    install_ollama    || (( failed++ ))
    install_nushell   || (( failed++ ))
    install_ghostty   || (( failed++ ))
    install_bitwarden || (( failed++ ))
    install_ente_auth || (( failed++ ))
    install_chezmoi   || (( failed++ ))

    echo ""
    if (( failed > 0 )); then
        error "$failed application(s) failed to install. Check the output above for details."
    else
        info "All applications installed successfully!"
    fi
    echo ""
}

main "$@"
