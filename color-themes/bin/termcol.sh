#!/bin/bash

baseDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"


schemeDir=~/.bashdot-color-schemesx
if [ ! -d $schemeDir ]; then
    if [ -d $baseDir/../.bashdot-color-schemes ]; then 
        schemeDir=$baseDir/../.bashdot-color-schemes
    elif [ -d $baseDir/../bashdot-color-schemes ]; then
        schemeDir=$baseDir/../bashdot-color-schemes 
    else 
        echo "no scheme dir found!"
        exit 1
    fi
fi

echo $schemeDir
command=${1:-list}

function listSchemes {
    echo "Available schemes: "
    for entry in "$schemeDir"/*
    do
        local scheme=$(echo $(basename $entry | sed -e 's/.scheme.sh//'))
        echo "  - $scheme"
    done
}

function setScheme {
    local schemeName=${1:?missing scheme name}
    local schemeFile="$schemeDir/$schemeName.scheme.sh"
    if [ -f "$schemeFile" ]; then
        source $schemeFile
    else
        echo "File not found: $schemeFile"
    fi
}

case $command in 
    list)
        listSchemes
        ;;
    *)
        setScheme $1
esac

