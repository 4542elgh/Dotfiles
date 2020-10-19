# Start ZSH in debug mode to test speed
# zmodload zsh/zprof

export BAT_CONFIG_PATH="${HOME}/.config/bat/config"

export EDITOR="nvim"
export env_editor="nvim"
export XDG_CONFIG_HOME="${HOME}/.config"

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

bindkey -v

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
# neofetch

# ZSH enable history
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

# load all Antibody plugins
source ~/.zsh_plugins.sh

# Load my alias
source ~/.zsh_alias

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

# Ignore the following directive when executing `history` command
export HISTORY_IGNORE="(history|clear|exit|ls|cd|pwd|exit|cd ..)"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
source ~/.p10k.zsh
