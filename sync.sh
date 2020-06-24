#!/bin/zsh

cd ~
d=()
v=$1

if [ "${1:1:1}" = 'M' ]
then
    r='.mtp/Samsung SD card/'
else
    r='main:'
fi
shift

while [ ! $# -eq 0 ]
do
    case "$1" in
log)
    tail -n 10 .rlog
    return ;;

all)
    d=($(cat ~/doc/.sync))
    break ;;

-n)
    d='doc/notes'
    r='next:'
    break ;;

*)
    if [ -e "$1" ]
    then
        d+=($1)
    else
        echo "[$1] don't exist"
    fi
    esac
    shift
done

for o in $d
do
    echo "\n[\e[93m$o\e[0m] $v"
    case "${v:0:1}" in
+) rclone sync $o $r$o -v -u --tpslimit=100 --no-update-modtime ;; # --backup-dir $r.Trash
-) rclone sync $r$o $o -v -u --tpslimit=100 --no-update-modtime --backup-dir .local/share/Trash/files/ ;;
    esac
done

if [ -n "$d" ]
then
    echo "$(date +'%b %d %I:%M %P') $v  $d;" >> .rlog
fi
