#!/bin/zsh

CONFIG=code/LinuxConfig
SCRIPTS=code/LinuxScripts

[ -d $CONFIG ] || exit

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

for f in `ls $CONFIG -I "*.txt" -I LICENSE -I README.md`
do
    app=`head -n 1 ${CONFIG}/$f | awk '{print $3}'`
    if pacman -Qe $app &>/dev/null
    then
        t=`head -n 1 ${CONFIG}/$f | awk '{print $2}'`
        deploy "${CONFIG}/$f" "$t"
    else
        echo "Skipped for [$app] Package."
    fi
done

deploy "doc/.bmarks" ".config/BraveSoftware/Brave-Browser/Default/Bookmarks"
deploy "doc/.rclone" ".config/rclone/rclone.conf"
deploy "${SCRIPTS}/sxiv.sh" ".config/sxiv/exec/key-handler"
