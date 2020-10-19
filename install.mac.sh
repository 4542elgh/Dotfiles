#! /bin/bash

# Check if command exist
commandExist () {
	if ! command -v $1 &> /dev/null
	then
		return 1
	else
		return 0
	fi
}

if ! commandExist brew antibody
then
	# Homebrew
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

	brew install zsh stow neovim
	brew cask install discord bitwarden microsoft-edge alfred itsycal copyclip docker dozer karabiner-elements kitematic mos obs scroll-reverser sensiblesidebuttons teamviewer vlc
fi

# Safari open AppStore
open -a Safari https://apps.apple.com/us/app/magnet/id441258766?mt=12
open -a Safari https://apps.apple.com/us/app/xcode/id497799835?mt=12

# Change shell to zsh
chsh -s /bin/zsh

# Dotfiles
git clone https://github.com/4542elgh/Dotfiles.git ~/

if ! [[ -f "~/.ssh/id_rsa.pub" ]]
then 
	# SSH keygen
	ssh-keygen -b 2048 -t rsa -f ~/.ssh/ -q -N ""
fi

if ! [[ -f "~/.local/share/nvm/site/autoload/plug.vim" ]]
then
	# Vim Plug
	sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
fi

cd ~/Dotfiles

if ! [[ -f "~/.zshrc" ]]
then 
	stow config
	stow p10k
fi

if ! [[ -f "~/.zsh_plugins.sh" ]]
then
	# Antibody static plugins
	antibody bundle < ~/.zsh_plugins.txt > ~/.zsh_plugins.sh
fi
