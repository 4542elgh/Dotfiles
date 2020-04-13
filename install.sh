#/bin/sh

#Mirror list in US
cp mirrorlist /etc/pacman.d/mirrorlist

#Autojump
git clone https://aur.archlinux.org/autojump.git ~/Downloads
cd ~/Downloads/autojump
makepkg -si --noconfirm

# Bat, a better cat
sudo pacman -S bat --noconfirm

# Make CAP_LOCKS key act as ESC and Ctrl
# Dependency lib
git clone https://aur.archlinux.org/interception-tools.git ~/Downloads
cd ~/Downloads/interception-tools
makepkg -sicr

# Mapping CAP_LOCKS to ESC
git clone https://aur.archlinux.org/packages/interception-caps2esc ~/Downloads
cd ~/Downloads/interception-caps2esc
makepkg -sicr

# Add service for caps2esc
sudo mv udevmon /etc/udevmon

# Install key mapper for Control Key
sudo pacman -S xcape --noconfirm

# Add this line to your i3wm config
# exec --no-startup-id xcape -e 'Control_L=Escape'

