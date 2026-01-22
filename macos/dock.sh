#!/bin/bash
# ============================================
# dock.sh - Dock Configuration
# ============================================
# Run: chmod +x dock.sh && ./dock.sh
# Requires: brew install dockutil
# ============================================

echo "============================================"
echo "  Setting Up Dock"
echo "============================================"

# Check if dockutil is installed
if ! command -v dockutil &> /dev/null; then
    echo "dockutil not found. Installing..."
    brew install dockutil
fi

echo "Removing all dock items..."
dockutil --remove all --no-restart

echo "Adding apps..."

# Development
dockutil --add /Applications/Ghostty.app --no-restart
dockutil --add /Applications/VSCodium.app --no-restart

# Browser
dockutil --add /Applications/Brave\ Browser.app --no-restart

# Spacer
dockutil --add '' --type spacer --section apps --no-restart

# Utilities
dockutil --add /System/Applications/System\ Settings.app --no-restart
dockutil --add /Applications/Bitwarden.app --no-restart

# Optional: Add Downloads folder (uncomment if wanted)
# dockutil --add ~/Downloads --view fan --display folder --no-restart

echo "Restarting Dock..."
killall Dock

echo ""
echo "============================================"
echo "  Dock configured!"
echo "============================================"
