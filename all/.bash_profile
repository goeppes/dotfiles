. ~/.bashrc

export GPG_TTY=$(tty)

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/tyro/.sdkman"
[[ -s "/home/tyro/.sdkman/bin/sdkman-init.sh" ]] && source "/home/tyro/.sdkman/bin/sdkman-init.sh"
