# global aliases (OS independent)
alias ll='ls -lA'
alias lo='ls -o'	# without group information
alias lr='ls -lrt'
alias ..='cd ..'
alias ...='cd ../..'

# https://ben.lobaugh.net/blog/203195/quickly-list-all-hosts-in-your-ssh-config
# alias sshhosts="grep -w -i "Host" ~/.ssh/config | sed 's/Host//'"
alias ssh-hosts="ssh-list-aliases.sh"

#
# extensions inspired by http://crunchbang.org/forums/viewtopic.php?id=1093
#

find_alias() {
    local pattern=$1
    echo "$(alias | grep "$1")"
}
alias find-alias="find_alias $1"

alias calendar='cal -ymw'
