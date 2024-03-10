#!/bin/env bash
# arch linux bspwm setup script

#-----------------
red='\033[1;31m'
rset='\033[0m'
grn='\033[1;32m'
ylo='\033[1;33m'
blue='\033[1;34m'
#-----------------

#
# start
#

clear

read -p "
hello $USER! this script will install my dotfiles on your system 
and may result in losing some existing configs. 
would you like to continue?

(1) yes
(*) no

(?) select option: " ans_1

if [[ $ans_1 == "1" ]]; then
  sleep 3;
  clear
else
  exit
fi

#
# package
#

sleep 3;
su -c 'pacman -Syu --noconfirm'
sleep 3; clear

if ! command -v yay &> /dev/null; then
    su -c 'pacman -S git --noconfirm --needed'
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    pushd /tmp/yay/
    makepkg -sric --noconfirm --needed PKGBUILD
    popd
else
    echo -e "\n(*) it seems that you already have yay installed, skipping..."
fi

clear
echo -e "$red installing all packages i use... $rset"
sleep 3;
yay -S --needed base-devel xorg xorg-xinit xorg-xprop xorg-xrandr \
bspwm sxhkd polybar rofi papirus-icon-theme polkit-gnome feh lxappearance dunst \
kitty lf neovim ueberzugpp picom-ftlabs-git exa yt-dlp \
librewolf-bin keepassxc mpv
sleep 3; clear

# test if command is available, install if not
mkdir -p ~/.local/src

#
# copy dotfiles
#

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

if [ -d ~/wallpapers ]; then
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
else
  echo -e "$blue installing bspwm configs... $rset"
  mkdir -p ~/.config/bspwm 
  cp -r ./cfg/bspwm/* ~/.config/bspwm/;
fi

if [ -d ~/.config/lf ]; then
  echo -e "$ylo lf configs detected, deleting it and copying new config... $rset"
  rm -rf ~/.config/lf && mkdir -p ~/.config/lf;
  cp -r ./cfg/lf/* ~/.config/lf/;
else
  echo -e "$blue installing lf configs... $rset"
  mkdir -p ~/.config/lf; 
  cp -r ./cfg/lf/* ~/.config/lf/;
fi


echo -e "$grn last step... $rset"
cp -r ./home/* ~/

#
# End
#

read -r -p "
installation complete, thank you for using my dotfiles!

this script was made by xrwv.

would you like to reboot?

(1) yes
(*) no

(?) select option: " rbt

if [[ $rbt -eq 1 ]]; then
	sleep 3; clear
	if command -v systemctl >/dev/null; then
		systemctl reboot
	else
		su -c 'loginctl reboot'
	fi
else
	echo -e "\nskipping..."
	sleep 3; clear
fi
