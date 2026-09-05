if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

[[ -r "$HOME/.cargo/env" ]] && . "$HOME/.cargo/env"

BREW_PREFIX="${HOMEBREW_PREFIX:-/opt/homebrew}"

if [[ -x "$BREW_PREFIX/bin/brew" ]]; then
  _java_prefix="$("$BREW_PREFIX/bin/brew" --prefix openjdk@17 2>/dev/null)"
  if [[ -d "$_java_prefix/libexec/openjdk.jdk/Contents/Home" ]]; then
    export JAVA_HOME="$_java_prefix/libexec/openjdk.jdk/Contents/Home"
  fi
  unset _java_prefix
fi

[[ -d "$HOME/.local/share/nvim/mason/bin" ]] && \
  export PATH="$HOME/.local/share/nvim/mason/bin:$PATH"
[[ -d "/Applications/Racket/bin" ]] && \
  export PATH="/Applications/Racket/bin:$PATH"

[[ -r "$HOME/google-cloud-sdk/path.zsh.inc" ]] && \
  . "$HOME/google-cloud-sdk/path.zsh.inc"
