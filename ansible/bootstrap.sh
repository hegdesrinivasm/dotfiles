#!/usr/bin/env bash
set -euo pipefail

REPO_URL="https://github.com/hegdesrinivasm/dotfiles.git"
BRANCH="chezmoi"
# Clone straight into chezmoi's source state dir so the repo is checked out
# exactly once and is immediately usable by both ansible and chezmoi.
CHECKOUT_DIR="${HOME}/.local/share/chezmoi"
PLAYBOOK="ansible/playbooks/site.yml"

os="$(uname -s)"

install_ansible() {
    case "${os}" in
        Linux)
            if command -v pacman >/dev/null 2>&1; then
                sudo pacman -S --needed --noconfirm python python-pip ansible
            elif command -v dnf >/dev/null 2>&1; then
                sudo dnf install -y python3 python3-pip ansible-core
            else
                echo "Unsupported Linux distribution" >&2
                exit 1
            fi
            ;;
        Darwin)
            if ! command -v python3 >/dev/null 2>&1; then
                echo "python3 not found; install Xcode Command Line Tools first" >&2
                exit 1
            fi
            python3 -m pip install --user ansible \
                || python3 -m pip install --user --break-system-packages ansible

            # pip --user installs binaries to ~/Library/Python/<ver>/bin or
            # ~/.local/bin. Ensure that directory is on PATH for the rest of
            # this script (and for the user's future sessions if not already).
            _pip_user_bin="$(python3 -c 'import site; print(site.USER_BASE + "/bin")' 2>/dev/null || echo "${HOME}/.local/bin")"
            export PATH="${_pip_user_bin}:${PATH}"

            if ! grep -qsF "${_pip_user_bin}" "${HOME}/.zshrc" "${HOME}/.bashrc" "${HOME}/.profile" 2>/dev/null; then
                echo "export PATH=\"${_pip_user_bin}:\${PATH}\"" >> "${HOME}/.profile"
            fi
            ;;
        *)
            echo "Unsupported OS: ${os}" >&2
            exit 1
            ;;
    esac
}

main() {
    if ! command -v ansible-playbook >/dev/null 2>&1; then
        install_ansible
    fi

    if [[ -d "${CHECKOUT_DIR}/.git" ]]; then
        git -C "${CHECKOUT_DIR}" fetch --quiet origin "${BRANCH}"
        git -C "${CHECKOUT_DIR}" checkout --quiet "${BRANCH}"
        git -C "${CHECKOUT_DIR}" pull --quiet --ff-only origin "${BRANCH}"
    else
        git clone --quiet --branch "${BRANCH}" --single-branch "${REPO_URL}" "${CHECKOUT_DIR}"
    fi

    ansible-galaxy collection install -r "${CHECKOUT_DIR}/ansible/requirements.yml"

    # Cache sudo credentials so the playbook's become tasks run non-interactively.
    if ! sudo -n true 2>/dev/null; then
        sudo -v
    fi

    (cd "${CHECKOUT_DIR}" && ansible-playbook -c local -i localhost, --ask-become-pass "${PLAYBOOK}")
}

main "$@"
