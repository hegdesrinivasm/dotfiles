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
    local apps=("code" "opencode" "antigravity" "gh" "ollama")
    for app in "${apps[@]}"; do
        if app_installed "$app"; then
            warn "$app is already installed."
        else
            info "$app is NOT installed (will install)."
        fi
    done
    echo ""
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

install_antigravity() {
    if app_installed "antigravity"; then
        warn "Google Antigravity is already installed. Skipping."
        return 0
    fi

    info "Installing Google Antigravity..."

    curl -fsSL https://us-central1-apt.pkg.dev/doc/repo-signing-key.gpg \
        | gpg --dearmor -o /etc/pki/rpm-gpg/RPM-GPG-KEY-antigravity \
        || { error "Failed to fetch Antigravity GPG key"; return 1; }

    echo -e "[antigravity]\nname=Google Antigravity\nbaseurl=https://us-central1-apt.pkg.dev/projects/antigravity-auto-updater-dev/antigravity-rpm\nenabled=1\ngpgcheck=1\ngpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-antigravity" \
        > /etc/yum.repos.d/antigravity.repo

    dnf install -y -q antigravity || { error "Failed to install Antigravity"; return 1; }
    info "Google Antigravity installed."
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

    install_vscode    || (( failed++ ))
    install_opencode  || (( failed++ ))
    install_antigravity || (( failed++ ))
    install_gh_cli    || (( failed++ ))
    install_ollama    || (( failed++ ))

    echo ""
    if (( failed > 0 )); then
        error "$failed application(s) failed to install. Check the output above for details."
    else
        info "All applications installed successfully!"
    fi
    echo ""
}

main "$@"
