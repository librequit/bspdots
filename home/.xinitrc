xrdb merge $HOME/.Xresources
setxkbmap -option grp:alt_shift_toggle us,ru
polkit-gnome &
xsetroot -cursor_name left_ptr &

exec bspwm
