#!/bin/env bash
#---------------------------------#
# a r c h  b s p w m  s c r i p t #
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
hello $USER! this script is only for arch and it 
will install my dotfiles on your system 
and may result in losing all your configs. 
would you like to continue?

(1) yes
(*) no

(?) select option: " ans_1

if [[ $ans_1 -eq 1 ]]; then
  sleep 3;
  clear
else
  exit
fi

#-------------------------#
# d e p e n d e n c i e s #
#-------------------------#

#
# system update
#

sleep 3;
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
else
    echo -e "\n(*) it seems that you already have yay installed, skipping..."
fi

#
# drivers
#

read -p "
choose the drivers to install:

(1) nvidia
(2) amd
(3) intel

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
  su -c 'pacman -S --needed --noconfirm lib32-mesa vulkan-intel lib32-vulkan-intel \
  vulkan-icd-loader lib32-vulkan-icd-loader'
  clear
fi

#
# wm, progs
#

clear
echo -e "$red installing all packages i use... $rset"
sleep 3;
yay -S --needed base-devel xorg xorg-xinit xorg-xprop xorg-xrandr xorg-xrdb \
bspwm sxhkd polybar rofi papirus-icon-theme polkit-gnome feh lxappearance dunst \
kitty lf neovim ueberzugpp picom-git exa yt-dlp pipewire pipewire-jack pipewire-alsa \
pipewire-pulse wireplumber librewolf-bin keepassxc mpv nsxiv wget steam lutris catppuccin-gtk-theme-mocha
sleep 3; clear

#--------------------------#
# c o p y  d o t f i l e s #
#--------------------------#

if [ -f ~/.config/polybar ]; then
  echo -e "$ylo polybar cfg detected. deleting it and copying new config... $rset"
  rm -rf ~/.config/polybar && mkdir -p ~/.config/polybar;
  cp ./cfg/polybar/* ~/.config/polybar/;
else
  echo -e "$blue copying polybar config file... $rset"
  mkdir -p ~/.config/polybar;
  cp ./cfg/polybar/* ~/.config/polybar/;
fi

echo -e "$blue copying fonts... $rset"
mkdir -p ~/.local/share/fonts
cp -r ./misc/fonts/* ~/.local/share/fonts/
fc-cache -f

mkdir -p ~/.config/

if [ -f ~/.config/picom.conf ]; then
  echo -e "$ylo picom configs detected, deleting it and copying new config... $rset"
  rm -rf ~/.config/picom.conf;
  cp ./cfg/picom.conf ~/.config/picom.conf;
else
  echo -e "$blue installing picom configs... $rset"
  cp ./cfg/picom.conf ~/.config/picom.conf;
fi

if [ -d ~/.config/kitty ]; then
  echo -e "$ylo kitty configs detected, deleting it and copying new config...$rset"
  rm -rf ~/.config/kitty && mkdir -p ~/.config/kitty
  cp -r ./cfg/kitty/* ~/.config/kitty/*;
else
  echo -e "$blue installing kitty configs... $rset"
  mkdir -p ~/.config/kitty;
  cp -r ./cfg/kitty/* ~/.config/kitty/;
fi

if [ -d ~/walls ]; then
  echo -e "$ylo adding wallpapers to ~/walls... $rset"
  rm -rf ~/walls && mkdir ~/walls;
  cp -r./misc/walls/* ~/walls/;
else
  echo -e "$blue installing wallpapers... $rset"
  mkdir ~/walls;
  cp -r ./misc/walls/* ~/walls/;
fi

if [ -d ~/.config/dunst ]; then
  echo -e "$ylo dunst configs detected, deleting it and copying new config... $rset"
  rm -rf ~/.config/dunst && mkdir -p ~/.config/dunst;
  cp -r ./cfg/dunst/dunstrc ~/.config/dunst/dunstrc;
else
  echo -e "$blue installing dunst configs... $rset"
  mkdir -p ~/.config/dunst;
  cp -r ./cfg/dunst/dunstrc ~/.config/dunst/dunstrc;
fi

if [ -d ~/.config/bspwm ]; then
  echo -e "$ylo bspwm configs detected, deleting it and copying new config... $rset"
  rm -rf ~/.config/bspwm && mkdir -p ~/.config/bspwm;
  cp -r ./cfg/bspwm/* ~/.config/bspwm/;
  chmod +x ~/.config/bspwm/bspwmrc;
else
  echo -e "$blue installing bspwm configs... $rset"
  mkdir -p ~/.config/bspwm 
  cp -r ./cfg/bspwm/* ~/.config/bspwm/;
  chmod +x ~/.config/bspwm/bspwmrc;
fi

if [ -d ~/.config/lf ]; then
  echo -e "$ylo lf configs detected, deleting it and copying new config... $rset"
  rm -rf ~/.config/lf && mkdir -p ~/.config/lf;
  cp -r ./cfg/lf/* ~/.config/lf/;
  chmod +x ~/.config/{cleaner,scope};
else
  echo -e "$blue installing lf configs... $rset"
  mkdir -p ~/.config/lf; 
  cp -r ./cfg/lf/* ~/.config/lf/;
  chmod +x ~/.config/{cleaner,scope};
fi

if [ -d ~/.config/nsxiv ]; then
  echo -e "$ylo nsxiv configs detected, deleting it and copying new config... $rset"
  rm -rf ~/.config/nsviv && mkdir -p ~/.config/nsxiv;
  cp -r ./cfg/nsxiv/* ~/.config/nsxiv/;
else
  echo -e "$blue installing nsxiv configs... $rset"
  mkdir -p ~/.config/nsxiv; 
  cp -r ./cfg/nsxiv/* ~/.config/nsxiv/;
fi

if [ -d ~/.config/rofi ]; then
  echo -e "$ylo rofi configs detected, deleting it and copying new config... $rset"
  rm -rf ~/.config/rofi && mkdir -p ~/.config/rofi;
  cp -r ./cfg/rofi/* ~/.config/rofi/;
else
  echo -e "$blue installing rofi configs... $rset"
  mkdir -p ~/.config/rofi; 
  cp -r ./cfg/rofi/* ~/.config/rofi/;
fi

if [ -d ~/.config/yt-dlp ]; then
  echo -e "$ylo yt-dlp configs detected, deleting it and copying new config... $rset"
  rm -rf ~/.config/yt-dlp && mkdir -p ~/.config/yt-dlp;
  cp -r ./cfg/yt-dlp/* ~/.config/yt-dlp/;
else
  echo -e "$blue installing yt-dlp configs... $rset"
  mkdir -p ~/.config/yt-dlp; 
  cp -r ./cfg/yt-dlp/* ~/.config/yt-dlp/;
fi

if [ -d ~/.local/bin ]; then
  echo -e "$ylo bins detected, deleting and copying new bins... $rset"
  rm -rf ~/.local/bin && mkdir -p ~/.local/bin;
  cp -r ./bin/* ~/.local/bin/;
  chmod +x ~/.local/bin/*;
else
  echo -e "$blue installing my bins... $rset"
  mkdir -p ~/.local/bin; 
  cp -r ./bin/* ~/.local/bin/;
  chmod +x ~/.local/bin/*;
fi

echo -e "$blue installing astronvim... $rset"
git clone --depth 1 https://github.com/AstroNvim/AstroNvim ~/.config/nvim

echo -e "$grn last step... $rset"
cp -r ./home/* ~/

#
# end
#

read -r -p "
installation complete, thank you for using my dotfiles!

this script was made by xrwv (xeerowave).

would you like to reboot?

(1) yes
(*) no

(?) select option: " rbt

if [[ $rbt -eq 1 ]]; then
  sleep 3; clear
  systemctl reboot
else
  echo -e "\nskipping..."
  sleep 3; clear
fi
