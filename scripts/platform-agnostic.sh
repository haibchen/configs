#!/bin/bash





# checkout config file from github and put them in HOME
echo "************************* downloading configuration file ************************************"
rm -rf  ~/.config
cp -r config ~/.config
cp -r config/vim ~/.vim
echo "************************* configuration file copied to HOME *********************************"





# customize the location of .zshrc to ~/.config/zsh
cat >> ~/.zshenv <<EOF
ZDOTDIR=$HOME/.config/zsh
EOF

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
chsh -s `which zsh`
# enable fzf for zsh
which fzf && /usr/local/opt/fzf/install




echo "************************* installing vim plugins ********************************************"
command -v git >/dev/null 2>&1 || { echo >&2 "Git is not installed successfully. Aborting."; exit 1;  }
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
echo "************************* vim plugins installed *********************************************"



# set up copying into the local clipboard from tmux/vim running remotely over ssh
sudo mv scripts/yank /usr/local/bin
