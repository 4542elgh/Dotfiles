# Start ZSH in debug mode to test speed
# zmodload zsh/zprof

# PG CLI
export PGGSSENCMODE="disable"

# This is for global node package
export ZSH="$HOME"
export NPM_PACKAGES="/Users/$USER/.npm-packages"
export NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"
export PATH="$NPM_PACKAGES/bin:$PATH"
export PATH="/opt/miniconda3/bin:$PATH"

# Speed up zsh compinit by only checking cache once a day
autoload -Uz compinit 
if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
	compinit;
else
	compinit -C;
fi;
# zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# ZSH enable history
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

# load all Antibody plugins
source ~/.zsh_plugins.sh

# Load my alias
source ~/.zsh_alias

# This is to switch environmental variables if there is a .env file
source ~/.autoenv/activate.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# This is for coloring ls in FreeBSD distro
unset LSCOLORS

# This is for coloring ls in GNU distro
export CLICOLOR=1
export CLICOLOR_FORCE=1

# Some environmental variables
export do_ip="159.65.66.29"

# Ignore the following directive when executing `history` command
export HISTIGNORE="pwd:ls:cd:history:clear:exit"
