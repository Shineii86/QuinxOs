#!/bin/bash
# QuinxOS Plugin: Timer & Stopwatch
# Usage: quinx-timer [seconds] or quinx-stopwatch

quinx-timer() {
    if [ -z "$1" ]; then
        echo -e "\033[1;36m  Usage: quinx-timer 60 (countdown from 60s)\033[0m"
        return
    fi
    local secs=$1
    echo -e "\033[1;33m  Timer: ${secs}s — Press Ctrl+C to cancel\033[0m"
    while [ $secs -gt 0 ]; do
        printf "\r  \033[1;97m⏱  %02d:%02d\033[0m " $((secs/60)) $((secs%60))
        sleep 1
        secs=$((secs - 1))
    done
    printf "\r  \033[1;32m⏱  00:00 — TIME'S UP!\033[0m\n"
    printf '\a\a\a'
}

quinx-stopwatch() {
    echo -e "\033[1;33m  Stopwatch started — Press Ctrl+C to stop\033[0m"
    local start=$(date +%s)
    while true; do
        local now=$(date +%s)
        local diff=$((now - start))
        printf "\r  \033[1;97m⏱  %02d:%02d:%02d\033[0m " $((diff/3600)) $((diff%3600/60)) $((diff%60))
        sleep 1
    done
}
