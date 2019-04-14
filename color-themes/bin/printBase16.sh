#!/bin/bash

colors=(black red green yellow blue magenta cyan  white)
#  BASE2 BASE03 ORANGE BASE01 BASE00 BASE0 VIOLET BASE1 BASE3)
normal=$( tput sgr0 )

echo "Standard $(tput bold) bold"
len=${#colors[@]}
for (( i=0; i<$len; i++)) 
do
    col=$( tput setaf $i)
    bold=$( tput bold)
    echo "$i : $col  ${colors[$i]} $bold bold $normal "
done

echo "== Solarized =="
echo "$(tput setaf 0;tput bold)base03 $normal"
echo "$(tput setaf 0)base02 $normal"
echo "$(tput setaf 2;tput bold)base01 $normal"
echo "$(tput setaf 3;tput bold)base00 $normal"
echo "$(tput setaf 4;tput bold)base0 $normal"
echo "$(tput setaf 6;tput bold)base1 $normal"
echo "$(tput setaf 7)base2 $normal"
echo "$(tput setaf 7;tput bold)base3 $normal"
echo "$(tput setaf 3)yellow $normal"
echo "$(tput setaf 1;tput bold)orange $normal"
echo "$(tput setaf 1)red $normal"
echo "$(tput setaf 5)magenta $normal"
echo "$(tput setaf 5;tput bold)violet $normal"
echo "$(tput setaf 4)blue $normal"
echo "$(tput setaf 6)cyan $normal"
echo "$(tput setaf 2)green $normal"

