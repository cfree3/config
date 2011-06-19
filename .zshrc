# ~/.zshrc | Curtis Free (http://curtisfree.com)

# Disable <C-s> terminal stop [1].
stty stop ''

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
export HISTSIZE=100            # Store 100 cmds from current session.
export SAVEHIST=50             # Keep a record of only 50 commands.
export HISTFILE=~/.zsh_history # Save history to ~/.zsh_history.

# Set up completion.
autoload -Uz compinit; compinit

# Set the standard prompt.
# This is a ZSH (%) version of the default Ubuntu BASH prompt.
PROMPT='%n@%m:%~%# '

# If using xterm, rxvt, or screen, set the window title to user@directory.
# Inspired by default Ubuntu .bashrc.
case "$TERM" in
    xterm*|rxvt*|screen)
        precmd () { echo -ne "\033]0;$(print -P '%n@%m: %~')\007"; }
        ;;
    *)
        ;;
esac

# Shell options.
setopt   appendhistory        # Append (don't overwrite) history.
setopt   autocd               # cd when only dir given.
setopt   autopushd            # Automatically push dirs on stack [4].
unsetopt beep                 # Don't beep.
unsetopt bg_nice              # Don't run bg jobs at lower priority.
setopt   check_jobs           # Warn about running jobs before exit.
setopt   complete_in_word     # Complete in the middle of words.
setopt   correct_all          # Correct cmds and args.
setopt   hash_list_all        # Hash command path before correcting commands.
setopt   hist_ignore_dups     # Ignore duplicate cmds in history.
setopt   hist_reduce_blanks   # Remove extra blanks from cmds in history.
unsetopt ignore_eof           # Exit on EOF (Ctrl+D). (10 EOFs still exit with this set.)
setopt   interactive_comments # Allow comments in interactive shells.
unsetopt list_types           # Don't show filetype classifiers when completing filenames.
setopt   multios              # Perform implicit tree and cat on multiple redirections.
setopt   no_hup               # Don't send HUP to jobs on exit.
setopt   notify               # Immediately notify for bg processes.

# Set Emacs-style input mode (alternative given in comment).
bindkey -e # -v

# Keybindings.
## Adjust readline config [8].
READLINE_CONFIG=/etc/inputrc
if [ -f ${READLINE_CONFIG} ]; then
    eval "$(sed -n 's/^/bindkey /; s/: / /p' ${READLINE_CONFIG})"
else
    echo "[WARNING] No readline config found; keybindings might not work."
fi
unset READLINE_CONFIG
## Middle-of-line completion [8].
bindkey "^i"     expand-or-complete-prefix
## Vim command-mode fixes.
bindkey -M vicmd "\e[1~" beginning-of-line
bindkey -M vicmd "\e[4~" end-of-line

# Enable command line editing (<C-t>) [5].
## This `bindkey` should be done after those above.
autoload edit-command-line
zle -N edit-command-line
bindkey '^t' edit-command-line

# Colors.
eval `dircolors`

# Style settings.
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# Aliases.
alias cp='nocorrect cp -i'
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
alias ln='nocorrect ln'
alias ls='ls -h --color=auto'
alias lz='ls -alZ'
alias mkdir='nocorrect mkdir'
alias mv='nocorrect mv -i'
alias pftp='ftp -p'
alias recent='ls -ldAt `ls -At | head`'      # Inspired or taken from elsewhere.
alias rm='rm -i'
alias sps='ps aux | grep -v grep | grep'     # [6]
alias su='su -'
alias todo='$EDITOR ~/.todo'
alias vmstat='vmstat -S M'
alias web='$BROWSER'

# Suffix aliases.
alias -s htm=$BROWSER
alias -s html=$BROWSER
alias -s txt=$EDITOR
alias -s xhtml=$BROWSER

# Enable aliases when using sudo (optional -- has problems with aliases that use nocorrect).
#alias sudo='sudo ' # Note the trailing space.

# Vim alias(es).
if exists vim; then
    alias vi='vim'
    (! exists view) && alias view='vim -R'
elif exists vi; then
    alias vim='vi'
    (! exists view) && alias view='vi -R'
fi

# Screen alias(es).
if [[ $TERM =~ screen(.linux)? ]]; then
    alias s='screen'
fi

# Utility environment variables [4].
export GREP_OPTIONS="--color=auto"

# Functions.
## Simple file backup.
bak   () { cp -ip $1 $1.bak; } && alias bak='nocorrect bak'
## System beep.
beep   () { echo -ne '\a'; }
## Directory contents count (accepts ls flags/args).
cnt   () { ls $@ | wc -l; }
## Finds files by name based on the given search pattern.
ff    () { find . -name "*$@*" -exec ls -ldh --color=auto {} +; }
## List details on an item in the PATH.
lw    () { ll `which $1`; }
## Make a new directory and change into it [7].
mkcd  () { mkdir -p $1 && cd $1; } && alias mkcd='nocorrect mkcd'
## Send a file to the "trash" without actually deleting it.
trash () { [ -f ~/TRASH ] || mkdir ~/TRASH; mv $@ ~/TRASH; }
## Open a simple SSH tunnel.
tunnel() { ssh -ND 8080 $1; }
## View a file in the PATH.
vw    () { view `which $1`; }

# Variable modifications.
unset LC_COLLATE # Prevent "C" sorting.

# PATH modifications.
[ -d ~/bin ] && export PATH=$PATH:$HOME/bin

# References
# [1] http://www.catonmat.net/blog/vim-plugins-surround-vim
# [2] http://bbs.archlinux.org/viewtopic.php?pid=553911#p553911
# [3] http://cinderwick.ca/files/configs/bashrc
# [4] http://unix.stackexchange.com/questions/6/what-are-your-favorite-command-line-features-or-tricks
# [5] http://stackoverflow.com/questions/890620/unable-to-have-bash-like-c-x-e-in-zsh
# [6] http://cinderwick.ca/files/configs/bashrc
# [7] http://bbs.archlinux.org/viewtopic.php?pid=402480#p402480
# [8] https://wiki.archlinux.org/index.php/Zsh

