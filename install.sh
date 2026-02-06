#!/bin/bash
# ============================================
# install.sh - Master Installation Script
# ============================================
# Run on new Mac: ~/.dotfiles/install.sh
# Safe to run multiple times (idempotent)
# ============================================

set -e

echo ""
echo "============================================"
echo "  Privacy-First Mac Setup"
echo "  (Safe to re-run anytime)"
echo "============================================"
echo ""

# ============================================
# XCODE CLI TOOLS
# ============================================
if ! xcode-select -p &> /dev/null; then
    echo "Installing Xcode Command Line Tools..."
    xcode-select --install
    echo "Please complete the installation and run this script again."
    exit 1
fi

# ============================================
# HOMEBREW
# ============================================
if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Ensure brew is in path (idempotent)
eval "$(/opt/homebrew/bin/brew shellenv)"
if ! grep -q 'brew shellenv' ~/.zprofile 2>/dev/null; then
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
fi

echo "Disabling Homebrew analytics..."
brew analytics off

# ============================================
# BREW PACKAGES
# ============================================
echo ""
echo "Updating Homebrew..."
brew update

echo ""
echo "Installing packages from Brewfile..."

brew bundle --file=~/.dotfiles/Brewfile || echo "Some packages may have warnings (usually safe to ignore)"

# ============================================
# CLAUDE CODE (direct install - always latest, no Homebrew lag)
# ============================================
echo ""
echo "Installing/updating Claude Code..."

# Remove Homebrew cask version if present
if brew list --cask claude-code &>/dev/null; then
    echo "Removing Homebrew claude-code cask (switching to direct install)..."
    brew uninstall --cask claude-code
fi

# Remove npm global version if present
if command -v npm &>/dev/null && npm list -g @anthropic-ai/claude-code &>/dev/null 2>&1; then
    echo "Removing npm-installed claude-code..."
    npm uninstall -g @anthropic-ai/claude-code 2>/dev/null || true
fi

# Install/update via official installer
curl -fsSL https://claude.ai/install.sh | bash

# ============================================
# GET SHIT DONE (GSD) for Claude Code
# ============================================
echo ""
echo "Installing Get Shit Done (GSD) for Claude Code..."
npx -y get-shit-done-cc --claude --global

# ============================================
# LINK DOTFILES
# ============================================
echo ""
echo "Linking dotfiles..."

# Backup existing files
if [ -f ~/.zshrc ] && [ ! -L ~/.zshrc ]; then
    echo "Backing up existing .zshrc to .zshrc.backup"
    mv ~/.zshrc ~/.zshrc.backup
fi

if [ -f ~/.gitconfig ] && [ ! -L ~/.gitconfig ]; then
    echo "Backing up existing .gitconfig to .gitconfig.backup"
    mv ~/.gitconfig ~/.gitconfig.backup
fi

# Create symlinks
ln -sf ~/.dotfiles/shell/.zshrc ~/.zshrc
ln -sf ~/.dotfiles/shell/.gitconfig ~/.gitconfig

# Create .gitconfig.local from template if it doesn't exist
if [ ! -f ~/.gitconfig.local ]; then
    echo "Creating ~/.gitconfig.local from template..."
    cp ~/.dotfiles/shell/.gitconfig.local.template ~/.gitconfig.local
    echo "  → Edit ~/.gitconfig.local with your name/email"
fi

# ============================================
# VSCODIUM CONFIG
# ============================================
echo ""
echo "Setting up VSCodium config..."
VSCODIUM_DIR="$HOME/Library/Application Support/VSCodium/User"
mkdir -p "$VSCODIUM_DIR"
ln -sf ~/.dotfiles/apps/vscodium/settings.json "$VSCODIUM_DIR/settings.json"

# ============================================
# GHOSTTY CONFIG
# ============================================
echo ""
echo "Setting up Ghostty config..."
mkdir -p ~/.config/ghostty
cat > ~/.config/ghostty/config << 'EOF'
theme = GitHub Dark Default
font-size = 14
font-thicken = true
window-padding-x = 10
window-padding-y = 10
copy-on-select = true
confirm-close-surface = false
EOF

# ============================================
# MACOS SETTINGS
# ============================================
echo ""
echo "Applying macOS settings..."
chmod +x ~/.dotfiles/macos/defaults.sh
~/.dotfiles/macos/defaults.sh

# ============================================
# DOCK
# ============================================
echo ""
echo "Setting up Dock..."
chmod +x ~/.dotfiles/macos/dock.sh
~/.dotfiles/macos/dock.sh

# ============================================
# BRAVE BROWSER PRIVACY
# ============================================
echo ""
~/.dotfiles/apps/brave.sh

# ============================================
# REMOVE BLOATWARE (optional)
# ============================================
echo ""
echo "Removing Apple bloatware..."
BLOAT_APPS=(
  "/Applications/GarageBand.app"
  "/Applications/Keynote.app"
  "/Applications/Numbers.app"
  "/Applications/Pages.app"
)

for app in "${BLOAT_APPS[@]}"; do
  if [ -d "$app" ]; then
    echo "Removing $(basename "$app")..."
    sudo rm -rf "$app"
  fi
done

# ============================================
# GIT CONFIG REMINDER
# ============================================
echo ""
echo "============================================"
echo "  IMPORTANT: Update Git Config!"
echo "============================================"
echo ""
echo "Edit ~/.gitconfig.local (NOT tracked in git) and set:"
echo "  - name = Your Name"
echo "  - email = your@email.com"
echo ""
echo "Your personal info stays local - no more stashing on pull!"
echo ""

# ============================================
# SSH KEY REMINDER
# ============================================
echo "============================================"
echo "  SSH Key Setup"
echo "============================================"
echo ""
echo "Generate new SSH key:"
echo "  ssh-keygen -t ed25519 -C \"mac-\$(date +%Y)\""
echo ""
echo "Copy public key:"
echo "  cat ~/.ssh/id_ed25519.pub | pbcopy"
echo ""
echo "Add to GitHub:"
echo "  https://github.com/settings/ssh/new"
echo ""

# ============================================
# DONE
# ============================================
echo "============================================"
echo "  Setup Complete!"
echo "============================================"
echo ""
echo "Next steps:"
echo "  1. Restart your terminal"
echo "  2. Update git config with your name/email"
echo "  3. Generate SSH key and add to GitHub"
echo "  4. Open apps and complete their setup:"
echo "     - Rectangle: Grant accessibility permissions"
echo "     - DNS: Already set to Cloudflare (1.1.1.1)"
echo "     - Bitwarden: Sign in"
echo "     - Brave: Enable Shields (Aggressive, Strict HTTPS, Block fingerprinting)"
echo ""
echo "Quick commands:"
echo "  c        - Launch Claude Code"
echo "  up       - Update all tools"
echo "  /gsd:help - GSD commands (inside Claude Code)"
echo ""
