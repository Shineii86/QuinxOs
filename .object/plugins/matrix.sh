#!/bin/bash
# QuinxOS Plugin: Matrix Rain Animation
# Usage: quinx-matrix [duration_seconds]

quinx-matrix() {
    local duration=${1:-10}
    local cols=$(tput cols 2>/dev/null || echo 80)
    local lines=$(tput lines 2>/dev/null || echo 24)

    echo -e "\033[1;32m  Matrix Rain — ${duration}s — Press Ctrl+C to stop\033[0m"
    sleep 1

    trap 'echo -e "\033[0m"; return' INT

    local chars="01アイウエオカキクケコサシスセソタチツテトナニヌネノハヒフヘホマミムメモヤユヨラリルレロワヲン"
    local start=$(date +%s)

    while true; do
        local now=$(date +%s)
        [ $((now - start)) -ge $duration ] && break

        local col=$((RANDOM % cols))
        local len=$((RANDOM % 15 + 3))

        for ((i=0; i<len; i++)); do
            local row=$((RANDOM % lines))
            local char="${chars:$((RANDOM % ${#chars})):1}"

            if [ $i -lt 2 ]; then
                echo -ne "\033[${row};${col}H\033[1;37m${char}\033[0m"
            elif [ $i -lt 5 ]; then
                echo -ne "\033[${row};${col}H\033[1;32m${char}\033[0m"
            else
                echo -ne "\033[${row};${col}H\033[2;32m${char}\033[0m"
            fi
        done
        sleep 0.02
    done
    echo -e "\033[0m"
}
