#!/bin/sh

xrdb merge $HOME/.Xresources
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
xsetroot -cursor_name left_ptr &

sxhkd &
exec bspwm
