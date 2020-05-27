#!/bin/bash

alarm()
{
    sleep $1
    beep -f 1000
    echo $2 | dzen2  -fn "xos4 Terminus-10" -fg "#FFD700" -p 5
}

read -p "Time delay : " t
read -p "Message    : " m
alarm "$t" "$m" & disown
