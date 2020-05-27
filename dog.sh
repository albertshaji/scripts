#!/bin/bash

note_r() { dzen2 -fn "xos4 Terminus-10" -fg "#FF0000" -p 5 & beep -f 500; }
note_g() { dzen2 -fn "xos4 Terminus-10" -fg "#83BF15" -p 5 & beep -f 500; }
note_w() { dzen2 -fn "xos4 Terminus-10" -fg "#EBDBB2" -p 5 & beep -f 500; }

case "$1" in
+s)
    status () {
    s=" | "
    nm-online -t 0
    if [ $? -eq 0 ]; then printf " W "; fi
    printf " B$(cat /sys/class/power_supply/BAT0/capacity)"
    if [ `cat /sys/class/power_supply/BAT0/status` = 'Charging' ]; then printf "*"; fi
    printf "$s"
    printf "T$((`cat /sys/class/thermal/thermal_zone0/temp`/1000))"
    printf "$s"
    printf "C%02d" $(top -bn1 | sed -n '/Cpu/p' | cut -c 10-11)
    printf "$s"
    printf "R$(free -m | awk '/^Mem/ {print $3}')"
    printf "$s"
    printf "U$(awk '{print int($1/3600)":"int(($1%3600)/60)}' /proc/uptime)"
    printf "$s"
    printf "$(date +"%a %d %b %Y %I:%M %p")"
    }

    echo "Status update started."
    while true
    do
        xsetroot -name "$(status)"
    sleep 30s
    done &
    ;;

+b)
    echo "Battery notification started."
    b_cri=20
    b_low=40
    b_max=95
    while true
    do
        b=$(cat /sys/class/power_supply/BAT0/capacity)
        bs=$(cat /sys/class/power_supply/BAT0/status)

        if [ $b -lt $b_cri ]
        then
            echo "Battery critical" | note_r
            sleep 1m
            slock &
            systemctl hibernate
        fi

        if [ $b -lt $b_low ] && [ $bs = 'Discharging' ]
        then
            echo "Battery low: $b %" | note_r
        fi

        if [ $b -gt $b_max ] && [ $bs = 'Charging' ]
        then
            echo "Battery full" | note_g
        fi
    sleep 2m
    done &
    ;;

+t)
    echo "Temperature notification started."
    t_hi=70
    t_cri=90
    while true
    do
        t=$((`cat /sys/class/thermal/thermal_zone0/temp`/1000))
        if [ $t -gt $t_hi ]
        then
            echo "Temperature high: $t°C" | note_r
        fi

        if [ $t -gt $t_cri ]
        then
            sudo rtcwake -m mem -s 240
            t=$((`cat /sys/class/thermal/thermal_zone0/temp`/1000))
            if [ $t -gt $t_cri ]
            then
                systemctl hibernate
            fi
        fi
    sleep 2m
    done &
    ;;

+p)
    echo "Periodic vacations started."
    echo "$(date)" > .plog
    gap=25m
    while true
    do
    sleep $gap

    j=$(journalctl -qn 1 -t systemd-sleep -S "$(date +%R -d "-24 min")" | awk '{print $3}')
    if [ -n "$j" ]
    then
        n=$(date +%s)
        r=$(date +%s -d "$j")
        gap=$((1500 - n + r))s
        continue
    fi
    gap=25m

    echo "Clock: $(date +"%I:%M %p")" | note_w
    che=$(date +%R)
    sleep 1m
    if [ "$che" != "$(date +%R -d "-1 min")" ]
    then
        continue
    fi

    b=$(xbacklight -get)
    if ! pgrep mpv >/dev/null && [ "${b%.*}" -gt 0 ]
    then
        sudo rtcwake -m mem -s 240 >/dev/null
    fi
    done &
    ;;

+)
    dog.sh +s
    dog.sh +b
    dog.sh +t
    dog.sh +p
    ;;

-l | ls)
    pgrep -fa "dog.sh \+"
    ;;

-*)
    pkill -f "dog.sh \+${1:1:1}"
    if [ $? -eq 0 ]
    then
        echo "Termination successful."
    fi
    ;;
esac
