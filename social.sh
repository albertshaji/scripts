#!/bin/zsh

urls=(
300 "http://allindiaradio.gov.in/radio/live.php?channel=1"
300 "https://www.facebook.com"
300 "https://www.instagram.com"
300 "https://twitter.com"
300 "https://www.linkedin.com"
150 "https://web.whatsapp.com"
150 "https://mail.disroot.org"
)

xclip -sel c ~/doc/LinkedinConnect.txt

pgrep brave >/dev/null ||
echo "Browser not running."

for ((i=1; i<${#urls}; i+=2))
do
    pgrep brave >/dev/null || exit
    xdotool key alt+2
    echo $urls[i+1]
    brave "$urls[i+1]" &>/dev/null
    echo $$ >.pid
    sleep $urls[i]
done

xdotool key alt+2 ctrl+t
