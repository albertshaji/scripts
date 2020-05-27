#!/bin/bash

t="SynPS/2 Synaptics TouchPad"
if [ -e .tt ]
then
    xinput disable "$t"
    rm .tt
else
    xinput enable "$t"
    touch .tt
fi
