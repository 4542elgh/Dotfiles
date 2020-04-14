# Dotfiles for Linux and MacOSX
This repo contain config files which can be syslinked to home directory using GNU Stow

This README.md contain all the setup instructions so I dont have to Google every single software

# SUDO
Arch does not come with sudo, just like Debian. So... Lets install it.
```bash
sudo pacman -Syyu sudo
```
Wait... How can you sudo if you dont have sudo installed???🤔
Use su, which should be the default user.
You will need to uncomment 1 line and add a new line in `visudo` config file
```bash
root ALL=(ALL) ALL # Uncomment this line
your_username ALL=(ALL) ALL # Add this new line and change your_username
```
If you are a normal user, try set the env var on the fly by using this
```bash
sudo EDITOR=vim visudo
```

# i3-gaps
i3 will make full use of your screen real estates. It is as simple as that.
Add some config and you will never leave i3 even though it is not the conventional floating window manager.
I use gaps so it has a bit more asthetic feel 
Enough said here's the install
```bash
sudo pacman -Syyu i3-gaps
```

# [Terminator](https://gnometerminator.blogspot.com/p/introduction.html)
I use Terminator as my terminal emulator. I give up on configuring uRXVT, because its hard if not possible, to configure Powerlevel10k on it. Terminator Powerlevel10K out of the box, and my config file is 3 lines. 

https://gnometerminator.blogspot.com/p/introduction.html
```bash
sudo pacman -Syyu terminator
```

# Compton/Picom
Transparency is purely for asthetic, but it makes your Windows Manager so much more appealing! I only made my terminal have transparency, but feel free to make it however you like.
```bash
sudo pacman -S picom
```
Grab my picom config folder and stow it into your home directory. Be sure to change Terminator to your terminal application name
```bash
stow picom
```
Put this line in your i3 config
```bash
exec --no-startup-id picom -b
```

# Stow
It is much easier to manage your dotfiles with Stow. Stow contain all your config folder in one directory and with a simple `stow zsh` given that zsh is a folder, stow will system link that folder's content into your home directory. 
```bash
sudo pacman -Syyu stow
```

# ZSH
I am sure you heard all the good things about ZSH.
ZSH folder have some sane config I use everyday
```bash
sudo pacman -Syyu zsh
```
Set current user to use zsh shell
```bash
chsh -s /bin/zsh ${USER}
```
Use stow to syslink entire zsh folder to your home dir, or create your own .zshrc config
```bash
stow zsh
```

# Clipster & Rofi & Rofi-Clips
I was initially searching for a clipboard manager, and I came across clipster, and it is recommended to use with Rofi-Clips add-on for better experience. Then I realize Rofi framework itself is more intuitive to use than dmenu (i3wm default menu selection)
```bash
sudo pacman -Syyu rofi
yay clipster
```
You will need to start clipster daemon, for now you can use the `-d` flag.
For it to auto start on reboot, it is recommended to put clipster daemon in your wm startup config file or in systemd service.
In my i3 config file, I have `exec --no-startup-id clipster -d --config="PATH_TO_YOUR_CONFIG_FILE"` at the bottom
For debugging purpose, manually starting clipster with
```bash
clipster -d
```
Note I did not install roficlip from AUR, because I made a small tweak for roficlip to display both PRIMARY (Mouse selection) and CLIPBOARD (Ctrl+C selection)
You will need to grab the file from github and put it inside /bin folder
Make sure you have the following dependencies
*wget
*gawk
*fzf
*clipster (You should already installed and enabled the service at this point)
```bash
wget https://github.com/4542elgh/roficlip/blob/master/roficlip # Download file from github
chmod +x roficlip # Set execute permission
sudo mv roficlip /bin # This step can be avoid if you set PATH to contain the folder containing roficlip
```
Rofi out of the box act as a search engine for applications (again, its a replacement for dmenu)
Roficlip which I alias to clip, will take all copied items and store in a plain text file. (See Github for it's location)
Press Ctrl+J/K to move up and down, ENTER to copy the highlighted item into PRIMARY & CLIPBOARD selection.

# Image Capture
On the topic of clipboard, capturing monitor image to clipboard or save as file is really useful.
No additional software needed, ImageMagick will take screen capture and save to your home directory. 
To capture image into clipboard, there is xclip to do it.
Those 2 functionalities are mapped to i3 keybinding.
Copy to clipboard
$Mod + A
```bash
bindsym $mod+a --release exec import png:- | xclip -selection clipboard -t image/png
```
Save Image to Directory
$Mod + Shift + A
```bash
bindsym $mod+shift+a --release exec cd $HOME/Pictures && import $(date +'%m%d%Y%H%M%S').png
```
Change the cd to the path where you want to save your screenshot capture.

# [yay](https://github.com/Jguer/yay)
But seriously, yay is what I use to manage AUR (Arch User Repository)<br/>
If you want to compile your own PKGBUILD
You can Google the AUR of your package
Git clone the repo into a directory, then do makepkg -sicr in that folder.
Note that without yay, you lose the ability to auto update AUR packages to latest release
**MAKE SURE TO RTFM BEFORE UPDATING ALL YOUR SYSTEM SOFTWARE, KERNEL, ETC.**

```bash
git clone https://aur.archlinux.org/yay.git ~/Downloads
cd ~/Downloads/yay
makepkg -sicr
```

# bumblebee-status
Trust me, I have tried SO hard to get powerline running on my bar. Bumblebee is the one work out of the box, and easily configurable (Python)
```bash
yay bumblebee-status
```
I used the `iceberg-rainbow` theme, while remove the gray background color b/c its hard to see.
Bumblebee status is defined in i3 config file under `bar` attribute.

# Fonts
I personally use 4 fonts
`DejaVu [Nerdfont](https://www.nerdfonts.com)` for all the glyph goodies, 
```bash
yay nerd-fonts-dejavu-complete
```
`tff-joypixels` for emojis
```bash
yay ttf-joypixels
```
Chinese support: `dobe-source-han-sans-cn-fonts` and `dobe-source-han-sans-tw-fonts`
CN is for Simplified Chinese, and TW is for Traditional Chinese
```bash
sudo pacman -Syyu adobe-source-han-sans-cn-fonts adobe-source-han-sans-tw-fonts
```

# Neofetch
Get that wholesome Arch Logo and Sys Info in your terminal. Dont know what am talking about? Take a look at [/r/UnixPorn](https://www.reddit.com/r/unixporn/)

# Nvim
Everyone will have their own sets of .vimrc/.init.vim, I do have a list of plugins that I think is convenient to have. Maybe you will find something you need but didnt know exist. 🤔 
```bash
sudo pacman -Syyu nvim
```
I use vim-plug, install that would be really helpful
```bash
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

# Input Methods
If you are using Chinese input method, then `fcitx` framework will be a good option
Additionally, you will need to install **one** of the chinese input methods, the one I use is **fcitx-sunpinyin**
You can find a full list of input methods from the [Official Arch Wiki](https://wiki.archlinux.org/index.php/fcitx)
```bash
sudo pacman -Syyu fcitx fcitx-sunpinyin
```
You can switch to fcitx by pressing `Ctrl-[Space]`

# Bluetooth
## Dependencies
Bluez - Provide Bluetooth protocol interface
Bluez-utils - Provide bluetoothctl for CLI interface
pulseaudio-alsa - ALSA is a frontend interface for pulseaudio server
pulseaudio-bluetooth - Interact with bluetooth device
```bash
sudo pacman -Syyu bluez bluez-utils pulseaudio-alsa pulseaudio-bluetooth
```
Enable bluetooth service
```bash
sudo systemctl enable bluetooth # Start this service on boot
sudo systemctl start bluetooth # Start service manually now
```

## Pairing
Enter bluetooth CLI
```bash
bluetoothctl
```
Power on the module and agent, then start scanning
```bash
[bluetooth]# power on
[bluetooth]# agent on
[bluetooth]# default-agent
[bluetooth]# scan on
```
Turn on your bluetooth device and put it in pairing mode
You should see a [NEW] device with its mac address
Eg:
```bash
[NEW] Device 00:1D:43:6D:03:26 Lasmex LBT10
```
Now it is as simple as pair, connect, and trust, then we can close the CTL
```bash
[bluetooth]# pair 00:1D:43:6D:03:26
[bluetooth]# connect 00:1D:43:6D:03:26
[bluetooth]# trust 00:1D:43:6D:03:26 # (Optional) If you want to automatically connect to this device in the future
[bluetooth]# scan off # Stop the scan
[bluetooth]# exit
```

## Auto connect
**If you have not trusted your bluetooth device, you need to do it right now (see Pairing step)**

For Pulse Audio to redirect audio output to bluetooth device
Add the following to /etc/pulse/default.pa
```bash
# automatically switch to newly-connected devices
load-module module-switch-on-connect
```
Enable bluetooth auto power on by appending the following line in `/etc/bluetooth/main.conf`
```bash
[Policy]
AutoEnable=true
```
Enjoy! 🤣

# mps-Youtube
I ususally code with some music on. So here it is, a CLI util just for listening to Youtube music.
You do need to have python3 installed.
```bash
pip3 install --user mpsyt
```
You will also need to obtain your own Google Youtube API Key. (Do a Google Search for that)
Then set your new API key after you launch mpsyt
```bash
set api_key <YOUR_API_KEY>
```
MPlayer is the music player MPS-Youtube uses, be sure to install that
```bash
sudo pacman -Syyu mplayer
```
Set your new music player
```bash
set player mplayer
```

# File search
There are times I want to do a quick lookup of a file. Either by filename or file content
I use fzf, mlocate (lookup thr filename), and ag (lookup thr file content)
FZF is async, fuzzy, interactive search engine that also provide file preview.
```bash
sudo pacman -Syyu fzf
```
mlocate is just searching through a predetermine db tree and return you the result.
```bash
sudo pacman -Syyu mlocate
```
mlocate require you to populate the database before doing any searches. It is also recommended to repopulate your database once a while to have most up to date tree.
```bash
sudo updatedb # This will update the database search tree
```
ag - The silver searcher - is a super fast content searcher 
```bash
sudo pacman -Syyu ag
```

# Programming Languages
# NPM

## Global NPM without Sudo
Global NPM packages should not use sudo command. (Use NPM in user's own home directory)

Make npm-package directory to store global modules
```bash
mkdir "${HOME}/.npm-packages"
```
Configure npm to use the above path for global package
```bash
npm config set prefix "${HOME}/.npm-packages"
```
Put the following command in your `.bashrc/.zshrc`
```bash
# Define a variable for Global NPM Package
NPM_PACKAGES="${HOME}/.npm-packages"

# Append to the current PATH variable
export PATH="$PATH:$NPM_PACKAGES/bin"

# Preserve MANPATH if you already defined it somewhere in your config.
# Otherwise, fall back to `manpath` so we can inherit from `/etc/manpath`.
export MANPATH="${MANPATH-$(manpath)}:$NPM_PACKAGES/share/man"
```

# Make CAPS_LOCK Great Again!
I use karabinar for MacOSX to map Caps_Lock to both Ctrl[Hold] and Esc[Press]. After some investigation, I think this is what I am happy with.
You will need `xcape` and `caps2esc`
```bash
sudo pacman -Syyu xcape
yay interception-tools caps2esc
```
Make a file named `udevmon.yaml` in /etc folder
```yaml
- JOB: "intercept -g $DEVNODE | caps2esc | uinput -d $DEVNODE"
  DEVICE:
    EVENTS:
      EV_KEY: [KEY_CAPSLOCK, KEY_ESC]
```
Start the service with
```bash
sudo systemctl enable udevmon
sudo systemctl start udevmon
```
At this point you should have ESC mapped to Caps_Lock.
Now put the following line in your i3 config to set xcape on boot
```bash
xcape -e 'Control_L=Escape'
With those tweaks, you should have Esc for Press, and Ctrl for Hold
```
