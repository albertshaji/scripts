#!/bin/sh

while read file
do
        case "$1" in
        "d")
                mv "$file" ~/.local/share/Trash/files ;;
        "m")
                mv --backup=t "$file" ~/pic/ADDED ;;
        "c")
                cp --backup=t "$file" ~/pic/ADDED ;;
        "r")
                convert -rotate 90 "$file" "$file" ;;
        "R")
                convert -rotate -90 "$file" "$file" ;;
        "w")
                feh -z --bg-fill "$file" ;;
        esac
done
