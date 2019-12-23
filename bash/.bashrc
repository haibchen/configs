export PATH=/usr/local/bin:$PATH


#*********************************** Bash Prompt ***********************************************
if [[ $(uname -s) == "Darwin" ]] ; then
    # Append a notification when a command finishes and if the terminal is not on focus.
    function f_notifyme {
        LAST_EXIT_CODE=$?
        CMD=$(fc -ln -1)
        # No point in waiting for the command to complete
        osascript ~/.bash/notif.scpt "$CMD" "$LAST_EXIT_CODE" &
    }
    export PS1='$(f_notifyme)'$PS1
fi
#*********************************** Bash Prompt ***********************************************






#********************************* BASH HISTORY ************************************************
export HISTFILESIZE=10000 # Record last 10,000 commands
export HISTSIZE=10000 # Record last 10,000 commands per session

function histgrep {
  local n_lines=10
  if [[ "$1" =~ ^[0-9]*$ ]]; then
    n_lines="$1"
    shift
  fi
  grep "$@" ~/.bash/.full_history | tail -n "$n_lines"
}


function frequency {
  cat ~/.bash_history | perl ~/.bash/frequency.pl | sort -rn
}


# right before prompting for the next command, save the previous
# command in a file.
promptFunc() {
echo "$(date +%Y-%m-%d--%H-%M-%S) $(hostname) $PWD $(history 1)" \
  >> ~/.bash/.full_history
}

PROMPT_COMMAND=promptFunc


# Append to the history file, don't overwrite it
shopt -s histappend

# Save multi-line commands as one command
shopt -s cmdhist

# Don't record some commands
export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:clear:pwd"

# Use standard ISO 8601 timestamp
# %F equivalent to %Y-%m-%d
# %T equivalent to %H:%M:%S (24-hours format)
HISTTIMEFORMAT='%F %T '
#********************************* BASH HISTORY ************************************************




## GENERAL OPTIONS ##

# Update window size after every command
shopt -s checkwinsize

# Automatically trim long paths in the prompt (requires Bash 4.x)
PROMPT_DIRTRIM=3

# Turn on recursive globbing (enables ** to recurse all directories)
shopt -s globstar 2> /dev/null

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;


if [ -t 1 ]
then
    ## SMARTER TAB-COMPLETION (Readline bindings) ##

    # Enable history expansion with space
    # E.g. typing !!<space> will replace the !! with your last command
    bind Space:magic-space

    # Perform file completion in a case insensitive fashion
    bind "set completion-ignore-case on"

    # Treat hyphens and underscores as equivalent
    bind "set completion-map-case on"

    # Display matches for ambiguous patterns at first tab press
    bind "set show-all-if-ambiguous on"

    # Immediately add a trailing slash when autocompleting symlinks to directories
    bind "set mark-symlinked-directories on"

    # Enable incremental history search with up/down arrows (also Readline goodness)
    # Learn more about this here: http://codeinthehole.com/writing/the-most-important-command-line-tip-incremental-history-searching-with-inputrc/
    bind '"\e[A": history-search-backward'
    bind '"\e[B": history-search-forward'
    bind '"\e[C": forward-char'
    bind '"\e[D": backward-char'
fi

## BETTER DIRECTORY NAVIGATION ##

# Prepend cd to directory names automatically
shopt -s autocd 2> /dev/null
# Correct spelling errors during tab-completion
shopt -s dirspell 2> /dev/null
# Correct spelling errors in arguments supplied to cd
shopt -s cdspell 2> /dev/null

# This defines where cd looks for targets
# Add the directories you want to have fast access to, separated by colon
# Ex: CDPATH=".:~:~/projects" will look for targets in the current working directory, in home and in the ~/projects folder
CDPATH="."

# This allows you to bookmark your favorite places across the file system
# Define a variable containing a path and you will be able to cd into it regardless of the directory you're in
shopt -s cdable_vars






#********************************** miscellneous settings **************************************
# source bash-completion script
# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

# Append to the Bash history file, rather than overwriting it
shopt -s histappend;

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
	shopt -s "$option" 2> /dev/null;
done;

# Add tab completion for many Bash commands
# if which brew &> /dev/null && [ -f $(brew --prefix)/etc/bash_completion ]; then
if [ -f $(brew --prefix)/etc/bash_completion ]; then
    source $(brew --prefix)/etc/bash_completion
elif [ -f /etc/bash_completion ]; then
	source /etc/bash_completion;
fi;

# Enable tab completion for `g` by marking it as an alias for `git`
if type _git &> /dev/null; then
	complete -o default -o nospace -F _git g;
fi;

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh;

# source other profiles
for file in ~/.bash/{bash_alias,bash_func,bash_prompt}; do
    [ -r "$file"  ] && [ -f "$file"  ] && source "$file";
done;
unset file;

# uncomment to enable powerline-style bash prompt
# source ~/.bash_powerline.sh



# enable vi mode in bash
set -o vi
export EDITOR='vim';
export LANG='en_US.UTF-8';
#********************************** miscellneous settings **************************************





#****************************************** Coloring *******************************************
# Detect which `ls` flavor is in use
if ls --color > /dev/null 2>&1; then # GNU `ls`
    colorflag="--color"
else # OS X `ls`
    colorflag="-G"
fi

# ls syntax highting See  https://www.vpsee.com/2013/09/use-the-solarized-color-theme-on-mac-os-x-terminal/
export CLICOLOR=1

# Enable syntax-highlighting in less assuming brew install source-highlight is done
LESSPIPE=`which src-hilite-lesspipe.sh`
export LESSOPEN="| ${LESSPIPE} %s"
export LESS=' -R '


# Or using the less emulation of vim
alias lessc=/usr/share/vim/vim80/macros/less.sh


if [[ $COLORTERM = gnome-* && $TERM = xterm  ]] && infocmp gnome-256color >/dev/null 2>&1; then
    export TERM='gnome-256color';
elif infocmp xterm-256color >/dev/null 2>&1; then
    export TERM='xterm-256color';
fi;
#****************************************** Coloring *******************************************






#*****************************************  Alias **********************************************
alias less='less -m -N -g -i -J --underline-special --SILENT'
alias more='lessc'
alias cat='bat'
alias rm="rm -i"
alias ls='ls ${colorflag}'
alias ll="ls -la"
alias gs="git status"
alias grep='grep -n --color=auto'
alias tmux="tmux -2"
alias mvn-pkg='mvn clean package -Pdist -Dtar -Dmaven.javadoc.skip=true -DskipTests'
alias mvn-clean='mvn clean'
alias mvn-install='mvn clean install -DskipTests'
#*****************************************  Alias **********************************************








#***************************************** Tmux ************************************************
# enable 256-color terminal on Linux
[ -z "$TMUX" ] && export TERM=xterm-256color

peek() { tmux split-window -p 33 $EDITOR $@ || exit;  }
#***************************************** Tmux ************************************************













#************************************* Hadoop Development **************************************
export MAVEN_OPTS="-Xmx2048m -XX:MaxPermSize=1024m"

# Fix for stupid Java bug that was causing all java processes to make a dock icon and steal focus
# (the second answer)
# http://stackoverflow.com/questions/10627405/how-to-set-java-system-properties-globally-on-os-x
export _JAVA_OPTIONS=-Djava.awt.headless=true

export CFLAGS=-Qunused-arguments

if [[ $(uname -s) == "Darwin" ]] ; then
    export JAVA_HOME=`/usr/libexec/java_home -v 1.8`

    java7() {
        export JAVA_HOME=`/usr/libexec/java_home -v 1.7` && `java -version`
    }
    java8() {
        export JAVA_HOME=`/usr/libexec/java_home -v 1.8` && `java -version`
    }
fi

#************************************* Hadoop Development **************************************




# For operating systems where the default shell cannot be changed to zsh
# https://github.com/robbyrussell/oh-my-zsh/issues/5401#issuecomment-250828518
if [[ $- == *i* ]]; then
    export SHELL=/usr/bin/zsh
    exec /usr/bin/zsh -l
fi
