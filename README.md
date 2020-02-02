# dotfiles

Simple dotfiles management inspired by [GibHub dotfiles](https://dotfiles.github.io/) page.
Currently contains just basic files and workflow based
on `stowsh`. May be switched to another "package manager" in the future.

## `stowsh`

`stowsh` is currently used to install a *package*, see [GitHub page](https://github.com/williamsmj/stowsh) for details.

### Basic Usage

With `-n` option a dry-run is preformed and nothing is installed. If a file already exists, nothing is replaced.
`TARGET` is not home directry by default, so it must be passes as parameter.

~~~~.bash
heavy@mymachine $ stowsh -h
Usage: /home/heavy/bin/stowsh [-D] [-n] [-s] [-v[v]] [-t TARGET] PACKAGES...

heavy@mymachine $ stowsh -v -n -s -t /home/heavy/ base
Installing base to /home/heavy/
/home/heavy/bin/stowsh already exists.
mkdir -p '/home/heavy/bin'


heavy@mymachine $ stowsh -v -n -s -t /home/heavy bash
Installing bash to /home/heavy
/home/heavy/.bashrc already exists.
/home/heavy/./.bash_aliases already exists.
/home/heavy/./.bash_functions already exists.
/home/heavy/./.bash_linux already exists.
/home/heavy/./.bash_osx already exists.
/home/heavy/./.bash_prompt already exists.
/home/heavy/./motd.sh already exists.

~~~~
