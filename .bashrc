# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm|xterm-color|*-256color) color_prompt=yes;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias lla='ls -alF'
alias ll='ls -lF'
alias la='ls -A'
alias l='ls -CF'

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth:erasedups

# append to the history file, don't overwrite it
shopt -s histappend
shopt -s cmdhist

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=20000

PROMPT_COMMAND='history -a'
# PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }'printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"'


export HISTIGNORE="ls:ps:history:vim"

# source /etc/bash_completion.d/git-prompt
# source /usr/share/bash-completion/completions/git
source /usr/share/git/completion/git-prompt.sh
source /usr/share/git/completion/git-completion.bash

PS1="\[\e]0;\W\a\]\[\e[1;33m\][\[\e[m\]\[\e[1;33m\]\u\[\e[m\]@\[\e[1;35m\]\h\[\e[m\] \[\e[1;36m\]\W\[\e[m\]\[\e[1;33m\]]\[\e[m\]\[\e[1;33m\]\`__git_ps1\`\n\[\e[m\]\[\e[1;33m\]\\$\[\e[m\] "

complete -cf sudo
complete -cf man

alias sudo='sudo '
alias vim='nvim'
# alias vim='~/nvim.appimage'
alias vimdiff='nvim -d'
alias vimconfig='vim ~/.config/nvim/init.vim'
alias rmorig="find . -name '*.orig' -exec rm {} +"

alias ydl='/usr/local/bin/youtube-dl --extract-audio --audio-format mp3 --audio-quality 0 --ignore-errors -o "%(playlist_index)s - %(title)s.%(ext)s"'
alias kc='kubectl'

export JAVA_HOME=/usr/lib/jvm/java-12-openjdk
export PATH=$PATH:/usr/lib/jvm/java-12-openjdk/bin:~/.yarn/bin

export ARDUINO_PATH=/usr/bin/arduino

export EDITOR="nvim"
export VISUAL="nvim"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
