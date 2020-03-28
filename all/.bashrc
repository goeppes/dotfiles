# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

export EDITOR="vim"
export LANG="en_US.UTF-8"

PATH="/usr/local/cuda-8.0/bin:$PATH"
PATH="/usr/local/go/bin:$PATH"
#PATH="$HOME/anaconda/bin:$PATH"
PATH="$(stack path --compiler-bin):$PATH"
PATH="$HOME/.local/bin:$PATH"
PATH="$HOME/.cargo/bin:$PATH"
PATH="$HOME/.poetry/bin:$PATH"
PATH="$HOME/.pyenv/bin:$PATH"
PATH="$HOME/bin:$PATH"
export PATH

export PYENV_ROOT="$HOME/.pyenv"

eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

export LD_LIBRARY_PATH="/usr/local/cuda-8.0/lib64:$LD_LIBRARY_PATH"

# If not running interactively, don't do anything
[[ -z "$PS1" ]] && return

# automatically start tmux if we can
#if command -v tmux>/dev/null; then
#  [[ ! $TERM =~ screen ]] && [ -z $TMUX ] && exec tmux new-session -A -s main
#fi

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# append to the history file, don't overwrite it
shopt -s histappend

# update LINES and COLUMNS on window resize
shopt -s checkwinsize

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
export HISTCONTROL=ignoreboth
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
export HISTSIZE=1000
export HISTFILESIZE=2000

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

################################################################################
#
#  ALIASES
#
################################################################################

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  alias grep='grep --color=auto'
fi

# some more ls aliases
alias ll='LC_COLLATE=C ls -alF --group-directories-first'
alias la='ls -A'
alias l='ls -CF'

alias tree="tree --dirsfirst -a"
alias cls="tput reset"
alias winej="LANG='ja_JP.UTF8' wine"
alias ssudo='sudo -E env "PATH=$PATH"'
alias helmrun="helm2 tiller run -- helm2"

################################################################################
#
#  PROMPT CUSTOMIZATION
#
################################################################################

if [[ $COLORTERM = gnome-* && $TERM = xterm ]] && infocmp gnome-256color >/dev/null 2>&1; then
  export TERM='gnome-256color'
elif infocmp xterm-256color >/dev/null 2>&1; then
  export TERM='xterm-256color'
fi

prompt_git() {
  local s='';
  local branchName='';

  # Check if the current directory is in a Git repository.
  if [ $(git rev-parse --is-inside-work-tree &>/dev/null; echo "${?}") == '0' ]; then
    # check if the current directory is in .git before running git checks
    if [ "$(git rev-parse --is-inside-git-dir 2> /dev/null)" == 'false' ]; then
      # Ensure the index is up to date.
      git update-index --really-refresh -q &>/dev/null
      # Check for uncommitted changes in the index.
      if ! $(git diff --quiet --ignore-submodules --cached); then s+='+'; fi
      # Check for unstaged changes.
      if ! $(git diff-files --quiet --ignore-submodules --); then s+='!'; fi
      # Check for untracked files.
      if [ -n "$(git ls-files --others --exclude-standard)" ]; then s+='?'; fi
      # Check for stashed files.
      if $(git rev-parse --verify refs/stash &>/dev/null); then s+='$'; fi
    fi
    # Get the short symbolic ref.
    # If HEAD isn’t a symbolic ref, get the short SHA for the latest commit
    # Otherwise, just give up.
    branchName="$(git symbolic-ref --quiet --short HEAD 2> /dev/null || \
      git rev-parse --short HEAD 2> /dev/null || \
      echo '(unknown)')"
    [ -n "${s}" ] && s=" [${s}]"
    echo -e "${1}${branchName}${2}${s}"
  else
    return
  fi
}

if test -z "$EMACS"; then
  if tput setaf 1 &> /dev/null; then
    tput sgr0; # reset colors
    bold=$(tput bold);
    reset=$(tput sgr0);
    # Solarized colors, taken from http://git.io/solarized-colors.
    black=$(tput setaf 0);
    blue=$(tput setaf 33);
    cyan=$(tput setaf 37);
    green=$(tput setaf 64);
    orange=$(tput setaf 166);
    purple=$(tput setaf 125);
    red=$(tput setaf 124);
    violet=$(tput setaf 61);
    white=$(tput setaf 15);
    yellow=$(tput setaf 136);
  else
    bold='';
    reset="\e[0m";
    black="\e[1;30m";
    blue="\e[1;34m";
    cyan="\e[1;36m";
    green="\e[1;32m";
    orange="\e[1;33m";
    purple="\e[1;35m";
    red="\e[1;31m";
    violet="\e[1;35m";
    white="\e[1;37m";
    yellow="\e[1;33m";
  fi;

  # Highlight the user name when logged in as root.
  if [[ "${USER}" == "root" ]]; then
    userStyle="${red}";
  else
    userStyle="${orange}";
  fi;

  # Highlight the hostname when connected via SSH.
  if [[ "${SSH_TTY}" ]]; then
    hostStyle="${bold}${red}";
  else
    hostStyle="${yellow}";
  fi;

  PS1="\[\033]0;\W\007\]"
  PS1+="\[${userStyle}\]\u" # username
  PS1+="\[${white}\]@"
  PS1+="\[${hostStyle}\]\h" # host
  PS1+="\[${white}\]:"
  PS1+="\[${green}\]\w" # working directory
  PS1+="\$(prompt_git \"\[${white}\] on \[${violet}\]\" \"\[${blue}\]\")"
  PS1+="\n"
  PS1+="\[${white}\]\$ \[${reset}\]"
  export PS1

  PS2="\[${yellow}\]> \[${reset}\]"
  export PS2
else
  export PS1="\u@\h:\w\$(prompt_git \" on \" \"\")\n\$ "
fi

################################################################################
#
#  MISCELLANEOUS
#
################################################################################

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

if [ -e ~/.fzf ]; then
  PATH="$PATH:~/.fzf/bin"
  source ~/.fzf/shell/key-bindings.bash
  source ~/.fzf/shell/completion.bash
fi

source <(kubectl completion bash)

# opam configuration
test -r /home/tyro/.opam/opam-init/init.sh && . /home/tyro/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true

complete -C '/home/tyro/.local/bin/aws_completer' aws

export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "![.git,node_modules]/*" 2> /dev/null'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
bind -x '"\C-x": vim $(fzf);'

[[ -s "/home/tyro/.gvm/scripts/gvm" ]] && source "/home/tyro/.gvm/scripts/gvm"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/tyro/.sdkman"
[[ -s "/home/tyro/.sdkman/bin/sdkman-init.sh" ]] && source "/home/tyro/.sdkman/bin/sdkman-init.sh"
