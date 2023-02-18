# ~/.zshrc | Curtis Free (https://curtisfree.com)

# Disable <C-s> terminal stop [1].
stty stop ''

# Silent command execution [2].
silent () { ${@} &>/dev/null; }
# (Silent) command existence checking [3].
exists () { silent type ${@}; }

# Initial PATH setup (from macOS /zshenv) [20].
if [ -x /usr/libexec/path_helper ]; then
    eval $(/usr/libexec/path_helper -s)
fi

# Update PATH for Homebrew (/opt for Apple silicon).
if [ -x /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Additional PATH setup [17,18,23].
[ -d ~/bin ] && export PATH=${PATH}:~/bin

# Standard exports.
## EDITOR
if exists nvim; then
    EDITOR='nvim'
elif exists vim; then
    EDITOR='vim'
fi
export EDITOR
## VISUAL
export VISUAL=${EDITOR}
## PAGER
if exists less; then
    PAGER='less'
elif exists more; then
    PAGER='more'
fi
export PAGER
## MANPAGER [24]
if exists nvim; then
    export MANPAGER='nvim +Man!'
elif exists vim; then
    export MANPAGER='vim -M +MANPAGER -'
fi
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
# This is a ZSH (%) version of the default RHEL BASH prompt.
PROMPT='%F{blue}[%n@%m %1~]%F{green}%#%f '

# Configure support for VCS info [12,13].
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git svn
zstyle ':vcs_info:*' formats '[%b]'
zstyle ':vcs_info:*' disable-patterns "${HOME}"

# The right-side prompt should show the time and VCS info; "black" text (still
# visible on dark background) makes the prompt less obtrusive.
RPROMPT='%F{yellow}[%D{%r}]${vcs_info_msg_0_}%f'

# If using xterm, rxvt, or screen/tmux, set the window title to user@directory;
# determine VCS information [12,13].
# Inspired by default Ubuntu .bashrc and [10].
case "$TERM" in
    xterm*|rxvt*|screen*|tmux*) # includes `*-256color` variants
        precmd () {
            echo -ne "\033]0;$(print -P '%n@%m: %~')\007"
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

# Standard keybindings that don't work out of the box.
## Delete key.
bindkey "\e[3~" delete-char
## Home key.
bindkey "\e[1~" beginning-of-line
## End key.
bindkey "\e[4~" end-of-line

# Custom keybindings.
## Word movement (Option or Control) + Left/Right.
### tmux
bindkey "\e\e[C" forward-word
bindkey "\e\e[D" backward-word
### iTerm2 (Option = "+Esc", Delete = ^?)
#### "xterm Defaults" or "xterm with Numeric Keypad"
bindkey "\e[1;9C" forward-word
bindkey "\e[1;9D" backward-word
bindkey "\eOC" forward-word
bindkey "\eOD" backward-word
#### "Terminal.app compatibility"
bindkey "\e[5C" forward-word
bindkey "\e[5D" backward-word
### Terminal (Mac OS X)
bindkey "\e[1;5C" forward-word
bindkey "\e[1;5D" backward-word

# Enable command line editing (<C-t>) [5].
## This `bindkey` should be done after those above.
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^t' edit-command-line

# Treat "words" like BASH [21].
autoload -Uz select-word-style && select-word-style bash

# Colors for various utilities.
exists dircolors && eval `dircolors`

# Style settings.
## Use colors when showing filename suggestions.
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
## Use a menu interface for completions [8].
zstyle ':completion:*' menu select
## Complete PIDs [8].
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*' force-list always

# Aliases.
alias cp='cp -i'
alias la='ls -a'
alias ll='ls -l'
alias lla='ls -al'
alias mv='mv -i'
alias rm='rm -i'

# Suffix aliases.
alias -s htm=${BROWSER}
alias -s html=${BROWSER}
alias -s java=${EDITOR}
alias -s sql=${EDITOR}
alias -s tex=${EDITOR}
alias -s txt=${EDITOR}
alias -s xhtml=${BROWSER}

# Enable aliases when using sudo (won't work if an alias uses `nocorrect`).
alias sudo='sudo ' # Note the trailing space.

# SELinux helpers.
if exists /sbin/getenforce; then
    alias lz='ls -alZ'
fi

# Vim aliases.
if [ "${EDITOR}" ]; then
    alias nvim=${EDITOR}
    alias vi=${EDITOR}
    alias vim=${EDITOR}
    alias view="${EDITOR} -R"
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

# Taskwarrior alias(es).
if exists task; then
    alias t='task'
fi

# Utility settings [4].
## grep
export GREP_OPTIONS="--color=auto"
## ls
export CLICOLOR=
### CLICOLOR works on the BSD version included with OS X; include alias for GNU version.
silent ls --color=auto && alias "ls --color=auto"

# Functions.
## Make a new directory and change into it [7].
mkcd  () { mkdir -p ${1} && cd ${1}; } && alias mkcd='nocorrect mkcd'
## Send a file to the "trash" without actually deleting it.
trash () { [ -f ~/.Trash ] || mkdir ~/.Trash; mv ${@} ~/.Trash; }
## Open a simple SSH tunnel.
tunnel() { ssh -ND 8080 ${1}; }

# Special functions.
## Resolve IPs [19].
exists dscacheutil && ip() { dscacheutil -q host -a name ${1}; }

# Set terminal title.
## http://superuser.com/questions/292652/change-iterm2-window-and-tab-titles-in-zsh
function title() {
    exists precmd && unfunction precmd
    echo -ne "\e]1;${@}\a"
}

# Variable modifications.
unset LC_COLLATE # Prevent "C" sorting.

# Fix terminfo for tmux so that <C-h> doesn't mean backspace [23].
if infocmp ${TERM} | grep --silent 'kbs=^[hH]'; then
    term_kbs=$(mktemp)
    infocmp ${TERM} | sed 's/kbs=^[hH]/kbs=\\177/' >! ${term_kbs}
    tic ${term_kbs}
    unset term_kbs
fi

# Allow system-specific config/overrides.
[ -f ${HOME}/.zshrc.local ] && source ${HOME}/.zshrc.local

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
## [20] https://github.com/Homebrew/homebrew/issues/25407
## [21] http://stackoverflow.com/a/1438523
## [22] https://github.com/Homebrew/homebrew/blob/master/share/doc/homebrew/Gems,-Eggs-and-Perl-Modules.md
## [23] https://github.com/neovim/neovim/issues/2048#issuecomment-78045837
## [24] https://www.reddit.com/r/vim/comments/morzue/vim_has_a_native_plugin_that_allows_you_to_turn/
