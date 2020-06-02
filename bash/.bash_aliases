# global aliases (OS independent)

# use 256 colors in tmux
# https://unix.stackexchange.com/questions/1045/getting-256-colors-to-work-in-tmux#
alias tmux='tmux -2'
alias ll='ls -lA'
alias lo='ls -o'	# without group information
alias lr='ls -lrt'
alias ..='cd ..'
alias ...='cd ../..'

# git abbreviations
alias gg='git graph'

# gradle abbreviations
list_gradle_dists() {
    echo "== Gradle Wrapper dists =="
    ls -l /cygdrive/c/Users/$(whoami)/.gradle/wrapper/dists/
}
alias g-dists='list_gradle_dists'

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
