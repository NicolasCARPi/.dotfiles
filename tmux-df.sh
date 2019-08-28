#!/usr/bin/env bash
if [ "$(hostname)" == 'osiris' ]; then
    echo $(df -h | grep sda2 | awk '{print $4}') free
fi
