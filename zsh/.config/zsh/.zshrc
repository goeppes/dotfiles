# oh-my-zsh options start
export ZSH="$XDG_CONFIG_HOME/oh-my-zsh"

ZSH_THEME="avit"
CASE_SENSITIVE="true"
DISABLE_AUTO_UPDATE="true"

plugins=(git)

[[ -f $ZSH/oh-my-zsh.sh ]] && source $ZSH/oh-my-zsh.sh
# oh-my-zsh options end

# User configuration

HISTFILE=~/.local/share/zsh/history
HISTSIZE=1000
SAVEHIST=5000

alias ll='LC_COLLATE=C ls -alF --group-directories-first'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
