#!/bin/zsh

[ -n "$1" ] ||
{
    echo "Usage: `basename $0` DIR [.FORMAT]"
    exit
}
cd "$1" || exit

ext=${2:-.jpg}

new=(`seq -s " " -f %03g$ext 1 $(ls | wc -l)`)
old=(`ls`)

com=(`printf "%s\n" $new $old | sort | uniq -d `)

to=(`printf "%s\n" $new $com | sort | uniq -u`)
from=(`printf "%s\n" $old $com | sort | uniq -u`)

i=1
for n in $to
do
    mv -vi $from[$i] $n
    i=$((i+1))
done
