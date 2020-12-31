# Start ZSH in debug mode to test speed
# zmodload zsh/zprof
export env_editor="nvim"
export EDITOR="nvim"

export BAT_CONFIG_PATH="${HOME}/.config/bat/config"
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.local/share"

# Define XDG Config file
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc
export XINITRC="$XDG_CONFIG_HOME"/X11/.xinitrc
export PYTHONSTARTUP=$XDG_CONFIG_HOME/python/.pythonstartup

# Define XDG Data for program specific data files
export NVM_DIR="$XDG_DATA_HOME"/nvm
export NODE_REPL_HISTORY="$XDG_DATA_HOME"/node_repl_history
export GOPATH="$XDG_DATA_HOME"/go
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup

KEYTIMEOUT=1

# PG CLI
export PGGSSENCMODE="disable"
export ZSH="$HOME"

# This is for global node package
NPM_PACKAGES="${HOME}/.npm-packages"
export PATH="$PATH:$NPM_PACKAGES/bin"

# Preserve MANPATH if you already defined it somewhere in your config.
# Otherwise, fall back to `manpath` so we can inherit from `/etc/manpath`.
export MANPATH="${MANPATH-$(manpath)}:$NPM_PACKAGES/share/man"

# PATH variable
export PATH="$HOME/.local/bin:$PATH"
export PATH="/opt/miniconda3/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/.gem/ruby/2.7.0/bin:$PATH"
export PATH="/usr/lib/node_modules/npm:$PATH"

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line

# Speed up zsh compinit by only checking cache once a day
autoload -Uz compinit 
if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
	compinit;
else
	compinit -C;
fi;
# zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# Tab complete directory case insensitive
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# Change directory without cd
setopt autocd 

# Dont record duplicate
setopt histignorealldups

# Got that sweet Arch logo and system info showing on new instance
neofetch

# ZSH enable history
HISTFILE=$XDG_CONFIG_HOME/zsh/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

# load all Antibody plugins
source $XDG_CONFIG_HOME/zsh/.zsh_plugins.sh

# Load my alias
source $XDG_CONFIG_HOME/zsh/.zsh_alias

# export $FZF_DEFAULT_COMMAND="find ."
# export $FZF_DEFAULT_OPTS="--ansi --preview-window 'right:60%' --preview 'bat --color=always --style=header,grid --line-range :300 {}'"

# This is to switch environmental variables if there is a .env file
# source ~/.autoenv/activate.sh

# This is for coloring ls in FreeBSD distro
unset LSCOLORS

# This is for coloring ls in GNU distro
export CLICOLOR=1
export CLICOLOR_FORCE=1

setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.

# StartX for X.org xinit
if systemctl -q is-active graphical.target && [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  exec startx "$XDG_CONFIG_HOME/X11/.xinitrc"
fi 

# Ignore the following directive when executing `history` command
export HISTORY_IGNORE="(history|clear|exit|ls|cd|pwd|exit|cd ..)"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
source $XDG_CONFIG_HOME/p10k/.p10k.zsh
