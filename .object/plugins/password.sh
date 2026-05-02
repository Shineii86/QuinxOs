#!/bin/bash
# QuinxOS Plugin: Password Generator
# Usage: quinx-pass [length]

quinx-pass() {
    local len=${1:-16}
    local pass=$(cat /dev/urandom | tr -dc 'A-Za-z0-9!@#$%^&*' | head -c "$len" 2>/dev/null)
    echo -e "\033[1;32m  Generated password (${len} chars):\033[0m"
    echo -e "\033[1;97m  $pass\033[0m"
    echo "$pass" | termux-clipboard-set 2>/dev/null && echo -e "\033[1;36m  Copied to clipboard!\033[0m"
}

quinx-passphrase() {
    local words=("alpha" "bravo" "charlie" "delta" "echo" "foxtrot" "golf" "hotel" "india" "juliet" "kilo" "lima" "mike" "november" "oscar" "papa" "quebec" "romeo" "sierra" "tango" "uniform" "victor" "whiskey" "xray" "yankee" "zulu")
    local count=${1:-4}
    local phrase=""
    for ((i=0; i<count; i++)); do
        local idx=$((RANDOM % ${#words[@]}))
        phrase="${phrase}${words[$idx]}-"
    done
    phrase="${phrase%-}$((RANDOM % 100))"
    echo -e "\033[1;32m  Passphrase (${count} words):\033[0m"
    echo -e "\033[1;97m  $phrase\033[0m"
}
