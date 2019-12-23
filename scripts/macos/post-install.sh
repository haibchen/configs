#!/bin/bash

if [[ $(uname -s) != "Darwin" ]] ; then
    echo "Unexpected environment: " $(uname -s)
    exit
fi


# Enable native Mac OS X copy/paste from/to tmux. See https://blog.d46.us/zsh-tmux-emacs-copy-paste/
echo "************************* fixing tmux clipboard issues **************************************"
cat >> ~/.tmux.conf <<EOF
set-option -g default-command "reattach-to-user-namespace -l zsh"
EOF
echo "************************* fixed tmux clipboard issues **************************************"






# https://antistatique.net/en/we/blog/2016/08/03/macos-trigger-notification-center-when-long-running-commands-finishes
sudo cp scripts/macos/notifyme /usr/local/bin/notifyme

cat >> ~/.zshrc <<EOF
function f_notifyme {
  LAST_EXIT_CODE=$?
  CMD=$(fc -ln -1)
  # No point in waiting for the command to complete
  notifyme "$CMD" "$LAST_EXIT_CODE" &
}

export PS1='$(f_notifyme)'$PS1
EOF
