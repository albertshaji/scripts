#!/bin/zsh

if [ `date +%H` -le 12 ]
then
    url=(
    www.facebook.com 200
    www.instagram.com 300
    twitter.com 300
    www.linkedin.com 300
    web.whatsapp.com 200
    mail.disroot.org 200
    ted.com 1200
    )
else
    url=(
    'www.youtube.com/watch?v=iL53Y28Rp84' 500
    web.whatsapp.com 200
    mail.disroot.org 200
    )
fi


#if pgrep brave >/dev/null
#then xdotool key alt+2
#else
#    xdotool key alt+w
#    until pidof brave >/dev/null
#        do sleep 1
#    done
#    sleep 3
#fi

pgrep brave >/dev/null ||
echo "Browser not running."

for ((i=1; i<${#url}; i+=2))
do
    pgrep brave >/dev/null || exit
    xdotool key alt+2
    echo $url[i]
    brave "https://$url[i]" &>/dev/null
    echo $$ >.pid
    sleep $url[i+1]
done

xdotool key alt+2 ctrl+t
