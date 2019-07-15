#!/usr/bin/env sh

# This is a setup script for new personal desktop machines running Ubuntu 18.04.

set -eu

# if dual-booting windows, use local time
timedatectl set-local-rtc 1

sudo add-apt-repository ppa:nilarimogard/webupd8 # mcomix

# development tools
sudo apt install git vim neovim stow rxvt-unicode-256color python3-pip
sudo apt install mcomix

# fun stuff
sudo apt install anki mpv ffmpeg ffmpeg-thumbnailer neofetch weechat \
  lftp mediainfo transmission-cli minidlna rofi mpd ncmpcpp torbrowser-launcher

# extra stuff from snapcraft
sudo snap install brave gimp intellij-idea-{community,ultimate}

# fonts
# - siji
# - tamzen

# language support
# - japanese (mozc)
# - korean

# need to manually install:
# - google-chrome
# - ooogle-musicmanager
# - firefox
# - calibre
# - i3-gaps
# - polybar
# - go (language)
# - rustup
#   - rust (nightly)
# - sdkman
#   - java
#   - scala
#   - leiningen
#   - gradle
#   - maven

# setup ssh server
# https://dev.to/zduey/how-to-set-up-an-ssh-server-on-a-home-computer

# install noip2 duc
