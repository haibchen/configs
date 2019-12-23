#! /bin/bash

if [[ $(uname -s) == "Darwin" ]] ; then
    echo "Unexpected environment: " $(uname -s)
    exit
fi


bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel 'xclip -in -selection clipboard'

echo "************************* fixing tmux clipboard issues **************************************"
sudo yum install -y xclip
cat >> ~/.tmux.conf <<EOF
bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel 'xclip -in -selection clipboard'
EOF
echo "************************* fixed tmux clipboard issues **************************************"



