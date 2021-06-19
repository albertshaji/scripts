#!/bin/zsh

if [ "$1" = '-' ]
then
    d=($(lsblk -pl | grep '\media' | awk '{print $1}'))

elif [ "$1" = '+' ]
then
    d=($(lsblk -plo name,fstype,mountpoint | awk 'NF==2{print $1}'))

else
    echo "Usage: `basename $0` +/-"
    exit
fi

if [ -n "$d" ]
then
    lsblk -dno name,size,label $d | nl
    read "?Select: " num

    for n in $(echo $num)
    do
        if [ -n "$d[n]" ]
        then

        case "$1" in
        +) udisksctl mount -b "$d[n]" ;;
        -) sudo umount -v "$d[n]" ;;
        esac

        else echo "Invalid Choice!"
        fi
    done

else
    echo "Empty :)"
fi
