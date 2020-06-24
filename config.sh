#!/bin/zsh

[ -d .arch ] || exit

if  [ `whoami` = 'root' ]
then
    deploy()
    {
        mkdir -p "`dirname $2`"
        cp -v "$1" "$2"
    }

else
    deploy()
    {
        cmp --silent "$2" "$1" ||
        cp -v "$2" "$1"
    }
fi

for f in `ls .arch -I '*[[:upper:]]*'`
do
    t=`head -n 1 .arch/$f | cut -c 2-`
    deploy ".arch/$f" "$t"
done

deploy "doc/.bmarks" ".config/BraveSoftware/Brave-Browser/Default/Bookmarks"
deploy "doc/.rclone" ".config/rclone/rclone.conf"
deploy ".scripts/sxiv.sh" ".config/sxiv/exec/key-handler"
