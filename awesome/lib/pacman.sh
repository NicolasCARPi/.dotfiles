#!/bin/bash
# display the number of packages to update
# https://github.com/NicolasCARPi/.dotfiles
# For Archlinux only.
# It's best to have pacman -Sy in /etc/cron.hourly

# Total number of packages needing upgrade
n=$(pacman -Qu | wc -l)
# audacity blocked update
n=$((n-1))
# If there is nothing to upgrade, print nothing
if [ "$n" == 0 ]; then
    #echo "[☺]"
    echo -n ""

elif [ "$n" == 1 ]; then
    echo -n "[$n update]"
else
    echo -n "[$n updates]"
fi
echo -n "|"
echo -n "$(free -hm|grep Mem|awk '{print $3}')"
echo -n "|"
