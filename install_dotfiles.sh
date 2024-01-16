#!/bin/bash


mkdir -p ~/.config/
ln -sf dotfiles/zsh/.zshenv ~/.zshenv 

cp -R dotfiles ~/.config
