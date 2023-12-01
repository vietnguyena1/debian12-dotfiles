#!/bin/bash

###
sudo apt update
sudo apt upgrade

### git
sudo apt install -y git

### display
sudo apt install -y xorg xorg-dev xbacklight xbindkeys xvkdb xinput 
# screen brightness: xbacklight
# virtual keyboard: xvkdb
# input devices: xinput

### make,etc.
sudo apt install -y build-essential

### microcode 
# AMD
# sudo apt install -y amd64-microcode
# Intel
sudo apt install -y intel-microcode

### network
sudo apt install -y avahi-daemon

### appearance management
sudo apt install -y lxappearance

### Audio
sudo apt install -y pulseaudio 

### system restore
sudo apt install -y timeshift

### power management
sudo apt install -y acpi acpid

### gvfs backends
sudo apt install -y gvfs-backends

### bluetooth
sudo apt install -y bluez blueman

### text editor
sudo apt install -y micro

### create folders
xdg-user-dirs-update

### Ly Console Manager
sudo apt install -y libpam0g-dev libxcb-xkb-dev
cd 
git clone --recurse-submodules https://github.com/fairyglade/ly
cd ly
make
sudo make install installsystemd
cd

# XSessions and dwm.desktop
if [[ ! -d /usr/share/xsessions ]]; then
    sudo mkdir /usr/share/xsessions
fi

cat > ./temp << "EOF"
[Desktop Entry]
Encoding=UTF-8
Name=dwm
Comment=Dynamic window manager
Exec=dwm
Icon=dwm
Type=XSession
EOF
sudo cp ./temp /usr/share/xsessions/dwm.desktop;rm ./temp


### suckless
# Creating directories
mkdir ~/.config/suckless

sudo apt install -y libx11-dev

# Move install directory, make, and install
cd ~/.config/suckless
tools=( "dwm" "dmenu" "st" "slstatus" "slock" "tabbed" )
for tool in ${tools[@]}
do 
	git clone git://git.suckless.org/$tool
	cd ~/.config/suckless/$tool;make;sudo make clean install;cd ..
done



### enable services
sudo systemctl enable avahi-daemon
sudo systemctl enable acpid
sudo systemctl enable bluetooth
sudo systemctl enable ly.service

### utilities
source ./script/utilities.sh

### reboot
sudo apt autoremove
sudo reboot
