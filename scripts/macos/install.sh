#!/bin/bash

#set -x

if [[ $(uname -s) != "Darwin" ]] ; then
    echo "Unexpected environment: " $(uname -s)
    exit
fi


pushd ~


echo "************************* installing development tools ***********************************"
brew update

brew install zsh
brew install tmux
brew install git
brew install diff-so-fancy
brew install neovim
brew install reattach-to-user-namespace
brew install wget
brew install tree
brew install jq
brew install fzf
brew install ag       #grep alternative
brew install rg       #grep alternative
brew install autojump
brew install tldr     #man alternative
brew install fpp      #path picker
brew install cloc
brew install httpie   #curl alternative
brew install MisterTea/et/et       #ssh


# https://www.drinchev.com/blog/ssh-and-terminal-background/ & phook
brew tap thefox/brewery

brew install the-unarchiver
brew install vlc
brew install adobe-reader
brew install firefox
brew install alfred
brew install visual-studio-code
brew install docker
brew install iterm2
brew install cheatsheet

# brew install amphetamine # install manually from app store
brew install wechat
brew install selfcontrol
brew install karabiner-elements
brew install keyboard-maestro
brew install linearmouse


# with BTracer and Thread Dump Analyzer

# brew install visualvm
# brew install typora
# brew install mat
# intellij with the ideavim plugin
# brew install intellij-idea-ce
# brew install jd-gui
# brew install jupyter-notebook-viewer
# brew install xmind

# brew install gradle
# brew install maven
# brew install source-highlight
# brew install sshrc #ssh with local conf
# brew install bat
# brew install mosh      #ssh alternative
# brew install cheat

# brew install gimp utorrent # Renren Yingshi Pro


brew cleanup



xcode-select —-install
echo "************************* development tools installed **************************************"

popd


# set maximum time block for selfcontrol to 1 month
defaults write org.eyebeam.SelfControl MaxBlockLength -int 43200
