################################################################################
#
#  EXPORTS
#
################################################################################

# fixes screen size when using chrome remote desktop on chromebook.
export CHROME_REMOTE_DESKTOP_DEFAULT_DESKTOP_SIZES="1920x1080"

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

################################################################################
#
#  PATH MANAGEMENT
#
################################################################################

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
  PATH="$HOME/bin:$PATH"
fi

# add rust programs to path
if [ -d "$HOME/.cargo/bin" ]; then
  PATH="$PATH:$HOME/.cargo/bin"
fi

# include .bashrc if it exists
if [ -f "$HOME/.bashrc" ]; then
  . "$HOME/.bashrc"
fi

