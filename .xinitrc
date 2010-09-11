#!/bin/sh
# ~/.xinitrc | Curtis Free (http://curtisfree.com)

# See:
#  Arch Linux Forums (http://bbs.archlinux.org), including (but not limited to):
#    http://bbs.archlinux.org/viewtopic.php?id=63610
#    http://bbs.archlinux.org/viewtopic.php?id=84132
#  ArchWiki (http;//wiki.archlinux.org), including (but not limited to):
#    http://wiki.archlinux.org/index.php/SLIM
#    http://wiki.archlinux.org/index.php/Accents_on_US_keyboards

AGENT=ssh-agent
CKIT=ck-launch-session
DBUS='dbus-launch --auto-syntax --exit-with-session'
DEFAULT_SESSION=openbox-session

do_session() { exec $AGENT $CKIT $DBUS $1; }

# Pre-WM Startup
## Keymaps
[ -f $HOME/.Xmodmap ] && xmodmap $HOME/.Xmodmap

# WM/DE
case $1 in
    gnome)         do_session gnome-session;;
    openbox)       do_session openbox-session;;
    openbox-gnome) do_session openbox-gnome-session;;
    xterm)         do_session xterm;;
    *)             do_session $DEFAULT_SESSION;;
esac

