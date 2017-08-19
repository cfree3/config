#!/bin/sh
# ~/.xinitrc | Curtis Free (https://curtisfree.com)

# See:
#  Arch Linux Forums (http://bbs.archlinux.org), including (but not limited to):
#    http://bbs.archlinux.org/viewtopic.php?id=63610
#    http://bbs.archlinux.org/viewtopic.php?id=84132
#    http://bbs.archlinux.org/viewtopic.php?pid=517550#p517550
#  ArchWiki (https://wiki.archlinux.org), including (but not limited to):
#    https://wiki.archlinux.org/index.php/SLIM
#    https://wiki.archlinux.org/index.php/Accents_on_US_keyboards
#    https://wiki.archlinux.org/index.php/Fonts

AGENT=ssh-agent
DBUS='dbus-launch --auto-syntax --exit-with-session'
FONTS_LOCAL=/usr/share/fonts/local
SESSION_DEFAULT=openbox-session

do_session() { exec ${AGENT} ${DBUS} $1; }

# Pre-WM Startup
## Fonts
xset +fp ${FONTS_LOCAL}
xset fp rehash
## Key Repeat
xset r rate 190 30
## Keymaps
[ -f ${HOME}/.Xmodmap ] && xmodmap ${HOME}/.Xmodmap

# WM/DE
case ${1} in
    gnome)         do_session gnome-session;;
    openbox)       do_session openbox-session;;
    openbox-gnome) do_session openbox-gnome-session;;
    xterm)         do_session xterm;;
    *)             do_session ${SESSION_DEFAULT};;
esac
