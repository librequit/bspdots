#!/bin/sh

#xrandr --output "HDMI-0" --mode 1920x1080 --rate 75.00 --primary
#xrandr --output "DP1" --mode 1920x1080 --left-of "HDMI-0"

xrdb merge $HOME/.Xresources
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
xsetroot -cursor_name left_ptr &

sxhkd &
exec bspwm
