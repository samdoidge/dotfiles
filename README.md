# Dotfiles

Privacy-first Mac setup for development.

## Quick Start

```bash
git clone https://github.com/samdoidge/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install.sh
```

## Structure

```
~/.dotfiles/
├── apps/
│   ├── brave.sh          # Browser privacy policies
│   └── vscodium/         # Editor settings
├── macos/
│   ├── defaults.sh       # System preferences
│   └── dock.sh           # Dock layout
├── shell/
│   ├── .zshrc            # Shell config
│   ├── .gitconfig        # Git config (shared)
│   └── .gitconfig.local.template  # Personal git config template
├── install.sh
└── Brewfile
```

## Tools

| Purpose | Tool | Why |
|---------|------|-----|
| Terminal | Ghostty | Fast, native |
| Editor | VSCodium | VS Code without telemetry |
| Browser | Brave | Privacy policies enforced |
| Docker | Colima | No telemetry |
| Python | uv | Fast environment manager |
| AI | Claude Code | Best AI coding tool |
| Windows | Rectangle | Keyboard-driven |
| VPN | Proton VPN | Free tier, Swiss, no-logs |
| DNS | Cloudflare | 1.1.1.1, no logging |
| Notes | Obsidian | Local-first, iCloud sync |

## Privacy

**macOS:**
- Siri, analytics, ad tracking disabled
- Spotlight suggestions disabled
- Firewall + stealth mode enabled
- Handoff disabled

**Brave (managed policies):**
- Leo AI, Rewards, Wallet, VPN disabled
- Autofill disabled
- Third-party cookies blocked
- WebRTC IP leak prevented
- Telemetry disabled

**Shell:**
- Telemetry opt-outs for npm, Python, cloud tools

## Aliases

| Alias | Action |
|-------|--------|
| `c` | Claude Code |
| `up` | Update all tools |
| `sync` | Pull dotfiles and update |
| `code` | VSCodium |

## Post-Install Setup

### 1. Git identity
Edit `~/.gitconfig.local` (created by install.sh, not tracked in git):
```
[user]
    name = Your Name
    email = your@email.com
```

### 2. SSH key (auth + signing)
```bash
# Generate key
ssh-keygen -t ed25519 -C "your@email.com"

# Add to Keychain (enter passphrase once)
ssh-add --apple-use-keychain ~/.ssh/id_ed25519

# Auto-load config
cat >> ~/.ssh/config << 'EOF'
Host *
    AddKeysToAgent yes
    UseKeychain yes
    IdentityFile ~/.ssh/id_ed25519
EOF

# Copy for GitHub
cat ~/.ssh/id_ed25519.pub | pbcopy
```

Add to GitHub **twice** (Settings → SSH keys):
- As **Authentication Key**
- As **Signing Key**

### 3. Enable commit signing (optional)
Uncomment in `~/.gitconfig.local`:
```
signingkey = ~/.ssh/id_ed25519.pub

[gpg]
    format = ssh

[commit]
    gpgsign = true
```

**Note:** If using Claude Code / AI tools to make commits, leave signing disabled or they'll fail.

### 4. iCloud setup
Sign into iCloud, then:
- Enable **iCloud Drive** (apps sync automatically)
- Keep **Desktop & Documents** off (enforced by defaults.sh)
- Disable sync for apps you don't need: **System Settings → Apple ID → iCloud → Show More Apps** (toggle off Notes, Stocks, Home, etc.)
- Optional: Enable "Optimize Mac Storage"

Obsidian vault syncs via iCloud automatically once signed in.

### 5. Manual steps
- **Rectangle**: Grant accessibility permissions
- **Brave**: Set as default browser (System Settings → Desktop & Dock)
- **Brave**: Hide sidebar (Settings → Appearance → Show sidebar button → off)
- **Proton VPN**: Sign in (free account works)

## Maintenance

```bash
up      # Update brew, npm, Claude Code
sync    # Pull dotfiles, run brew bundle
```
