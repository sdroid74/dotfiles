#
# Bash functions
# inspired by http://crunchbang.org/forums/viewtopic.php?id1093
#

 # Logging functions
 log() {
     TS=$(date +"%Y-%m-%d %H:%m:%S")
     COLOR=$1
     LEVEL=$2
     shift
     shift

     LABEL=$(printf "%s" $COLOR)
     printf "$LABEL$@ \e[0m\n"
#     if [ -f "${RPMLOGDIR}/${RPM_PACKAGE_NAME}" ]; then
#         echo "$TS [$LEVEL] $@" >> "${RPMLOGDIR}/${RPM_PACKAGE_NAME}"
#     fi
 }
 log_info() {
     # echo -e "\e[32m[INFO ] $@ \e[0m"
     log "\e[32m" "INFO" "$@"
     # echo "[INFO ]:$@" >> "${RPMLOGDIR}/${RPM_PACKAGE_NAME}"
 }
 log_warn() {
     log "\e[1m\e[33m" "WARN" "$@"
     # echo "WARN:$@" >> "${RPMLOGDIR}/${RPM_PACKAGE_NAME}"
 }
 log_error() {
     log "\e[31m" "ERROR" "$@"
     # echo "ERROR:$@" >> "${RPMLOGDIR}/${RPM_PACKAGE_NAME}"
 }

function printBullet {
    printf " \e[31m☆\e[32m $1 \e[0m\n"
}


# Get IP (call with myip)
function myip {
    myip=`lynx -dump http://checkip.dyndns.org:8245/`
    log_info "${myip}"
}

#
# WIP: Git prompt
#

function parse_git_branch {
    # echo -n $(git branch --no-color 2>/dev/null | awk -v out=$1 '/^*/ { if(out=="") print $2; else print out}')

    git_branch="$(git branch 2> /dev/null | grep -e ^* | sed -E  s/^\\\*\ \(.+\)$/\(\ \\\1\)\ /)"
    if [ -z "$git_branch" ];
    then
        git_branch="(no git branch) "
    else
        local git_dir="$(git rev-parse --git-dir)"
        if [ -f $git_dir/logs/refs/stash ];
        then
            local git_stash="$(wc -l $git_dir/logs/refs/stash | sed -E 's/^([0-9]+).*/\1/')"
        else
            local git_stash="0"
        fi
        if [ $git_stash -gt 0 ];
        then
            git_branch=$(echo $git_branch | sed -E "s/^(.*)\)$/\1\|stash:${git_stash}\)/")
        fi
    fi
    echo -n -e "$git_branch"
}

# fast version form https://stackoverflow.com/questions/4485059/git-bash-is-extremely-slow-on-windows-7-x64
fast_git_ps1 ()
{
    printf -- "$(git branch 2>/dev/null | sed -ne '/^\* / s/^\* \(.*\)/ [\1] / p')"
}

function color_status {
    local EXIT="$?"
    if [ $EXIT != 0 ]; then
        status_code="${red}($EXIT)${nc}"
    else
        status_code="${green}($EXIT)${nc}"
    fi
    echo -n -e "$status_code"
}

# example from http://stackoverflow.com/questions/4133904/ps1-line-with-git-current-branch-and-colors
function color_my_prompt {
    local __user_and_host="\[\033[01;32m\]\u@\h"
    local __cur_location="\[\033[01;34m\]\w"
    local __git_branch_color="\[\033[31m\]"
    #local __git_branch="\`ruby -e \"print (%x{git branch 2> /dev/null}.grep(/^\*/).first || '').gsub(/^\* (.+)$/, '(\1) ')\"\`"
    local __git_branch='`git branch 2> /dev/null | grep -e ^* | sed -E  s/^\\\\\*\ \(.+\)$/\(\\\\\1\)\ /`'
    local __prompt_tail="\[\033[35m\]$"
    local __last_color="\[\033[00m\]"
    export PS1="$__user_and_host $__cur_location $__git_branch_color$__git_branch$__prompt_tail$__last_color "
}
# color_my_prompt
#
#


# find text in file using 'find <file_pattern> -exec grep -H <pattern> {} \;'
find-grep() {
    if [[ $# -lt 2 ]]; then 
        echo "Usage: find-grep file-pattern search-pattern"
    else
        local filepattern=$1
        local pattern=$2

        find . -type f -name $filepattern -exec grep -H $pattern {} \;
    fi
}

# Stopwatch / Countdown 
# Found on Superuser: https://superuser.com/questions/611538/is-there-a-way-to-display-a-countdown-or-stopwatch-timer-in-a-terminal#
function countdown(){
   local balloonBase=$(cygpath -w "/cygdrive/c/cygwin64/home/sgaiselm/dotfiles/util") # TODO: user name is not cool
   local balloonIcon=$(cygpath -w "$balloonBase/folder.ico")
   local balloonScript=$(cygpath -w "$balloonBase/bin/balloon.ps1")
   local min=$(($1*60))
   echo "Balloon script: $balloonScript"
   date1=$((`date +%s` + $min)); 
   while [ "$date1" -ge `date +%s` ]; do 
     echo -ne "$(date -u --date @$(($date1 - `date +%s`)) +%H:%M:%S)\r";
     sleep 0.8
   done
   if [ -f $HOME/tada.mp3 ]; then
       madplay "$HOME/tada.mp3"
   fi
    
   echo "\n" | powershell -F "$balloonScript" "$balloonIcon" "Tea" "$1"
}
function stopwatch(){
  date1=`date +%s`; 
   while true; do 
    echo -ne "$(date -u --date @$((`date +%s` - $date1)) +%H:%M:%S)\r"; 
    sleep 0.1
   done
}
countdownWithDays(){
    date1=$((`date +%s` + $1));
    while [ "$date1" -ge `date +%s` ]; do 
    ## Is this more than 24h away?
    days=$(($(($(( $date1 - $(date +%s))) * 1 ))/86400))
    echo -ne "$days day(s) and $(date -u --date @$(($date1 - `date +%s`)) +%H:%M:%S)\r"; 
    sleep 0.1
    done
}
stopwatchWithDays(){
    date1=`date +%s`; 
    while true; do 
    days=$(( $(($(date +%s) - date1)) / 86400 ))
    echo -ne "$days day(s) and $(date -u --date @$((`date +%s` - $date1)) +%H:%M:%S)\r";
    sleep 1
    done
}

#
# bash speed tests to check cygwin performance.
# https://stackoverflow.com/questions/6811435/why-does-cygwin-execute-shell-commands-very-slowly
# 
speed() {
    time for i in {1..10} ; do bash -c "echo hello"; done
}

# 
# use 'find' to list file content matching a regex
#
f() {
    local option=${1:-}
    local name=$2

    
    case $option  in 
        grep)
            local pattern=${3:?pattern is required}
            echo "find . -name $name -type f -exec grep -H $pattern {} \;"
            ;;
        *) 
            echo "find . -name '$name' -ls"
            $(find . -name "'${name:?is required}'" -ls)
    esac
}
# 
# 
#
s_X() {
if [ -z "$1" ]; then
  echo '' && echo 'Please also provide server name as in config file...'
else
  retries=0
  repeat=true
  today=$(date)

  while "$repeat"; do
    ((retries+=1)) &&
    echo "Try number $retries..." &&
    today=$(date) &&
    ssh "$@" &&
    repeat=false
    if "$repeat"; then
      sleep 5
    fi
  done

  echo "Total number of tries: $retries"
  echo "Last connection at: $today"
fi
}

# See https://superuser.com/questions/249293/rename-tmux-window-name-to-prompt-command-ps1-or-remote-ssh-hostname
settitle() {
    printf "\033k$1\033\\"
}

# Customized SSH command
s() {
    local SSH_HOME=/home/arsystem/HOME/sgaisel
    local target=${1:?missing target system}
    local tmuxTitle=$(tmux display-message -p '#W')

    # TODO: Unterscheidung Materna, CISM, etc...
    ssh -t $target "cd ${SSH_HOME}; bash --rcfile ${SSH_HOME}/.sshrc"

    solarize dark
    if [[ "$TERM" =~ "screen".* ]]; then
        echo "Welcome back to $tmuxTitle"
        settitle "$tmuxTitle"
    else
        echo "Welcome back to $(uname -n)"
    fi
}

# Show JAR Manifest
showManifest() {
    local myJar=${1:?jar/zip file is required}
    unzip -p $myJar META-INF/MANIFEST.MF
}
