# Dotfiles

Privacy-first, high-performance Mac setup for Python / JavaScript development with Docker.

## Quick Start (New Mac)

```bash
git clone https://github.com/samdoidge/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
chmod +x install.sh
./install.sh
```

## What's Included

| File | Purpose |
|------|---------|
| `Brewfile` | All packages and apps |
| `.zshrc` | Shell configuration and aliases |
| `.gitconfig` | Git settings and aliases |
| `macos.sh` | macOS system preferences |
| `dock.sh` | Dock layout |
| `install.sh` | Master setup script |

## Tools

| Purpose | Tool | Why |
|---------|------|-----|
| Terminal | Ghostty | Fast, native, minimal |
| Editor | VSCodium | VS Code without telemetry |
| Browser | Brave | Chromium-based, blocks trackers |
| Docker | Colima | No telemetry, lightweight |
| Python Env | uv | Fast Python env tool. |
| AI | Claude Code | Best available AI tool currently. |
| Windows | Rectangle | Keyboard-driven layout |
| DNS | Cloudflare 1.1.1.1 | Fastest, private, no logging |
| Passwords | Bitwarden | Open-source |

## Key Aliases

| Alias | Action |
|-------|--------|
| `c` | Claude Code (no permission prompts) |
| `up` | Update all tools |
| `sync` | Pull dotfiles and update |

## Privacy Features

- Homebrew analytics disabled
- macOS analytics disabled
- Siri disabled
- Ad tracking disabled
- Telemetry environment variables set
- VSCodium over VS Code
- Colima over Docker Desktop
- Brave with shields up

## Maintenance

### Update everything
```bash
up
```

### Sync dotfiles changes
```bash
sync
```

### Add new packages
1. Edit `Brewfile`
2. Run `brew bundle`
3. Commit and push

## Manual Setup Required

After running `install.sh`:

1. **Git config**: Edit `~/.dotfiles/.gitconfig` with your name/email
2. **SSH key**: Generate and add to GitHub
3. **Rectangle**: Grant accessibility permissions
5. **Bitwarden**: Sign in
6. **Brave**: Set as default browser

## License

MIT
