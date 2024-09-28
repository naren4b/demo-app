#!/bin/bash

counter=0
dockerid=$(head -1 /proc/self/cgroup | cut -d/ -f3)
while true; do
    sleep 1
    echo $(date '+%Y-%m-%d %H:%M:%S') hostname=$(hostname) dockerid=$dockerid app=demo user=$(whoami) message=$RANDOM $((counter++))
done
