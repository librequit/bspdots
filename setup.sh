#!/bin/env bash
#---------------------------------#
# A r c h  B S P W M  S c r i p t #
#---------------------------------#

#---------------#
red='\033[1;31m'
rset='\033[0m'
grn='\033[1;32m'
ylo='\033[1;33m'
blue='\033[1;34m'
#---------------#

#
# start
#

clear

read -p "
Hello $USER! This script is only for Arch and it 
will install my dotfiles on your system
and will result in losing all your configs. 
Would you like to continue?

(1) yes
(*) no

(?) Select option: " ans_1

if [[ $ans_1 -eq 1 ]]; then
  sleep 3;
  clear
else
  exit
fi

#-------------------------#
# D e p e n d e n c i e s #
#-------------------------#

#
# system update
#

sleep 3;
su -c 'pacman -Syu --noconfirm'
sleep 3; clear

#
# pacman.conf
#

sleep 3;
su -c 'pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com && pacman-key --lsign-key 3056513887B78AEB && pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' && pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst''
su -c 'cp -r ./misc/pacman.conf /etc/pacman.conf'
su -c 'pacman -Syu --noconfirm'
sleep 3; clear

#
# yay
#

if ! command -v yay &> /dev/null; then
    su -c 'pacman -S git --noconfirm --needed'
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    pushd /tmp/yay/
    makepkg -sric --noconfirm --needed PKGBUILD
    popd
    yay --sudo doas --save
else
    echo -e "\n(*) It seems that you already have yay installed, skipping..."
    yay --sudo doas --save
fi

#
# drivers
#

read -p "
Choose the drivers to install:

(1) NVIDIA
(2) AMD
(3) Intel

(?) select option: " driv_1

if [[ $driv_1 == "1" ]]; then
  sleep 3;
  su -c 'pacman -S --noconfirm --needed nvidia-open-dkms nvidia-utils lib32-nvidia-utils \
  nvidia-settings lib32-opencl-nvidia vulkan-icd-loader lib32-vulkan-icd-loader opencl-nvidia'
  clear
fi

if [[ $driv_1 == "2" ]]; then
  sleep 3;
  su -c 'pacman -S --needed --noconfirm lib32-mesa vulkan-radeon \
  lib32-vulkan-radeon vulkan-icd-loader lib32-vulkan-icd-loader'
  clear
fi

if [[ $driv_1 == "3" ]]; then
  sleep 3;
  su -c 'pacman -S --needed --noconfirm lib32-mesa vulkan-intel \
  lib32-vulkan-intel vulkan-icd-loader lib32-vulkan-icd-loader'
  clear
fi

#
# wm, progs
#

clear
echo -e "$red Installing all packages, progs I use... $rset"
sleep 3;
yay -S --needed base-devel xorg xorg-xinit xorg-xprop xorg-xrandr xorg-xrdb \
bspwm sxhkd polybar rofi papirus-icon-theme polkit-gnome feh lxappearance dunst \
kitty lf neovim ueberzugpp picom-git exa yt-dlp pipewire pipewire-jack pipewire-alsa \
pipewire-pulse wireplumber ungoogled-chromium-bin keepassxc mpv nsxiv wget steam lutris \
catppuccin-gtk-theme-mocha vesktop-bin telegram-desktop flameshot pavucontrol ncmpcpp mpd
sleep 3; clear

#--------------------------#
# c o p y  d o t f i l e s #
#--------------------------#

if [ -f ~/.config/polybar ]; then
  echo -e "$ylo Polybar config detected. Deleting it and copying new config... $rset"
  rm -rf ~/.config/polybar && mkdir -p ~/.config/polybar;
  cp ./cfg/polybar/* ~/.config/polybar/;
else
  echo -e "$blue Copying polybar config file... $rset"
  mkdir -p ~/.config/polybar;
  cp ./cfg/polybar/* ~/.config/polybar/;
fi

echo -e "$blue Copying fonts... $rset"
mkdir -p ~/.local/share/fonts
cp -r ./misc/fonts/* ~/.local/share/fonts/
fc-cache -f

mkdir -p ~/.config/

if [ -f ~/.config/picom.conf ]; then
  echo -e "$ylo picom configs detected, deleting it and copying new config... $rset"
  rm -rf ~/.config/picom.conf;
  cp ./cfg/picom.conf ~/.config/picom.conf;
else
  echo -e "$blue Installing picom configs... $rset"
  cp ./cfg/picom.conf ~/.config/picom.conf;
fi

if [ -d ~/.config/kitty ]; then
  echo -e "$ylo kitty configs detected, deleting it and copying new config...$rset"
  rm -rf ~/.config/kitty && mkdir -p ~/.config/kitty
  cp -r ./cfg/kitty/* ~/.config/kitty/;
else
  echo -e "$blue Installing kitty configs... $rset"
  mkdir -p ~/.config/kitty;
  cp -r ./cfg/kitty/* ~/.config/kitty/;
fi

if [ -d ~/walls ]; then
  echo -e "$ylo Adding wallpapers to ~/walls... $rset"
  rm -rf ~/walls && mkdir ~/walls;
  cp -r ./misc/walls/* ~/walls/;
else
  echo -e "$blue Installing wallpapers... $rset"
  mkdir ~/walls;
  cp -r ./misc/walls/* ~/walls/;
fi

if [ -d ~/.config/dunst ]; then
  echo -e "$ylo dunst configs detected, deleting it and copying new config... $rset"
  rm -rf ~/.config/dunst && mkdir -p ~/.config/dunst;
  cp -r ./cfg/dunst/dunstrc ~/.config/dunst/dunstrc;
else
  echo -e "$blue Installing dunst configs... $rset"
  mkdir -p ~/.config/dunst;
  cp -r ./cfg/dunst/dunstrc ~/.config/dunst/dunstrc;
fi

if [ -d ~/.config/sxhkd ]; then
  echo -e "$ylo sxhkd configs detected, deleting it and copying new config... $rset"
  rm -rf ~/.config/sxhkd && mkdir -p ~/.config/sxhkd;
  cp -r ./cfg/sxhkd/sxhkdrc ~/.config/sxhkd/sxhkdrc;
else
  echo -e "$blue Installing sxhkd configs... $rset"
  mkdir -p ~/.config/sxhkd;
  cp -r ./cfg/sxhkd/sxhkdrc ~/.config/sxhkd/sxhkdrc;
fi

if [ -d ~/.config/bspwm ]; then
  echo -e "$ylo bspwm configs detected, deleting it and copying new config... $rset"
  rm -rf ~/.config/bspwm && mkdir -p ~/.config/bspwm;
  cp -r ./cfg/bspwm/* ~/.config/bspwm/;
  chmod +x ~/.config/bspwm/bspwmrc;
  chmod +x ~/.config/bspwm/scripts/monitor.sh;
else
  echo -e "$blue Installing bspwm configs... $rset"
  mkdir -p ~/.config/bspwm 
  cp -r ./cfg/bspwm/* ~/.config/bspwm/;
  chmod +x ~/.config/bspwm/bspwmrc;
  chmod +x ~/.config/bspwm/scripts/monitor.sh;
fi

if [ -d ~/.config/lf ]; then
  echo -e "$ylo lf configs detected, deleting it and copying new config... $rset"
  rm -rf ~/.config/lf && mkdir -p ~/.config/lf;
  cp -r ./cfg/lf/* ~/.config/lf/;
  chmod +x ~/.config/lf/{cleaner,scope};
else
  echo -e "$blue Installing lf configs... $rset"
  mkdir -p ~/.config/lf; 
  cp -r ./cfg/lf/* ~/.config/lf/;
  chmod +x ~/.config/lf/{cleaner,scope};
fi

if [ -d ~/.config/nsxiv ]; then
  echo -e "$ylo nsxiv configs detected, deleting it and copying new config... $rset"
  rm -rf ~/.config/nsxiv && mkdir -p ~/.config/nsxiv;
  cp -r ./cfg/nsxiv/* ~/.config/nsxiv/;
  chmod +x ~/.config/nsxiv/exec/*;
else
  echo -e "$blue Installing nsxiv configs... $rset"
  mkdir -p ~/.config/nsxiv; 
  cp -r ./cfg/nsxiv/* ~/.config/nsxiv/;
  chmod +x ~/.config/nsxiv/exec/*;
fi

if [ -d ~/.config/rofi ]; then
  echo -e "$ylo Rofi configs detected, deleting it and copying new config... $rset"
  rm -rf ~/.config/rofi && mkdir -p ~/.config/rofi;
  cp -r ./cfg/rofi/* ~/.config/rofi/;
else
  echo -e "$blue Installing rofi configs... $rset"
  mkdir -p ~/.config/rofi; 
  cp -r ./cfg/rofi/* ~/.config/rofi/;
fi

if [ -d ~/.config/yt-dlp ]; then
  echo -e "$ylo yt-dlp configs detected, deleting it and copying new config... $rset"
  rm -rf ~/.config/yt-dlp && mkdir -p ~/.config/yt-dlp;
  cp -r ./cfg/yt-dlp/* ~/.config/yt-dlp/;
else
  echo -e "$blue Installing yt-dlp configs... $rset"
  mkdir -p ~/.config/yt-dlp; 
  cp -r ./cfg/yt-dlp/* ~/.config/yt-dlp/;
fi

if [ -d ~/.local/bin ]; then
  echo -e "$ylo Binaries detected, deleting and copying new bins... $rset"
  rm -rf ~/.local/bin && mkdir -p ~/.local/bin;
  cp -r ./bin/* ~/.local/bin/;
  chmod +x ~/.local/bin/*;
else
  echo -e "$blue Installing my binaries... $rset"
  mkdir -p ~/.local/bin; 
  cp -r ./bin/* ~/.local/bin/;
  chmod +x ~/.local/bin/*;
fi

echo -e "$blue Installing NvChad... $rset"
if [ -d ~/.local/nvim ]; then
  echo -e "$ylo Neovim detected, deleting and copying NvChad... $rset"
  rm -rf ~/.config/nvim && mkdir -p ~/.config/nvim;
  cp -r ./cfg/nvim/* ~/.config/nvim/;
else
  echo -e "$blue Installing my NvChad... $rset"
  mkdir -p ~/.config/nvim; 
  cp -r ./cfg/nvim/* ~/.config/nvim/;
fi

echo -e "$grn Last step... $rset"
cp -r ./home/.* ~/
chmod +x ~/.ncmpcpp/ncmpcpp-ueberzug/*

#
# end
#

read -r -p "
Installation complete, thank you for using my dotfiles!

This script was made by LibreQuit.

Would you like to reboot?

(1) yes
(*) no

(?) Select option: " rbt

if [[ $rbt -eq 1 ]]; then
  sleep 3; clear
  su -c 'loginctl reboot'
else
  echo -e "\nSkipping..."
  sleep 3; clear
fi
