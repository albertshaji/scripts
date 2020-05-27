#!/bin/bash

n=`ls screenshot*.png | wc -l`
n=$(( $n  + 1 ))
while true
do
    if [ -e screenshot$n.png ]
    then
        n=$(( n + 1 ))
    else
        break
    fi
done
imlib2_grab screenshot$n.png
