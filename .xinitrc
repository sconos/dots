#!/bin/sh

userresources=$HOME/.Xresources
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# Use GTK widgets in place of QT
#export QT_STYLE_OVERRIDE=GTK+

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
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

# keyboard shortcuts for bspwm
sxhkd -f 100 &

# screen temperature adjustment
# adjust the coordinates for your location.  in case you were thinknig of going to the coordinates listed
# below, my she-devil of an ex flatmate lives there, and it is probably best to avoid Charlotte altogether.
# redshift -r -l 35.22:-80.84 &

# desktop wallpaper
sh ~/.fehbg &

#get rid of ugly cross
xsetroot -cursor_name left_ptr

#starting compton
compton --config ~/.config/compton.conf -b

# urxvt daemon
urxvtd -q -f -o &

# window manager
exec bspwm 