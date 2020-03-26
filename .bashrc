# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

export LANG=en_GB.UTF-8
export LANGUAGE=en_GB.UTF-8

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

### GIT

source $HOME/.git-prompt.sh
GIT_PS1_SHOWCOLORHINTS=true
GIT_PS1_SHOWDIRTYSTATE=true
PROMPT_COMMAND='__git_ps1 "${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]" "\\\$ "'


# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ ! "$color_prompt" = yes ]; then
#    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]$(get_git_branch) \$ '
#else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi

unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


## General
export DEV_PREFIX=$HOME/dev
export PATH=$HOME/.local/bin:$DEV_PREFIX/bin:$PATH
export PYTHONPATH=$DEV_PREFIX/lib/python2.7/site-packages:$DEV_PREFIX/lib/python3/site-packages:$PYTHONPATH
export LD_LIBRARY_PATH=$DEV_PREFIX/lib:/usr/local/lib:$LD_LIBRARY_PATH
export PKG_CONFIG_PATH=$DEV_PREFIX/lib/pkgconfig

function setpy3 {
    export PYTHONPATH=$DEV_PREFIX/lib/python3.6/site-packages:$DEV_PREFIX/lib/python3/site-packages:$DEV_PREFIX/lib/python3.6/dist-packages:$DEV_PREFIX/lib/python3/dist-packages
}

function ccat {
    if file $1 | grep -q image
    then
        shellpic --shell24 $1
    else
        pygmentize -O style=monokai -f terminal256 -g $1
    fi
}

alias cddev='cd $HOME/src'

export LANG=en_GB.utf8

# help bash remembering my passphrase
eval `gnome-keyring-daemon --start`

## Debian packaging
DEBEMAIL="severin@guakamole.org"
DEBFULLNAME="Séverin Lemaignan"
export DEBEMAIL DEBFULLNAME
alias dquilt="quilt --quiltrc=${HOME}/.quiltrc-dpkg"
complete -F _quilt_completion $_quilt_complete_opt dquilt



## HIDPI for Qt
export QT_DEVICE_PIXEL_RATIO=auto

### ROS

#export ROS_BASE=/opt/ros/jade
#export ROS_BASE=/opt/ros/kinetic
export ROS_BASE=/opt/ros/melodic

if [ -d $ROS_BASE ];
then
    export ROS_DEV=$HOME/dev
    source $ROS_BASE/setup.bash

    export ROS_PACKAGE_PATH=$ROS_DEV/share:$ROS_DEV/stacks:$ROS_PACKAGE_PATH

    export PATH=$ROS_DEV/bin:$PATH
    export LD_LIBRARY_PATH=$ROS_DEV/lib:$ROS_DEV/lib/x86_64-linux-gnu:$LD_LIBRARY_PATH
    export PKG_CONFIG_PATH=$ROS_DEV/lib/pkgconfig:$ROS_DEV/lib/x86_64-linux-gnu/pkgconfig:$PKG_CONFIG_PATH
    export PYTHONPATH=$ROS_DEV/lib/python2.7/dist-packages:$PYTHONPATH
    # seems important for ros to find the executable (ie, when trying rosrun PACKAGE EXECUTABLE for instance). wtf...
    export CMAKE_PREFIX_PATH=$ROS_DEV:$CMAKE_PREFIX_PATH
fi


## Cabal/Haskell
export PATH=$HOME/.cabal/bin:$PATH


## Android

export ANDROID_ROOT=$HOME/applis/android
export PATH=$ANDROID_ROOT/tools:$ANDROID_ROOT/platform-tools:$PATH


# Nao
export NAO_IP=192.168.2.101
export PYTHONPATH=$HOME/applis/nao/pynaoqi-python2.7-2.1.4.13-linux64:$PYTHONPATH

# Attention! The import order between naoqi-sdk and pynaoqi is important! Otherwise, import error when calling 'import naoqi' from Python
# with missing libicuuc.so.52
#export LD_LIBRARY_PATH=$HOME/applis/nao/naoqi-sdk-2.1.4.13-linux64/lib:$HOME/applis/nao/pynaoqi-python2.7-2.1.4.13-linux64:$LD_LIBRARY_PATH

# MORSE
alias morse='morse -c'

# CUDA
# installed CUDA 8 from Ubuntu packages
# cudnn: downloaded from Nvidia https://developer.nvidia.com/rdp/cudnn-download, then:
export CUDA_HOME=$HOME/applis/cudnn-6
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CUDA_HOME/lib64

## Bazel (google build tool)
#export PATH=$PATH:$HOME/.bazel/bin
#source $HOME/.bazel/bin/bazel-complete.bash

## GRPC

# makes GRPC less verbose
export GRPC_VERBOSITY=ERROR
export LD_LIBRARY_PATH=/usr/local/cuda-8.0/lib64:$LD_LIBRARY_PATH
export PATH=/usr/local/cuda-8.0/bin:$PATH

export NVM_DIR="/home/slemaignan/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

