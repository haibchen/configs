#! /bin/bash

if [[ $(uname -s) == "Darwin" ]] ; then
    echo "Unexpected environment: " $(uname -s)
    exit
fi

sudo yum install -y zsh
sudo yum install -y tmux
sudo yum install -y git
sudo yum install -y vim
sudo yum install -y wget

sudo yum install -y neovim
sudo yum install -y tree
sudo yum install -y jq
sudo yum install -y source-highlight
sudo yum install -y mosh
sudo yum install -y docker-ce

# install fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# install ag (or the silver searcher)
sudo yum install -y epel-release.noarch
sudo yum install -y the_silver_searcher
