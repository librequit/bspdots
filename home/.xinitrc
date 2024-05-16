#!/bin/sh

dbus-run-session pipewire &
dbus-run-session pipewire-pulse & 
dbus-run-session wireplumber &

xrdb merge $HOME/.Xresources
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
xsetroot -cursor_name left_ptr &

sxhkd &
exec bspwm
