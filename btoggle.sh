#!/bin/bash

b=$(xbacklight -get)
if [ "${b%.*}" = 0 ]; then
    xbacklight -set 7
else
    xbacklight -set 0
fi
