#!/bin/bash

#set -x
wget https://github.com/drinchev/phook/archive/v0.0.7.tar.gz
tar xvzf v0.0.7.tar.gz
pushd phook-0.0.7
make install
popd
rm -rf *0.0.7*



# checkout config file from github and put them in HOME
echo "************************* downloading configuration file ************************************"
find . -type f -maxdepth 2 -mindepth 2 -name ".[^D]*" -exec ln -f {}  ~ \;
echo "************************* configuration file copied to HOME *********************************"
pushd ~


# install homebrew first
echo "************************************** installing brew **************************************"
if [[ $(uname -s) == "Darwin" ]] ; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
    test -d ~/.linuxbrew && eval $(~/.linuxbrew/bin/brew shellenv)
    test -d /home/linuxbrew/.linuxbrew && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
    test -r ~/.bashrc && echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.bashrc
fi
echo "************************************** installing brew **************************************"




# Enable native Mac OS X copy/paste
if [[ $(uname -s) == "Darwin" ]] ; then
    echo "************************* fix tmux clipboard issues ****************************************"
    cat >> ~/.tmux.conf <<EOF
set-option -g default-command "/bin/bash -c 'which reattach-to-user-namespace >/dev/null \
    && exec reattach-to-user-namespace $SHELL -l || exec $SHELL -l'"
bind -Tcopy-mode-vi y send -X copy-pipe "reattach-to-user-namespace pbcopy"
EOF
fi

echo "************************* installing development tools **************************************"
brew update

brew install vim
brew install git
brew install maven
brew install tmux
brew install wget
brew install neovim
brew install sshrc
brew install tree
brew install coreutils
brew install bat
brew install ag
brew install diff-so-fancy
brew install jq
brew install mosh
brew install cheat
brew install tldr
brew install fzf
brew install autojump
brew install httpie

brew install source-highlight
brew install bash-completion


if [[ $(uname -s) == "Darwin" ]] ; then
  # Mac OS only
  brew install reattach-to-user-namespace
  brew cask install iterm2
  brew cask install gitx
  brew cask install cheatsheet
  brew cask install alfred
  brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json qlimagesize webpquicklook suspicious-package qlvideo
  brew cask install visual-studio-code
  brew cask install intellij-idea-ce
  brew cask install postman
  brew cask install visualvm
  brew cask install mark-text
  brew cask install docker
  brew cask install jupyter-notebook-viewer
else
  #Linux OS only
  # brew install CheckInstall network-manager-openconnect-gnome
  brew install hello
  brew install docker
fi

brew cleanup
echo "************************* development tools installed **************************************"

popd




echo "************************* installing vim plugins ********************************************"
rm -rf ~/.vim && mkdir -p ~/.vim/colors
cp vim/solarized.vim ~/.vim/colors/

command -v git >/dev/null 2>&1 || { echo >&2 "Git is not installed successfully. Aborting."; exit 1;  }
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
echo "************************* vim plugins installed *********************************************"
