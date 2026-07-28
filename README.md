# Dotfiles

Personal macOS dotfiles managed with [yadm](https://yadm.io/).

## Included

- Zsh, Powerlevel10k, tmux, and WezTerm configuration
- Neovim configuration with lazy.nvim
- Aerospace, btop, Git, Karabiner-Elements, LinearMouse, Neofetch, and Wireshark configuration
- Small utility scripts in `.local/bin`

## Setup

Install yadm and the tools used by the shell configuration, then clone this repository:

```sh
brew install yadm
yadm clone <repository-url>
```

The shell configuration expects Homebrew-installed versions of Powerlevel10k, fzf, fzf-tab, zsh-vi-mode, zsh-autosuggestions, zsh-syntax-highlighting, eza, fd, and bat. Neovim bootstraps lazy.nvim on first launch. tmux plugins are managed through TPM.

After cloning, review the machine-specific paths in `.zshrc`, especially `JAVA_HOME` and the Racket path, before opening a new shell.

## Managing changes

```sh
yadm status
yadm diff
yadm add <file>
yadm commit -m "Describe the change"
```

Runtime state, caches, credentials, and other machine-specific files are intentionally excluded through `.gitignore`.

The Neovim configuration retains an unused VS Code Neovim setup under `nvim/lua/vscode_core` and `nvim/lua/vscode_plugins` for reference.
