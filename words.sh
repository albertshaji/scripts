#!/bin/bash

while true
do
    w=$(cat /usr/share/dict/british-english | dmenu)
    [ -n "$w" ] &&
    grep -qw "$w" /usr/share/dict/british-english &&
    {
        echo "$w" >> doc/.words
        sdcv -u 'WordNet' -u 'Moby Thesaurus II' $w -ne |
        dmenu -l 20
    } || break
done
