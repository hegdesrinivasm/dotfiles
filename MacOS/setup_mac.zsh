#!/bin/zsh

# macOS Setup Script
# Installs Homebrew, CLI Tools, and specific applications.

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}Starting macOS setup script...${NC}"

# -----------------------------------------------------------------------------
# 1. Install Command Line Tools & Homebrew
# -----------------------------------------------------------------------------

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
    echo -e "${BLUE}Homebrew not found. Installing Homebrew...${NC}"
    # This command also triggers the installation of Xcode Command Line Tools if missing
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Add Homebrew to PATH for the current session
    if [[ -f /opt/homebrew/bin/brew ]]; then
        echo -e "${BLUE}Configuring Homebrew for Apple Silicon...${NC}"
        eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [[ -f /usr/local/bin/brew ]]; then
        echo -e "${BLUE}Configuring Homebrew for Intel Mac...${NC}"
        eval "$(/usr/local/bin/brew shellenv)"
    fi
else
    echo -e "${GREEN}Homebrew is already installed.${NC}"
fi

# Make sure we are using the latest Homebrew
echo -e "${BLUE}Updating Homebrew...${NC}"
brew update

# -----------------------------------------------------------------------------
# 2. Install Command Line Utilities (Formulae)
# -----------------------------------------------------------------------------

echo -e "${BLUE}Installing Command Line Utilities...${NC}"

# List of formulae to install
formulae=(
    python
    git
)

for formula in "${formulae[@]}"; do
    if brew list --formula | grep -q "^${formula}$"; then
        echo -e "${GREEN}$formula is already installed.${NC}"
    else
        echo -e "${BLUE}Installing $formula...${NC}"
        brew install "$formula"
    fi
done

# -----------------------------------------------------------------------------
# 3. Install GUI Applications (Casks)
# -----------------------------------------------------------------------------

echo -e "${BLUE}Installing GUI Applications (Casks)...${NC}"

# List of casks to install
casks=(
    visual-studio-code
    notion
    microsoft-edge
    discord
    signal
    raycast
    vlc
    ticktick
    localsend
)

for cask in "${casks[@]}"; do
    if brew list --cask | grep -q "^${cask}$"; then
        echo -e "${GREEN}$cask is already installed.${NC}"
    else
        echo -e "${BLUE}Installing $cask...${NC}"
        brew install --cask "$cask"
    fi
done

# -----------------------------------------------------------------------------
# 4. Cleanup
# -----------------------------------------------------------------------------

echo -e "${BLUE}Cleaning up...${NC}"
brew cleanup

echo -e "${GREEN}Setup complete! You may need to restart your terminal or computer.${NC}"