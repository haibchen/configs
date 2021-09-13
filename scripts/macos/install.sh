#!/bin/bash

#set -x

if [[ $(uname -s) != "Darwin" ]] ; then
    echo "Unexpected environment: " $(uname -s)
    exit
fi


pushd ~

# install homebrew first
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"




echo "************************* installing development tools ***********************************"
brew update

brew install zsh
brew install tmux
brew install git
brew install diff-so-fancy
brew install vim
brew install neovim
brew install reattach-to-user-namespace
brew install wget
brew install tree
brew install jq
brew install fzf
brew install ag       #grep alternative
brew install tldr      #man alternative
brew install source-highlight
brew install fpp
brew install cloc


brew install gradle
brew install maven

brew install sshrc #ssh with local conf
brew install bat
brew install mosh      #ssh alternative
brew install cheat
brew install httpie   #curl alternative


# https://www.drinchev.com/blog/ssh-and-terminal-background/ & phook
brew tap thefox/brewery

brew install the-unarchiver
brew install vlc
brew install adobe-reader
brew install firefox
brew install alfred
brew install visual-studio-code
brew install typora

brew install iterm2
brew install docker

brew install postman
brew install cheatsheet

# with BTracer and Thread Dump Analyzer
brew install visualvm
brew install mat
# intellij with the ideavim plugin
brew install intellij-idea-ce
brew install jd-gui
brew install jupyter-notebook-viewer


brew cask install qlcolorcode qlstephen \
    qlmarkdown  quicklook-json qlimagesize \
    webpquicklook suspicious-package qlvideo
brew install wechat
brew install xmind
brew install caffeine
brew install selfcontrol
brew install karabiner-elements
brew install keyboard-maestro


## Additional personal apps
# brew cask install gimp utorrent
# Renren Yingshi Pro

brew cleanup



xcode-select —-install
echo "************************* development tools installed **************************************"

popd
