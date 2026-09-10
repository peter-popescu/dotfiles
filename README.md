# Dotfiles

Personal macOS dotfiles managed with [yadm](https://yadm.io/).

## Included

- Zsh, Powerlevel10k, tmux, and WezTerm configuration
- Neovim configuration with lazy.nvim
- Aerospace, Git, Karabiner-Elements, LinearMouse, and Sesh configurations
- Scripts in `.local/bin`

## Setup

Install yadm and the tools used by the shell configuration, then clone this repository:

```sh
brew install yadm
yadm clone <repository-url>
```

The shell configuration expects Homebrew-installed versions of Powerlevel10k, fzf, fzf-tab, zsh-vi-mode, zsh-autosuggestions, zsh-syntax-highlighting, eza, fd, and bat. Neovim bootstraps lazy.nvim on first launch. tmux plugins are managed through TPM.

## Managing changes

```sh
yadm status
yadm diff
yadm add <file>
yadm commit -m "Describe the change"
```

Runtime state, caches, credentials, and other machine-specific files are intentionally excluded through `.gitignore`.
