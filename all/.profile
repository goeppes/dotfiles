. ~/.bashrc

export EDITOR="vim"
export LANG="en_US.UTF-8"

PATH="/usr/local/cuda-8.0/bin:$PATH"
PATH="/usr/local/go/bin:$PATH"
#PATH="$HOME/anaconda/bin:$PATH"
PATH="$HOME/bin:$PATH"
PATH="$HOME/.cargo/bin:$PATH"
export PATH

export LD_LIBRARY_PATH="/usr/local/cuda-8.0/lib64:$LD_LIBRARY_PATH"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/tyro/.sdkman"
[[ -s "/home/tyro/.sdkman/bin/sdkman-init.sh" ]] && source "/home/tyro/.sdkman/bin/sdkman-init.sh"
