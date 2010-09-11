# ~/.zprofile | Curtis Free (http://curtisfree.com)
# This script is run when starting ZSH as a login shell.
# See http://bbs.archlinux.org/viewtopic.php?id=57677.

# If xinit has not been run, a display is set, and on tty1, start X.
# Note that this detection only works if the running X session was started via xinit.
if ! pgrep xinit &>/dev/null && [[ -z "$DISPLAY" ]] && [ $(tty) = /dev/tty1 ]; then
    (nohup xinit &)
    logout
fi

