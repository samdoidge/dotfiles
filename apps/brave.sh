#!/bin/bash
# ============================================
# Brave Browser Privacy Configuration
# ============================================
# Uses managed preferences (requires sudo) to enforce policies
# Verify at brave://policy - Level should show 'Mandatory'
#
# Note: Shields settings (aggressive blocking, HTTPS strict mode)
# cannot be set via policy - must be configured manually once
# ============================================

# Check if Brave is installed
if [ ! -d "/Applications/Brave Browser.app" ]; then
  echo "Brave Browser not installed, skipping configuration..."
  exit 0
fi

echo "Configuring Brave Browser privacy settings..."

# Quit Brave if running
killall "Brave Browser" 2>/dev/null
sleep 1

# Create managed preferences directory if needed
sudo mkdir -p "/Library/Managed Preferences"

PLIST="/Library/Managed Preferences/com.brave.Browser.plist"

# Remove old plist to start fresh
sudo rm -f "$PLIST"

# Create plist with all policies
sudo /usr/libexec/PlistBuddy -c "Add :BraveRewardsDisabled bool true" "$PLIST"
sudo /usr/libexec/PlistBuddy -c "Add :BraveWalletDisabled bool true" "$PLIST"
sudo /usr/libexec/PlistBuddy -c "Add :BraveVPNDisabled bool true" "$PLIST"
sudo /usr/libexec/PlistBuddy -c "Add :BraveAIChatEnabled bool false" "$PLIST"
sudo /usr/libexec/PlistBuddy -c "Add :PasswordManagerEnabled bool false" "$PLIST"
sudo /usr/libexec/PlistBuddy -c "Add :AutofillAddressEnabled bool false" "$PLIST"
sudo /usr/libexec/PlistBuddy -c "Add :AutofillCreditCardEnabled bool false" "$PLIST"
sudo /usr/libexec/PlistBuddy -c "Add :BlockThirdPartyCookies bool true" "$PLIST"
sudo /usr/libexec/PlistBuddy -c "Add :WebRtcIPHandling string disable_non_proxied_udp" "$PLIST"
sudo /usr/libexec/PlistBuddy -c "Add :BrowserSignin integer 0" "$PLIST"
sudo /usr/libexec/PlistBuddy -c "Add :SafeBrowsingProtectionLevel integer 0" "$PLIST"
sudo /usr/libexec/PlistBuddy -c "Add :SafeBrowsingExtendedReportingEnabled bool false" "$PLIST"
sudo /usr/libexec/PlistBuddy -c "Add :UrlKeyedAnonymizedDataCollectionEnabled bool false" "$PLIST"
sudo /usr/libexec/PlistBuddy -c "Add :FeedbackSurveysEnabled bool false" "$PLIST"

# Additional privacy policies
sudo /usr/libexec/PlistBuddy -c "Add :SpellCheckServiceEnabled bool false" "$PLIST"
sudo /usr/libexec/PlistBuddy -c "Add :TranslateEnabled bool false" "$PLIST"
sudo /usr/libexec/PlistBuddy -c "Add :SyncDisabled bool true" "$PLIST"
sudo /usr/libexec/PlistBuddy -c "Add :SearchSuggestEnabled bool false" "$PLIST"
sudo /usr/libexec/PlistBuddy -c "Add :AlternateErrorPagesEnabled bool false" "$PLIST"
sudo /usr/libexec/PlistBuddy -c "Add :NetworkPredictionOptions integer 2" "$PLIST"
sudo /usr/libexec/PlistBuddy -c "Add :PaymentMethodQueryEnabled bool false" "$PLIST"
sudo /usr/libexec/PlistBuddy -c "Add :AutofillPaymentCardBenefits bool false" "$PLIST"

# Performance (laptop battery optimization)
sudo /usr/libexec/PlistBuddy -c "Add :HighEfficiencyModeEnabled bool true" "$PLIST"
sudo /usr/libexec/PlistBuddy -c "Add :BatterySaverModeAvailability integer 1" "$PLIST"

# Note: Brave sidebar cannot be disabled via policy (Brave-specific, not Chromium).
# Disable manually: Settings → Appearance → Show sidebar button (toggle off)

# Disable local network scanning (prevents "find devices on local network" prompt)
sudo /usr/libexec/PlistBuddy -c "Add :EnableMediaRouter bool false" "$PLIST"

# Clear macOS preference cache
sudo killall cfprefsd 2>/dev/null

echo ""
echo "Done! Policies applied via managed preferences."
echo "Open Brave and check brave://policy - Level should show 'Mandatory'"
echo ""
echo "MANUAL STEPS REQUIRED:"
echo "  1. Set default browser: System Settings → Desktop & Dock → Default web browser"
echo "  2. Shields: brave://settings/shields → Aggressive, Strict HTTPS, Block fingerprinting"
echo "  3. Hide sidebar: Settings → Appearance → Show sidebar button (toggle off)"
