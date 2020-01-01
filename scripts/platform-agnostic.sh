#!/bin/bash



# checkout config file from github and put them in HOME
echo "************************* downloading configuration file ************************************"
#find . -type f -maxdepth 2 -mindepth 2 -name ".[^D]*" -exec ln -f {}  ~ \;
find . -mindepth 2 -name '.*' -exec ln {} ~ \;
echo "************************* configuration file copied to HOME *********************************"






sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
chsh -s `which zsh`
# enable fzf for zsh
which fzf && /usr/local/opt/fzf/install






echo "************************* installing vim plugins ********************************************"
rm -rf ~/.vim && mkdir -p ~/.vim/colors
cp vim/solarized.vim ~/.vim/colors/

command -v git >/dev/null 2>&1 || { echo >&2 "Git is not installed successfully. Aborting."; exit 1;  }
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
echo "************************* vim plugins installed *********************************************"





echo "************************* installing vscode extensions **************************************"
./scripts/vscode/extension-install.sh
echo "************************* vscode extensions installed  **************************************"




# set up copying into the local clipboard from tmux/vim running remotely over ssh
sudo mv scripts/yank /usr/local/bin
