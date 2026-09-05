# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

BREW_PREFIX="${HOMEBREW_PREFIX:-/opt/homebrew}"
if [[ -r "$BREW_PREFIX/share/powerlevel10k/powerlevel10k.zsh-theme" ]]; then
  source "$BREW_PREFIX/share/powerlevel10k/powerlevel10k.zsh-theme"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# history setup
HISTFILE=$HOME/.zhistory
SAVEHIST=10000
HISTSIZE=10000
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify
setopt extended_history

# completions
typeset -U fpath # make array unique
fpath=(
  ~/.zsh/completions/
  $BREW_PREFIX/share/zsh-completions
  $BREW_PREFIX/share/zsh/site-functions
  $fpath
)

zmodload zsh/complist
autoload -Uz compinit
ZSH_COMPDUMP="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/compdump"
[[ -d "${ZSH_COMPDUMP:h}" ]] || mkdir -p "${ZSH_COMPDUMP:h}"
compinit -u -d "$ZSH_COMPDUMP"

# Google Cloud SDK completion
if [[ -r "$HOME/google-cloud-sdk/completion.zsh.inc" ]]; then
  . "$HOME/google-cloud-sdk/completion.zsh.inc"
fi

# plugins
# zsh-vi-mode config
function zvm_config() {
  ZVM_VI_SURROUND_BINDKEY="s-prefix"
  ZVM_SYSTEM_CLIPBOARD_ENABLED=true
}

if [[ -r "$BREW_PREFIX/share/fzf-tab/fzf-tab.zsh" ]]; then
  source "$BREW_PREFIX/share/fzf-tab/fzf-tab.zsh" # has to go first
fi
if [[ -r "$BREW_PREFIX/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh" ]]; then
  source "$BREW_PREFIX/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh"
fi

(( $+functions[enable-fzf-tab] )) && enable-fzf-tab

# completion config
# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
zstyle ':completion:*' menu no
# case-insensitive matching
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
# preview directory's content with eza when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
# To make fzf-tab follow FZF_DEFAULT_OPTS (so keep them simple below)
zstyle ':fzf-tab:*' use-fzf-default-opts yes
# custom fzf flags
zstyle ':fzf-tab:*' fzf-flags --ansi --bind=tab:accept
# switch group using `<` and `>`
zstyle ':fzf-tab:*' switch-group '<' '>'

if [[ -r "$BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]]; then
  source "$BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi
if [[ -r "$BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
  source "$BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

# aliases
alias reload-zsh="source ~/.zshrc"
alias edit-zsh="nvim ~/.zshrc"
alias edit-wezterm="nvim ~/.wezterm.lua"
alias edit-nvim="nvim ~/.config/nvim"
alias edit-tmux="nvim ~/.tmux.conf"

alias excl-pixi="~/.local/bin/exclude-pixi.sh"
alias pa='eval "$(pixi shell-hook)"'

alias moshcs="mosh --experimental-remote-ip=remote username@ssh.cs.brown.edu"

alias path='echo $PATH | tr ":" "\n"'

alias vim=nvim

alias 'gc'='git clone "$(pbpaste)"'

function nvim() {
  if [[ -f "pixi.toml" ]]; then
    # Run in a subshell `(...)` so the environment variables
    # disappear the moment you close Neovim.
    (eval "$(pixi shell-hook)" && command nvim "$@")
  else
    # Just run normally
    command nvim "$@"
  fi
}

function mkcd() { mkdir -p "$1" && cd "$1" }

function extract() {
  if [ -f "$1" ]; then
    case "$1" in
      *.tar.bz2) tar xjf "$1" ;;
      *.tar.gz)  tar xzf "$1" ;;
      *.bz2)     bunzip2 "$1" ;;
      *.rar)     unrar x "$1" ;;
      *.gz)      gunzip "$1" ;;
      *.tar)     tar xf "$1" ;;
      *.tbz2)    tar xjf "$1" ;;
      *.tgz)     tar xzf "$1" ;;
      *.zip)     unzip "$1" ;;
      *.Z)       uncompress "$1" ;;
      *.7z)      7z x "$1" ;;
      *)         echo "'$1' cannot be extracted" ;;
    esac
  fi
}

ggl () {
  f='%C(yellow)%h\t[%ad]%C(reset) -%C(yellow)%d%C(reset) %s %C(green)(%cr) %C(blue)%an%C(reset)'
  size='20'
  if [[ "${1}" =~ ^[0-9]+$ ]]
  then
    size="${1}"
  fi
  git log --color=always --graph --pretty=format:"$f" --abbrev-commit --date=short |
    head -n ${size} |
    nl -w 2
}

# ---- FZF -----

# Set up fzf key bindings and fuzzy completion
if (( $+commands[fzf] )); then
  eval "$(fzf --zsh)"
fi

# Set up fzf theme (Dracula)
export FZF_DEFAULT_OPTS='--color=fg:#f8f8f2,bg:#282a36,hl:#bd93f9 --color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9 --color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6 --color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4'

# -- Use fd instead of fzf --
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

# NOTE: couldn't get the bindings to work
# source ~/.fzf-git.sh/fzf-git.sh

show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo \${}'"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
  esac
}

if (( $+functions[fzf-cd-widget] )); then
  bindkey -r '^[c'
  bindkey '^O' fzf-cd-widget
fi

# ----- Bat (better cat) -----

export BAT_THEME="Dracula"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# ---- Eza (better ls) -----

EZA="eza --color=always --icons=always --long --git --hyperlink --no-user"
alias ls="$EZA"
alias la="$EZA -a"

# ----- Zoxide (better cd) -----

if (( $+commands[zoxide] )); then
  eval "$(zoxide init --cmd cd zsh)"
fi

# Vite+ bin (https://viteplus.dev)
. "$HOME/.vite-plus/env"
