# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# Don't put duplicate lines in the history.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups

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

# OS detection
case "$OSTYPE" in 
    darwin*)
	    printBullet "you are on OS X"
	    sourceFile .bashrc_osx
	    ;;
    linux*)
	    printBullet "you are on $OSTYPE (Linux)"
	    sourceFile .bash_linux
	    ;;
    *)
            printBullet "you are on $OSTYPE"
	    ;;
esac

# Add $HOME/bin to PATH
PATH=$PATH:~/bin;export PATH


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
    export PS1="\[\e]0;\]\u@\h\a \D{%F %T} ${ps_red}☆ ${ps_purple}\u@\h ${ps_nc} in ${ps_green} \w \n${ps_green} on \$(parse_git_branch) →${ps_nc} "
    printBullet "using default PS1"
fi
