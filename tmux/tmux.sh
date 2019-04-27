#!/bin/bash

# create a session for hadoop trunk development
session=apache-hadoop
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



# create a session for tony development
session=tony
tmux has-session -t $session
if [ $? != 0 ]; then
  tmux new-session -s $session -n git -d

  tmux send-keys -t $session:git 'cd ~/Documents/OpenSource/linkedin/tony && clear' C-m

  tmux new-window -n mvn -t $session
  tmux send-keys -t $session:mvn 'cd ~/Documents/OpenSource/linkedin/tony && clear' C-m

  tmux new-window -n mp -t $session
  tmux send-keys -t $session:mp 'cd  ~/Documents/Linkedin/tony/tony-mp/ && clear' C-m
   # noop for cmd window

  tmux select-window -t $session:git
fi




# create a session for li hadoop fork development
session=li-hadoop
tmux has-session -t $session
if [ $? != 0 ]; then
  tmux new-session -s $session -n git -d

  tmux send-keys -t $session:git 'cd ~/Documents/Linkedin/hadoop/li-hadoop && clear' C-m

  tmux new-window -n mvn -t $session
  tmux send-keys -t $session:mvn 'cd ~/Documents/Linkedin/hadoop/li-hadoop && clear' C-m

  tmux new-window -n li-cluster -t $session
  tmux send-keys -t $session:li-cluster 'cd ~/Documents/Linkedin/hadoop/li-hadoop-cluster && clear' C-m

  tmux select-window -t $session:git
fi




tmux attach -t $session

tmux source-file ~/.tmux.conf
