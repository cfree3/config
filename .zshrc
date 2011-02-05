# ~/.zshrc | Curtis Free (http://curtisfree.com)

# Disable <C-s> terminal stop.
# See http://www.catonmat.net/blog/vim-plugins-surround-vim.
stty stop ''

# Silent command execution.
## See http://bbs.archlinux.org/viewtopic.php?pid=553911#p553911.
silent () { $@ &>/dev/null; }
# (Silent) command existence checking.
## Idea taken from http://cinderwick.ca/files/configs/bashrc.
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

# Keybindings (most taken from ArchWiki).
## Standard.
bindkey "\e[1~"  beginning-of-line
bindkey "\e[4~"  end-of-line
bindkey "\e[5~"  beginning-of-history
bindkey "\e[6~"  end-of-history
bindkey "\e[3~"  delete-char
bindkey "\e[2~"  quoted-insert
bindkey "\e[5C"  forward-word
bindkey "\eOc"   emacs-forward-word
bindkey "\e[5D"  backward-word
bindkey "\eOd"   emacs-backward-word
bindkey "\e\e[C" forward-word
bindkey "\e\e[D" backward-word
bindkey "^H"     backward-delete-word
bindkey "^?"     backward-delete-char
## rxvt.
bindkey "\e[8~"  end-of-line
bindkey "\e[7~"  beginning-of-line
## Non-RH/Debian xterm.
bindkey "\eOH"   beginning-of-line
bindkey "\eOF"   end-of-line
## FreeBSD console.
bindkey "\e[H"   beginning-of-line
bindkey "\e[F"   end-of-line
## Middle-of-line completion.
bindkey "^i"     expand-or-complete-prefix
## Vim command-mode fixes.
bindkey -M vicmd "\e[1~" beginning-of-line
bindkey -M vicmd "\e[4~" end-of-line

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
alias egrep='egrep --color=auto'
alias es='echo $?'
alias fenv='env | grep'
alias fgrep='fgrep --color=auto'
alias free='free -m'
alias grep='grep --color=auto'
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
alias sps='ps aux | grep -v grep | grep'     # See http://cinderwick.ca/files/configs/bashrc.
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
## Make a new directory and change into it.
## See http://bbs.archlinux.org/viewtopic.php?pid=402480#p402480.
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

