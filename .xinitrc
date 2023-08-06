#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then







    xrdb -merge $sysresources

fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then







    xrdb -merge "$userresources"

fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi


# Misc programs
/home/jesse/dwm-bar/dwm_bar.sh &
feh --bg-scale /home/jesse/arch.jpg
imwheel
parcellite &

# Fixes the caps lock issue
xkbcomp -w 0 xkbmap $DISPLAY

# Fixes the secrets
dbus-update-activation-environment --all
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK

# Fixes the NVIDIA refresh rate issue with dual monitor setup
nvidia-settings --load-config-only

# Fixes some java GUi such as pycharm windows
wmname LG3D

# Execute dwm
exec dwm
