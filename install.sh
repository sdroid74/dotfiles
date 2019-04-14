#!/bin/bash
# 
# used https://raw.githubusercontent.com/williamsmj/dotfiles/master/install.sh
# as input
# 
cd "$(dirname "${BASH_SOURCE[0]}")" || exit

# get stowsh (and put it in a package)
# curl -o ./bin/.local/bin/stowsh https://raw.githubusercontent.com/williamsmj/stowsh/master/stowsh
# chmod +x ./bin/.local/bin/stowsh

# stow is subtree
stow=stowsh/stowsh

if [ ! -d "base/bin" ]; then
    mkdir -p $(pwd)/base/bin
fi 
# copy stowsh script and install base package
cp -p $stow base/bin/
$stow -s base -t "$HOME"

# get all the root level directories that don't start with "."
# pkgs="$(find . -maxdepth 1 ! -name '.*' -type d | sed "s|./||")"
# remove OS-specific packages from this list
# pkgs=${pkgs//darwin/}
# pkgs=${pkgs//linux/}

# for pkg in $pkgs
# do
#     bin/.local/bin/stowsh -v -s "$pkg" -t "$HOME"
# done

# install OS-specific packages if appropriate
# if [[ $(uname) == "Darwin" ]] ; then
#     bin/.local/bin/stowsh -s darwin -t "$HOME"
# fi

# if [[ $(uname) == "Linux" ]] ; then
#ä     bin/.local/bin/stowsh -s linux -t "$HOME"
# fi

# bootstrap vim plugin configuration
# curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# vim -c PlugInstall +qall
