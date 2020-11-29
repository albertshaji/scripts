#!/bin/bash

AURDIR=$HOME/.aur

[ `whoami` = 'root' ] && exit
cd $AURDIR
while [ ! $# -eq 0 ]
do
    if [ -d "$1" ]
    then
        cd $1
        git pull
    else
        git clone https://aur.archlinux.org/$1.git
        cd $1
    fi
    makepkg -si --noconfirm --needed
    cd ..
    shift
done
