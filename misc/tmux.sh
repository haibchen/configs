#!/bin/bash

# create a session for hadoop trunk development
session=apache
tmux has-session -t $session
if [ $? != 0 ]; then
  tmux new-session -s $session -n git -d

  tmux send-keys -t $session:git 'cd ~/Documents/OpenSource/apache/hadoop && clear' C-m

  tmux new-window -n mvn -t $session
  tmux send-keys -t $session:mvn 'cd ~/Documents/OpenSource/apache/hadoop && clear' C-m

  tmux new-window -n cluster -t $session
  tmux send-keys -t $session:cluster 'cd ~/Documents/OpenSource/apache/hadoop-cluster && clear' C-m

  tmux select-window -t $session:git
fi

tmux attach -t $session

tmux source-file ~/.tmux.conf
