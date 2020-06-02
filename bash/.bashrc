# If not running interactively, don't do anything
# see https://stackoverflow.com/questions/12440287/scp-doesnt-work-when-echo-in-bashrc
[[ "$-" != *i* ]] && return

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# History
# Don't put duplicate lines in the history.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
export HISTTIMEFORMAT="%Y-%m-%d %H:%M:%S "

# MOTD
if [ -f "/cygdrive/e/BspSource/bin/motd" ]; then
    /cygdrive/e/BspSource/bin/motd
fi

function sourceFile { 
    local file=${1:-missing filename}
    local SOURCE_PATH=$(dirname ${BASH_SOURCE[0]})
    if [[ -f "$SOURCE_PATH/$file" ]]
    then
        source "$SOURCE_PATH/$file"
        printBullet "including $file"
    else
        echo "Not found: $SOURCE_PATH/$file"
        function printBullet {
            printf " -> using $1"
        }
    fi
}

sourceFile .bash_functions
sourceFile .bash_aliases

if [ -f ".bash_$(uname -n)" ]; then
    sourceFile .bash_$(uname -n)
else
    printBullet "NOT FOUND: $(pwd)/.bash_$(uname -n)"
fi

# OS detection
case "$OSTYPE" in 
    darwin*)
	    printBullet "you are on OS X"
	    sourceFile .bashrc_osx
	    ;;
    linux*|cygwin*)
	    printBullet "you are on $OSTYPE"
	    sourceFile .bash_linux
	    if [ -f ~/motd.sh ];then
	        ~/motd.sh
        fi
	    ;;
    *)
            printBullet "you are on $OSTYPE"
	    ;;
esac

# Add $HOME/bin and $HOME/.local/bin to PATH (if exists)
[ -d ~/bin ] && PATH=$PATH:~/bin
[ -d ~/.local/bin ] && PATH=$PATH:~/.local/bin
export PATH


# Prompt with colours and git hints

#------------------------------------------////
# Colors:
#------------------------------------------////
black='\e[0;30m'
blue='\e[0;34m'
green='\e[0;32m'
cyan='\e[0;36m'
red='\e[0;31m'
purple='\e[0;35m'
brown='\e[0;33m'
lightgray='\e[0;37m'
darkgray='\e[1;30m'
lightblue='\e[1;34m'
lightgreen='\e[1;32m'
lightcyan='\e[1;36m'
lightred='\e[1;31m'
lightpurple='\e[1;35m'
yellow='\e[1;33m'
white='\e[1;37m'
nc='\e[0m'

ps_purple="\[\e[0;35m\]"
ps_red="\[\e[0;31m\]"
ps_green="\[\e[0;32m\]"
ps_nc="\[\e[0m\]"

PS1=
printBullet "PS1: $PS1"
sourceFile .bash_prompt
if [ "PS1" == "" ]; then  
    export PS1="${ps_purple}\D{%F %T} ${ps_red}☆ ${ps_purple}\u@\h ${ps_nc} in ${ps_green} \w \n${ps_green} on \$(parse_git_branch) →${ps_nc} "
    printBullet "using default PS1"
fi


# Test from http://tldp.org/LDP/abs/html/sample-bashrc.html
# LESS man page colors (makes Man pages more readable).
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'


# increase history size (from 500)
export HISTSIZE=3000
export HISTFILESIZE=3000
# Preserves modification times, access times, and modes from the original file.
alias scp='scp -p'
