# Start ZSH in debug mode to test speed
# zmodload zsh/zprof

# Preserve MANPATH if you already defined it somewhere in your config.
# Otherwise, fall back to `manpath` so we can inherit from `/etc/manpath`.
export MANPATH="${MANPATH-$(manpath)}:$NPM_PACKAGES/share/man"

bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
bindkey '^R' history-incremental-search-backward

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

setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.

# StartX for X.org xinit
# if systemctl -q is-active graphical.target && [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
#   exec startx "$XDG_CONFIG_HOME/X11/.xinitrc"
# fi 

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
source $XDG_CONFIG_HOME/p10k/.p10k.zsh

vterm_printf(){
    if [ -n "$TMUX" ] && ([ "${TERM%%-*}" = "tmux" ] || [ "${TERM%%-*}" = "screen" ] ); then
        # Tell tmux to pass the escape sequences through
        printf "\ePtmux;\e\e]%s\007\e\\" "$1"
    elif [ "${TERM%%-*}" = "screen" ]; then
        # GNU screen (screen, screen-256color, screen-256color-bce)
        printf "\eP\e]%s\007\e\\" "$1"
    else
        printf "\e]%s\e\\" "$1"
    fi
}

macchina
