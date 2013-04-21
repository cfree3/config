# ~/.zshrc | Curtis Free (http://curtisfree.com)

# Disable <C-s> terminal stop [1].
stty stop ''

# Silent command execution [2].
silent () { ${@} &>/dev/null; }
# (Silent) command existence checking [3].
exists () { silent type ${@}; }

# Set up PATH [17,18].
[ -d /Homebrew/bin ] && export PATH=${PATH}:/Homebrew/bin
[ -d /Applications/Xcode.app/Contents/Developer/usr/bin ] && export PATH=${PATH}:/Applications/Xcode.app/Contents/Developer/usr/bin
exists gem && export PATH=${PATH}:$(gem environment | grep "\- EXECUTABLE DIRECTORY" | sed "s/.*: //")
[ -d ~/bin ] && export PATH=${PATH}:~/bin

# Standard exports.
## EDITOR
if exists mvim; then
    EDITOR='mvim -vp'
elif exists vim; then
    EDITOR='vim -p'
elif exists vim; then
    EDITOR='vim'
fi
export EDITOR
## VISUAL
if exists mvim || [ "${DISPLAY}" ]; then
    if exists mvim; then
        VISUAL='mvim -p'
    elif exists gvim; then
        VISUAL='gvim -p'
    fi
else
    VISUAL=${EDITOR}
fi
export VISUAL
## PAGER
if exists less; then
    PAGER='less'
elif exists more; then
    PAGER='more'
fi
export PAGER
## BROWSER
if exists open; then
    BROWSER='open'
elif exists google-chrome; then
    BROWSER='google-chrome'
elif exists chromium; then
    BROWSER='chromium'
elif exists firefox; then
    BROWSER='firefox'
fi
export BROWSER

# History settings.
export HISTSIZE=100            # Store 100 cmds from current session.
export SAVEHIST=50             # Keep a record of only 50 commands.
export HISTFILE=~/.zsh_history # Save history to ~/.zsh_history.

# Set up completion [16].
autoload -Uz compinit && compinit

# Set the standard prompt.
# This is a ZSH (%) version of the default Ubuntu BASH prompt.
PROMPT='%F{yellow}%n@%m:%~%#%f '

# Configure support for VCS info [12,13].
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git svn
zstyle ':vcs_info:*' formats '[%b]%c%u'
zstyle ':vcs_info:*' stagedstr '+'
zstyle ':vcs_info:*' unstagedstr '-'
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' disable-patterns "${HOME}"

# The right-side prompt should show the time and VCS info; "black" text (still
# visible on dark background) makes the prompt less obtrusive.
RPROMPT='%F{black}[%D{%r}]${vcs_info_msg_0_}%f'

# If using xterm, rxvt, or screen, set the window title to user@directory; in
# tmux, change default path; determine VCS information [12,13].
# Inspired by default Ubuntu .bashrc and [10].
case "$TERM" in
    xterm*|rxvt*|screen)
        precmd () {
            echo -ne "\033]0;$(print -P '%n@%m: %~')\007"
            [ -n "$TMUX" ] && $(tmux set default-path $(pwd))
            vcs_info &>/dev/null # errors if going from VCS dir back to ~
        }
        ;;
    *)
        ;;
esac

# Case-insensitive completion [15].
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# Shell options.
setopt   appendhistory        # Append (don't overwrite) history.
setopt   autocd               # cd when only dir given.
setopt   autopushd            # Automatically push dirs on stack [4].
setopt   bang_hist            # Perform !<cmd> expansion [8].
unsetopt beep                 # Don't beep.
unsetopt bg_nice              # Don't run bg jobs at lower priority.
setopt   check_jobs           # Warn about running jobs before exit.
unsetopt clobber              # Don't clobber files with > (use >!) [8].
setopt   complete_in_word     # Complete in the middle of words.
unsetopt correct_all          # Do NOT correct cmds and args.
setopt   hash_list_all        # Hash command path before correcting commands.
setopt   hist_ignore_dups     # Ignore duplicate cmds in history.
setopt   hist_reduce_blanks   # Remove extra blanks from cmds in history.
setopt   hist_verify          # Bring history expansions to the command line (don't execute).
unsetopt ignore_eof           # Exit on EOF (Ctrl+D). (10 EOFs still exit with this set.)
setopt   interactive_comments # Allow comments in interactive shells.
setopt   list_packed          # Use variable-width columns in completion menus [14].
unsetopt list_types           # Don't show filetype classifiers when completing filenames.
setopt   multios              # Perform implicit tree and cat on multiple redirections.
setopt   no_hup               # Don't send HUP to jobs on exit.
setopt   notify               # Immediately notify for bg processes.
setopt   prompt_subst         # Perform regular shell substitution in prompt.

# Set Emacs-style input mode (alternative given in comment).
bindkey -e # -v

# Keybindings.
## Prefer readline config [8].
READLINE_CONFIG=/etc/inputrc
if [ -f ${READLINE_CONFIG} ]; then
    eval "$(sed -n 's/^/bindkey /; s/: / /p' ${READLINE_CONFIG})"
## Fallback [8].
else
    ## Standard.
    bindkey "\e[1~"  beginning-of-line
    bindkey "\e[4~"  end-of-line
    bindkey "\e[5~"  beginning-of-history
    bindkey "\e[6~"  end-of-history
    bindkey "\e[3~"  delete-char
    bindkey "\e[2~"  quoted-insert
    bindkey "\e[5C"  forward-word
    bindkey "\e[5D"  backward-word
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
fi
unset READLINE_CONFIG
## Bindings not in standard readline config [8].
bindkey "^?"     backward-delete-char
bindkey "\eOc"   emacs-forward-word
bindkey "\eOd"   emacs-backward-word
## Middle-of-line completion [8].
bindkey "^i"     expand-or-complete-prefix
### tmux issues OC and OD instead
bindkey "\eOC"   emacs-forward-word
bindkey "\eOD"   emacs-backward-word
## Vim command-mode fixes.
bindkey -M vicmd "\e[1~" beginning-of-line
bindkey -M vicmd "\e[4~" end-of-line

# Enable command line editing (<C-t>) [5].
## This `bindkey` should be done after those above.
autoload edit-command-line
zle -N edit-command-line
bindkey '^t' edit-command-line

# Colors for various utilities.
exists dircolors && eval `dircolors`

# Style settings.
## Use colors when showing filename suggestions.
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
## Use a menu interface for completions [8].
zstyle ':completion:*' menu select # [8]
## Complete PIDs [8].
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*' force-list always

# Aliases.
alias cp='cp -i'
alias cups='${BROWSER} http://localhost:631 &'
alias df='df -h'
alias du='du -h'
alias es='echo ${?}'
alias fenv='env | grep'
alias free='free -m'
alias killall='killall -i'
alias la='ls -a'
alias ll='ls -l'
alias lla='ls -al'
alias lz='ls -alZ'
alias mkdir='mkdir'
alias mv='mv -i'
alias pftp='ftp -p'
alias rm='rm -i'
alias su='su -'
alias todo='${EDITOR} ~/.todo'
alias web='${BROWSER}'

# Suffix aliases.
alias -s htm=${BROWSER}
alias -s html=${BROWSER}
alias -s java=${EDITOR}
alias -s sql=${EDITOR}
alias -s tex=${EDITOR}
alias -s txt=${EDITOR}
alias -s xhtml=${BROWSER}

# Enable aliases when using sudo (NOTE: has problems with aliases that use nocorrect).
alias sudo='sudo ' # Note the trailing space.

# Vim alias(es).
if [ "${EDITOR}" ]; then

    ## CLI
    alias vi=${EDITOR}
    alias vim=${EDITOR}
    alias view="${EDITOR} -R"

    ## GUI
    alias gvim=${VISUAL}
    alias mvim=${VISUAL}
    alias gview="${VISUAL} -R"
    alias mview="${VISUAL} -R"

fi

# Copy/paste alias(es).
## To copy:
##   echo ${SOURCE} | yank
## To paste:
##   put | ${SINK}
if exists xclip; then
    alias yank='xclip'
    alias put='xclip'
elif exists pbcopy && exists pbpaste; then
    alias yank='pbcopy'
    alias put='pbpaste'
fi

# Screen alias(es).
## Be sure not to set this if actually using tmux.
if [ -z "$TMUX" ] && [[ $TERM =~ screen(.linux)? ]]; then
    alias s='screen'
fi

# Utility settings [4].
## grep
export GREP_OPTIONS="--color=auto"
## ls
export CLICOLOR=
### CLICOLOR works on the BSD version included with OS X; include alias for GNU version.
silent ls --color=auto && alias "ls --color=auto"

# Functions.
## Simple file backup.
bak   () { cp -ip ${1} ${1}.bak; } && alias bak='nocorrect bak'
## System beep.
beep  () { echo -ne '\a'; }
## Directory contents count (accepts ls flags/args).
cnt   () { ls ${@} | wc -l; }
## Resolve IPs [19].
ip    () { dscacheutil -q host -a name ${1}; }
## Finds files by name based on the given search pattern.
ff    () { find . -name "*${@}*" -exec ls -ldh {} +; }
## List details on an item in the PATH.
lw    () { ll `which ${1}`; }
## Make a new directory and change into it [7].
mkcd  () { mkdir -p ${1} && cd ${1}; } && alias mkcd='nocorrect mkcd'
## Send a file to the "trash" without actually deleting it.
trash () { [ -f ~/.Trash ] || mkdir ~/.Trash; mv ${@} ~/.Trash; }
## Open a simple SSH tunnel.
tunnel() { ssh -ND 8080 ${1}; }
## View a file in the PATH.
vw    () { view `which ${1}`; }

# Set terminal title.
## http://superuser.com/questions/292652/change-iterm2-window-and-tab-titles-in-zsh
function title() {
    exists precmd && unfunction precmd
    echo -ne "\e]1;${@}\a"
}

# Command Prompt
## Changes the prompt to include the output of a particular command [9].
## Calling with no argument essentially resets.
function cmdprompt() {
    autoload -U colors && colors && setopt prompt_subst
    PROMPT="%n@%m:%~%{\$fg[green]%}\$(${1})%{\$reset_color%}%# "
}

# Variable modifications.
unset LC_COLLATE # Prevent "C" sorting.

# References
##  [1] http://www.catonmat.net/blog/vim-plugins-surround-vim
##  [2] http://bbs.archlinux.org/viewtopic.php?pid=553911#p553911
##  [3] http://cinderwick.ca/files/configs/bashrc
##  [4] http://unix.stackexchange.com/questions/6/what-are-your-favorite-command-line-features-or-tricks
##  [5] http://stackoverflow.com/questions/890620/unable-to-have-bash-like-c-x-e-in-zsh
##  [6] http://cinderwick.ca/files/configs/bashrc
##  [7] http://bbs.archlinux.org/viewtopic.php?pid=402480#p402480
##  [8] https://wiki.archlinux.org/index.php/Zsh
##  [9] http://stackoverflow.com/questions/689765/how-can-i-change-the-color-of-my-prompt-in-zsh-different-from-normal-text
## [10] https://wiki.archlinux.org/index.php/Tmux#Fast_method
## [11] http://www.acm.uiuc.edu/workshops/zsh/history/hist_expn.html
## [12] http://stackoverflow.com/questions/1128496/to-get-a-prompt-which-indicates-git-branch-in-zsh
## [13] http://zsh.sourceforge.net/Doc/Release/User-Contributions.html#Version-Control-Information
## [14] http://aperiodic.net/phil/configs/zshrc
## [15] http://hintsforums.macworld.com/showthread.php?t=6493
## [16] http://nuclearsquid.com/writings/git-tricks-tips-workflows/
## [17] https://mailman.archlinux.org/pipermail/arch-dev-public/2012-February/022528.html
## [18] http://stackoverflow.com/questions/5056163/what-is-the-default-search-path-for-ruby-gems-i-e-the-default-gem-home
## [19] http://superuser.com/a/299431

