# ============================================
# .zshrc - Shell Configuration
# ============================================

# ============================================
# PATH
# ============================================
eval "$(/opt/homebrew/bin/brew shellenv)"

# ============================================
# ALIASES - Editor (VSCodium)
# ============================================
alias code="codium"

# ============================================
# ALIASES - Claude Code
# ============================================
alias claude="claude --dangerously-skip-permissions"
alias c="claude"

# ============================================
# ALIASES - Docker (auto-start Colima)
# ============================================
docker() {
  if ! colima status &>/dev/null; then
    echo "Starting Colima..."
    colima start --cpu 4 --memory 8
  fi
  command docker "$@"
}

alias dc="docker-compose"
alias dps="docker ps"
alias dimg="docker images"

# ============================================
# ALIASES - Git
# ============================================
alias g="git"
alias gst="git status"
alias gd="git diff"
alias gp="git push"
alias gl="git pull"
alias gc="git commit"
alias gcm="git commit -m"
alias gca="git commit --amend"
alias ga="git add"
alias gaa="git add -A"
alias gco="git checkout"
alias gcb="git checkout -b"
alias gb="git branch"
alias glog="git log --oneline -20"
alias gstash="git stash"
alias gpop="git stash pop"

# ============================================
# ALIASES - Navigation
# ============================================
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias l="ls -lah"
alias ll="ls -la"
alias la="ls -A"

# ============================================
# ALIASES - System
# ============================================
alias up="brew upgrade --cask claude-code && brew upgrade && brew cleanup && echo 'All updated!'"
alias sync="cd ~/.dotfiles && git pull && brew bundle && source ~/.zshrc && echo 'Synced!'"
alias reload="source ~/.zshrc"
alias path='echo -e ${PATH//:/\\n}'

# ============================================
# ALIASES - Config Editing
# ============================================
alias zshrc="code ~/.dotfiles/shell/.zshrc"
alias brewfile="code ~/.dotfiles/Brewfile"
alias dotfiles="cd ~/.dotfiles && code ."

# ============================================
# PRIVACY - Disable Telemetry
# ============================================
# Universal
export DO_NOT_TRACK=1

# Homebrew
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_AUTO_UPDATE=1

# JavaScript/Node ecosystem
export NEXT_TELEMETRY_DISABLED=1
export GATSBY_TELEMETRY_DISABLED=1
export ASTRO_TELEMETRY_DISABLED=1
export NUXT_TELEMETRY_DISABLED=1
export VITE_TELEMETRY_DISABLED=1
export TURBO_TELEMETRY_DISABLED=1
export STORYBOOK_DISABLE_TELEMETRY=1
export ANGULAR_CLI_ANALYTICS=false

# Python/Cloud
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export SAM_CLI_TELEMETRY=0
export AZURE_CORE_COLLECT_TELEMETRY=0
export SENTRY_DSN=""

# Misc
export ADBLOCK=1

# ============================================
# HISTORY
# ============================================
export HISTSIZE=50000
export SAVEHIST=50000
export HISTFILE=~/.zsh_history
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY

# ============================================
# EDITOR
# ============================================
export EDITOR="codium --wait"
export VISUAL="codium --wait"

# ============================================
# COMPLETIONS
# ============================================
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# ============================================
# KEY BINDINGS
# ============================================
bindkey -e                           # Emacs key bindings
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# ============================================
# PROMPT (robbyrussell-style)
# ============================================
autoload -Uz vcs_info
precmd() { vcs_info }
setopt prompt_subst
zstyle ':vcs_info:git:*' formats ' %F{blue}git:(%F{red}%b%F{blue})%f'
zstyle ':vcs_info:*' enable git

git_dirty() {
  if [[ -n $(git status --porcelain 2>/dev/null) ]]; then
    echo " %F{yellow}✗%f"
  fi
}

PROMPT='%F{green}→%f %F{cyan}%1~%f${vcs_info_msg_0_}$(git_dirty) '

# ============================================
# FUNCTIONS
# ============================================

# Create directory and cd into it
mkcd() {
  mkdir -p "$1" && cd "$1"
}

# Find process by name
psg() {
  ps aux | grep -v grep | grep -i "$1"
}

# Kill process by name
killp() {
  ps aux | grep -v grep | grep -i "$1" | awk '{print $2}' | xargs kill -9
}
