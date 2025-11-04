if [ $ITERM_SESSION_ID ]; then
  DISABLE_AUTO_TITLE="true"
  precmd() {
    echo -ne "\e]0;${PWD##*/}\a"
  }
else 
  precmd() {
    print -Pn "\e]0;%1~\a"
  }
fi

export VOLTA_HOME="$HOME/.volta"
export MOVIDAS_HOME="$HOME/.movidas"
export LOCAL_BIN="$HOME/.local/bin"
export GO_HOME="$HOME/go/bin"
export HOMEBREW_PREFIX="/opt/homebrew";
export HOMEBREW_CELLAR="/opt/homebrew/Cellar";
export HOMEBREW_REPOSITORY="/opt/homebrew";
export PATH="$VOLTA_HOME/bin:$MOVIDAS_HOME:/opt/homebrew/bin:/opt/homebrew/sbin${PATH+:$PATH}:$GO_HOME";
export MANPATH="/opt/homebrew/share/man${MANPATH+:$MANPATH}:";
export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}";

alias vim='~/nvim-macos-arm64/bin/nvim'
alias vimconfig='vim ~/.config/nvim/init.lua'
alias app=~/.movidas/.tmux-app
alias rmorig="find . -name '*.orig' -exec rm -v {} +"

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias lla='ls -alF'
alias ll='ls -lF'
alias la='ls -A'
alias l='ls -CF'

setopt prompt_subst

NEWLINE=$'\n'
# export PS1='%F{214}[%n%F{223}@%F{175}%m %F{108}%1~%F{214}]%F{208}$(__git_ps1) %(?.%F{142}√.%F{167}?%?)${NEWLINE}%F{214}%# %f'
# export PS1='%F{#E6C384}[%n%F{#DCD7BA}@%F{#7E9CD8}%m %F{#76946A}%1~%F{#E6C384}]%F{#FFA066}$(__git_ps1) %(?.%F{#76946A}√.%F{#E82424}?%?)${NEWLINE}%F{#E6C384}%# %f'
export PS1='%F{#7FB4CA}[%n%F{#DCD7BA}@%F{#957FB8}%m %F{#98BB6C}%1~%F{#7FB4CA}]%F{#FF5D62}$(__git_ps1) %(?.%F{#98BB6C}√.%F{#C34043}?%?)${NEWLINE}%F{#7FB4CA}%# %f'

alias gitclean='git br | grep -vE "master|main" | xargs -n 1 git branch -D'

alias aliens='gh pr review $(gh pr view --json number --jq .number) --comment -b "![sonaraliens](https://user-images.githubusercontent.com/68688482/93459650-50cb0080-f8e2-11ea-87ac-6559e5f7cb78.jpg)"'
alias facepalm='gh pr review $(gh pr view --json number --jq .number) --comment -b "![facepalm](https://github.com/escorponox/myconfig/assets/5127194/567ee5de-2df4-4ec9-9c45-50fe074cc21c)"'
alias approved='gh pr review $(gh pr view --json number --jq .number) --comment -b "![approved](https://github.com/user-attachments/assets/3a0224be-3dc1-40ee-b170-278230ac2a7f)"'
