# ~/.bashrc | Curtis Free (http://curtisfree.com)

# Disable <C-s> terminal stop [1].
stty stop ''

# Set up PATH.
[ -d ~/bin ] && export PATH=$PATH:$HOME/bin

# Silent command execution [2].
silent () { $@ &>/dev/null; }
# (Silent) command existence checking [3].
exists () { silent type $@; }

# Standard exports.
export BROWSER=firefox
EDITOR=vim && exists $EDITOR || EDITOR=vi; export EDITOR
PAGER=less && exists $PAGER || PAGER=more; export PAGER
VISUAL=$EDITOR; export VISUAL # We'll use the same editor.

# History settings.
export HISTCONTROL=ignoredups                             # Don't store repeat commands.
export HISTIGNORE="&:ls:la:ll:lla:[bf]g:exit:clear:reset" # Ignore certain common commands.
export HISTSIZE=100                                       # Store 100 cmds from current session.
export HISTFILESIZE=50                                    # Keep a record of only 50 commands.

# Miscellaneous settings.
unset IGNOREEOF # Set to 10 to match ZSH's ignore_eof option.

# Enable programmable completion.
[ -f /etc/bash_completion ] && . /etc/bash_completion

# Set the standard prompt.
# This is a ZSH (%) version of the default Ubuntu BASH prompt.
PS1='\u@\h:\w\$ '

# If using xterm, rxvt, or screen, set the window title to user@directory; in
# tmux, change default path.
# Taken from default Ubuntu .bashrc and inspired by [8].
case "$TERM" in
    xterm*|rxvt*|screen)
        PROMPT_COMMAND='
            echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"
            [ -n "$TMUX" ] && $(tmux set default-path $(pwd))
        '
        ;;
    *)
        ;;
esac

# Shell options.
set -o noclobber      # Do not overwrite existing files (w/ redirection).
shopt -s cdspell      # Correct misspelled directories (w/ cd).
shopt -s hostcomplete # Complete hostnames [4].

# Set Emacs-style input mode (alternative given in comment).
set -o emacs # vi

# Binds [4].
bind '"\e[A"':history-search-backward
bind '"\e[B"':history-search-forward

# Colors for various utilities.
eval `dircolors`

# Aliases.
alias cp='cp -i'
alias cups='$BROWSER http://localhost:631 &'
alias daemons='ls /var/run/daemons'          # Inspired or taken from elsewhere.
alias df='df -h'
alias du='du -h'
alias es='echo $?'
alias fenv='env | grep'
alias free='free -m'
alias killall='killall -i'
alias la='ls -a'
alias ll='ls -l'
alias lla='ls -al'
alias ls='ls -h --color=auto'
alias lz='ls -alZ'
alias mv='mv -i'
alias pftp='ftp -p'
alias recent='ls -ldAt `ls -At | head`'      # Inspired or taken from elsewhere.
alias rm='rm -i'
alias sps='ps aux | grep -v grep | grep'     # [5]
alias su='su -'
alias todo='$EDITOR ~/.todo'
alias vmstat='vmstat -S M'
alias web='$BROWSER'
alias which='(alias; declare -f) | which --read-alias --read-functions --show-tilde --show-dot'

# Enable aliases when using sudo.
alias sudo='sudo ' # Note the trailing space.

# Vim alias(es).
if exists vim; then
    alias vim='vim -p'
    alias vi='vim'
    (! exists view) && alias view='vim -R'
elif exists vi; then
    alias vi='vi -p'
    alias vim='vi'
    (! exists view) && alias view='vi -R'
fi

# Screen alias(es).
## Be sure not to set this if actually using tmux.
if [ -z "$TMUX" ] && [[ $TERM =~ screen(.linux)? ]]; then
    alias s='screen'
fi

# Utility environment variables [4].
export GREP_OPTIONS="--color=auto"

# Functions.
## Simple file backup.
bak    () { cp -ip $1 $1.bak; }
## System beep.
beep   () { echo -ne '\a'; }
## Directory contents count (accepts ls flags/args).
cnt    () { ls $@ | wc -l; }
## Finds files by name based on the given search pattern.
ff     () { find . -name "*$@*" -exec ls -ldh --color=auto {} +; }
## List details on an item in the PATH.
lw     () { ll `which $1`; }
## Make a new directory and change into it [6].
mkcd   () { mkdir -p $1 && cd $1; } # Taken from Arch Linux Forums.
## Send a file to the "trash" without actually deleting it.
trash  () { [ -f ~/TRASH ] || mkdir ~/TRASH; mv $@ ~/TRASH; }
## Open a simple SSH tunnel.
tunnel() { ssh -ND 8080 $1; }
## View a file in the PATH.
vw     () { view `which $1`; }

# Command Prompt
## Changes the prompt to include the output of a particular command [7].
## Calling with no argument essentially resets.
function cmdprompt() {
    PS1="\u@\h:\w\[\033[32m\]$(${1})\[\033[0m\]\\$ "
}

# Variable modifications.
unset LC_COLLATE # Prevent "C" sorting.

# References
# [1] http://www.catonmat.net/blog/vim-plugins-surround-vim
# [2] http://bbs.archlinux.org/viewtopic.php?pid=553911#p553911
# [3] http://cinderwick.ca/files/configs/bashrc
# [4] http://unix.stackexchange.com/questions/6/what-are-your-favorite-command-line-features-or-tricks
# [5] http://cinderwick.ca/files/configs/bashrc
# [6] http://bbs.archlinux.org/viewtopic.php?pid=402480#p402480
# [7] http://tldp.org/HOWTO/Bash-Prompt-HOWTO/x329.html
# [8] https://wiki.archlinux.org/index.php/Tmux#Fast_method

