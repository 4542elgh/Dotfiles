#/bin/sh

#Mirror list in US
cp mirrorlist /etc/pacman.d/mirrorlist

#Autojump
git clone https://aur.archlinux.org/autojump.git ~/Downloads
cd ~/Downloads
makepkg -si --noconfirm

# Bat, a better cat
sudo pacman -S bat --noconfirm
