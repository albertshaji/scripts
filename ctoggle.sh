#!/bin/bash

if [ -e .ct ]
then
    redshift -P -O 5000 >/dev/null
    rm .ct
else
    redshift -x >/dev/null
    touch .ct
fi
