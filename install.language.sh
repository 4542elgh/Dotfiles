if ! commandExist nvm
then
	# NVM
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.36.0/install.sh | bash
	nvm install node
	npm install -g yarn
fi

if ! commandExist go
then
	# Golang
	curl -L https://git.io/vQhTU | bash
fi

if ! commandExist rustc
then
	# # Rustup unattended install
	curl https://sh.rustup.rs -sSf | sh -s -- -y

	cargo install lsd
fi

