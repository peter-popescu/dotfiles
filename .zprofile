eval "$(/opt/homebrew/bin/brew shellenv)"

export EDITOR="nvim"

[[ -r "$HOME/.cargo/env" ]] && . "$HOME/.cargo/env"
[[ -r "$HOME/google-cloud-sdk/path.zsh.inc" ]] &&
  . "$HOME/google-cloud-sdk/path.zsh.inc"

_java_home="${HOMEBREW_PREFIX:-/opt/homebrew}/opt/openjdk@17/libexec/openjdk.jdk/Contents/Home"
if [[ -d "$_java_home" ]]; then
  export JAVA_HOME="$_java_home"
fi
unset _java_home

[[ -d "$HOME/.local/bin" ]] &&
  export PATH="$HOME/.local/bin:$PATH"
[[ -d "$HOME/.pixi/bin" ]] &&
  export PATH="$HOME/.pixi/bin:$PATH"
[[ -d "$HOME/.local/share/nvim/mason/bin" ]] &&
  export PATH="$HOME/.local/share/nvim/mason/bin:$PATH"
[[ -d "/Applications/Racket/bin" ]] &&
  export PATH="/Applications/Racket/bin:$PATH"
