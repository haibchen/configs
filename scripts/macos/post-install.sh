#!/bin/bash

if [[ $(uname -s) != "Darwin" ]] ; then
    echo "Unexpected environment: " $(uname -s)
    exit
fi


# Enable native Mac OS X copy/paste from/to tmux. See https://blog.d46.us/zsh-tmux-emacs-copy-paste/
echo "************************* fixing tmux clipboard issues **************************************"
cat >> ~/.config/tmux/tmux.conf <<EOF
set-option -g default-command "reattach-to-user-namespace -l zsh"
EOF
echo "************************* fixed tmux clipboard issues **************************************"
