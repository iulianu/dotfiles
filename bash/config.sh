[ -f ~/.travis/travis.sh ] && source ~/.travis/travis.sh

rvm_activate() {
    [ -f ~/.rvm/scripts/rvm ] && source ~/.rvm/scripts/rvm
    export PATH=$PATH:$HOME/.rvm/bin
}

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

#OS=linux
#if [[ `uname` -eq "Darwin" ]]; then
#    OS=mac
#fi
#
#
## check the window size after each command and, if necessary,
## update the values of LINES and COLUMNS.
#shopt -s checkwinsize

## macOS El Capitan and later has its own way of
## dealing with Bash history.
#if [[ $OS -ne mac ]]; then
#    # don't put duplicate xines in the history. See bash(1) for more options
#    # ... or force ignoredups and ignorespace
#    HISTCONTROL=ignoredups:ignorespace
#
#    # append to the history file, don't overwrite it
#    shopt -s histappend
#
#    # for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
#    HISTSIZE=1000
#    HISTFILESIZE=2000
#fi

