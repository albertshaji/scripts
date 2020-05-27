#!/bin/bash

while true
do
    w=$(cat /usr/share/dict/british-english | dmenu)
    [ $1 = 3 ] && flite -t "$w" -voice slt &
    [ -n "$w" ] && sdcv $w -n | dmenu -l 20
    [ $? = 1 ] && break
done
