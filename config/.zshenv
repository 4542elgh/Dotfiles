# Start ZSH in debug mode to test speed
# zmodload zsh/zprof
export env_editor="nvim"
export EDITOR="nvim"

export BAT_CONFIG_PATH="${HOME}/.config/bat/config"
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.local/share"

export ZEROTIER_CENTRAL_TOKEN=$(gpg --decrypt --yes ~/secrets/secrets.txt.asc 2>/dev/null | grep zerotierToken | sed 's/^.* = //')

# Define XDG Config file
# export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc
export XINITRC="$XDG_CONFIG_HOME/X11/.xinitrc"
export PYTHONSTARTUP="$XDG_CONFIG_HOME/python/.pythonstartup"

# Define XDG Data for program specific data files
export NODE_REPL_HISTORY="$XDG_DATA_HOME/node_repl_history"
export GOPATH="$XDG_DATA_HOME/go"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"

KEYTIMEOUT=1

# PG CLI
export PGGSSENCMODE="disable"
export ZSH="$HOME"

# Preserve MANPATH if you already defined it somewhere in your config.
# Otherwise, fall back to `manpath` so we can inherit from `/etc/manpath`.
export MANPATH="${MANPATH-$(manpath)}:$NPM_PACKAGES/share/man"

# PATH variable
NPM_PACKAGES="${HOME}/.npm-packages"
export PATH="$PATH:$NPM_PACKAGES/bin"
export PATH="$PATH:~/.local/share/npm/lib/node_modules/"
export PATH="$HOME/.local/bin:$PATH"
export PATH="/opt/miniconda3/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/flutter/bin:$PATH"
export PATH="$HOME/.gem/ruby/2.7.0/bin:$PATH"
export PATH="/usr/lib/node_modules/npm:$PATH"
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
export PATH="/usr/local/bin:$PATH"

# GPG Agent
export GPG_TTY=$(tty)
export GPGKEY=DA212EEEE9492F1CF7AD6AB976A17195F03AAE73

export NVM_DIR="$XDG_DATA_HOME/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Ignore the following directive when executing `history` command
export HISTORY_IGNORE="(history|clear|exit|ls|cd|pwd|exit|cd ..)"

# ZSH enable history
HISTFILE=$XDG_CONFIG_HOME/zsh/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

export CLICOLOR=1
export CLICOLOR_FORCE=1

export HISTORY_IGNORE="(history|clear|exit|ls|cd|pwd|exit|cd ..)"

ZDOTDIR=$HOME/.config/zsh
