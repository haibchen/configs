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
brew install phook


brew tap caskroom/cask

brew cask install the-unarchiver
brew cask install vlc
brew cask install adobe-reader
brew cask install firefox
brew cask install slack
brew cask install alfred
brew cask install visual-studio-code
brew cast install typora

brew cask install iterm2
brew cask install docker

brew cask install postman
brew cask install cheatsheet

# with BTracer and Thread Dump Analyzer
brew cask install visualvm
bre cask install mat
# intellij with the ideavim plugin
brew cask install intellij-idea-ce
brew cask install jd-gui
brew cask install jupyter-notebook-viewer


brew cask install qlcolorcode qlstephen \
    qlmarkdown  quicklook-json qlimagesize \
    webpquicklook suspicious-package qlvideo
brew cask install wechat
brew cask install winds
brew cask install xmind
brew cask install caffeine
brew cask install pock
brew cask install selfcontrol
brew cask install karabiner-elements
brew cask install keyboard-maestro


## Additional personal apps
# brew cask install gimp utorrent
# Renren Yingshi Pro

brew cleanup



xcode-select —-install
echo "************************* development tools installed **************************************"

popd
