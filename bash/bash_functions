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

