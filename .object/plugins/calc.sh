#!/bin/bash
# QuinxOS Plugin: Calculator
# Usage: quinx-calc "expression"

quinx-calc() {
    if [ -z "$1" ]; then
        echo -e "\033[1;36m  Usage: quinx-calc '2+2' or quinx-calc 'sqrt(144)'\033[0m"
        return
    fi
    local result=$(echo "scale=4; $1" | bc -l 2>/dev/null)
    if [ $? -eq 0 ]; then
        echo -e "\033[1;32m  = $result\033[0m"
    else
        echo -e "\033[1;31m  Error evaluating: $1\033[0m"
    fi
}

quinx-calc-history() {
    echo -e "\033[1;36m  Calculator History:\033[0m"
    [ -f "$HOME/QuinxOS/.calc-history" ] && cat "$HOME/QuinxOS/.calc-history" || echo "  No history"
}
