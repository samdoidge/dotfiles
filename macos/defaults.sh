#!/bin/bash
# ============================================
# defaults.sh - macOS System Preferences
# ============================================
# Run: chmod +x defaults.sh && ./defaults.sh
# ============================================

echo "============================================"
echo "  Applying macOS Settings"
echo "============================================"

# Close System Preferences to prevent conflicts
osascript -e 'tell application "System Preferences" to quit' 2>/dev/null

# ============================================
# PRIVACY
# ============================================
echo "Applying privacy settings..."

# Disable Siri
defaults write com.apple.assistant.support "Assistant Enabled" -bool false
defaults write com.apple.Siri StatusMenuVisible -bool false

# Disable ad tracking
defaults write com.apple.AdLib allowApplePersonalizedAdvertising -bool false

# Disable crash reporter
defaults write com.apple.CrashReporter DialogType -string "none"

# Disable .DS_Store on network and USB drives
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Disable Handoff (syncs activity between devices via Apple servers)
defaults write com.apple.coreservices.useractivityd.plist "ActivityAdvertisingAllowed" -bool false
defaults write com.apple.coreservices.useractivityd.plist "ActivityReceivingAllowed" -bool false

# Disable Spotlight Suggestions (sends searches to Apple)
defaults write com.apple.spotlight orderedItems -array \
  '{"enabled" = 1;"name" = "APPLICATIONS";}' \
  '{"enabled" = 1;"name" = "SYSTEM_PREFS";}' \
  '{"enabled" = 1;"name" = "DIRECTORIES";}' \
  '{"enabled" = 1;"name" = "PDF";}' \
  '{"enabled" = 1;"name" = "DOCUMENTS";}' \
  '{"enabled" = 1;"name" = "PRESENTATIONS";}' \
  '{"enabled" = 1;"name" = "SPREADSHEETS";}' \
  '{"enabled" = 1;"name" = "SOURCE";}' \
  '{"enabled" = 0;"name" = "FONTS";}' \
  '{"enabled" = 0;"name" = "MESSAGES";}' \
  '{"enabled" = 0;"name" = "CONTACT";}' \
  '{"enabled" = 0;"name" = "EVENT_TODO";}' \
  '{"enabled" = 0;"name" = "IMAGES";}' \
  '{"enabled" = 0;"name" = "BOOKMARKS";}' \
  '{"enabled" = 0;"name" = "MUSIC";}' \
  '{"enabled" = 0;"name" = "MOVIES";}' \
  '{"enabled" = 0;"name" = "MENU_DEFINITION";}' \
  '{"enabled" = 0;"name" = "MENU_OTHER";}' \
  '{"enabled" = 0;"name" = "MENU_CONVERSION";}' \
  '{"enabled" = 0;"name" = "MENU_EXPRESSION";}' \
  '{"enabled" = 0;"name" = "MENU_WEBSEARCH";}' \
  '{"enabled" = 0;"name" = "MENU_SPOTLIGHT_SUGGESTIONS";}'

# ===== SAFARI PRIVACY =====
# Skipped - requires Full Disk Access for terminal, and we use Brave anyway
# To enable: System Settings → Privacy & Security → Full Disk Access → add terminal

# ===== FIREWALL =====
echo "Enabling firewall..."
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setstealthmode on

# ===== DNS =====
# Set Cloudflare DNS (1.1.1.1) - fast, private, no logging
echo "Setting Cloudflare DNS..."
networksetup -setdnsservers Wi-Fi 1.1.1.1 1.0.0.1 2606:4700:4700::1111 2606:4700:4700::1001
# For Ethernet (uncomment if needed)
# networksetup -setdnsservers Ethernet 1.1.1.1 1.0.0.1

# ============================================
# PERFORMANCE
# ============================================
echo "Applying performance settings..."

# Fast key repeat (essential for coding)
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# Disable animations
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false
defaults write -g QLPanelAnimationDuration -float 0
defaults write com.apple.finder DisableAllAnimations -bool true

# Speed up Mission Control animations
defaults write com.apple.dock expose-animation-duration -float 0.1

# Disable window resize animations
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

# ============================================
# ICLOUD
# ============================================
echo "Applying iCloud settings..."

# Disable Desktop & Documents sync (keep local control)
defaults write com.apple.finder FXICloudDriveDesktop -bool false
defaults write com.apple.finder FXICloudDriveDocuments -bool false

# Note: Per-app iCloud sync (Notes, Stocks, Home, etc.) cannot be disabled via defaults.
# Must be toggled manually: System Settings → Apple ID → iCloud → Show More Apps

# ============================================
# FINDER
# ============================================
echo "Applying Finder settings..."

# Show all file extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Show hidden files
defaults write com.apple.finder AppleShowAllFiles -bool true

# Show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Keep folders on top when sorting
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# Search current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Disable warning when changing file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Use list view by default
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# ============================================
# DOCK
# ============================================
echo "Applying Dock settings..."

# Auto-hide dock
defaults write com.apple.dock autohide -bool true

# Remove dock auto-hide delay
defaults write com.apple.dock autohide-delay -float 0

# Faster dock animation
defaults write com.apple.dock autohide-time-modifier -float 0.3

# Set dock icon size (48 = medium, 36 = small, 64 = large)
defaults write com.apple.dock tilesize -int 64

# Don't show recent apps
defaults write com.apple.dock show-recents -bool false

# Minimize to application icon
defaults write com.apple.dock minimize-to-application -bool true

# ============================================
# KEYBOARD
# ============================================
echo "Applying keyboard settings..."

# Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Disable smart quotes
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# Disable smart dashes
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# Disable automatic capitalization
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

# Disable automatic period substitution
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

# Enable full keyboard access for all controls
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# ============================================
# TRACKPAD
# ============================================
echo "Applying trackpad settings..."

# Enable tap to click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Enable three-finger drag
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true

# ============================================
# NOTIFICATIONS
# ============================================
echo "Applying notification settings..."

# Don't show previews when screen is locked
defaults write com.apple.ncprefs show_previews_setting -int 2

# Disable Notification Center entirely (optional - uncomment if wanted)
# launchctl unload -w /System/Library/LaunchAgents/com.apple.notificationcenterui.plist 2>/dev/null

# ============================================
# SCREENSHOTS
# ============================================
echo "Applying screenshot settings..."

# Save screenshots to Downloads
defaults write com.apple.screencapture location -string "${HOME}/Downloads"

# Save screenshots as PNG
defaults write com.apple.screencapture type -string "png"

# Disable shadow in screenshots
defaults write com.apple.screencapture disable-shadow -bool true

# ============================================
# MISC
# ============================================
echo "Applying misc settings..."

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# Disable the "Are you sure you want to open this application?" dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# ============================================
# RESTART AFFECTED APPS
# ============================================
echo "Restarting affected apps..."

killall Finder 2>/dev/null
killall Dock 2>/dev/null
killall SystemUIServer 2>/dev/null

echo ""
echo "============================================"
echo "  Done! Some changes require logout/restart"
echo "============================================"
