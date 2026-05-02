#!/bin/bash
# QuinxOS Plugin: Color Info & Converter
# Usage: quinx-color [#hex|name]

quinx-color() {
    if [ -z "$1" ]; then
        echo -e "\033[1;36m  Usage: quinx-color '#ff5733' or quinx-color red\033[0m"
        echo -e "\033[1;36m  Shows: RGB, HSL, preview\033[0m"
        return
    fi
    local input="$1"
    local r g b
    if [[ "$input" =~ ^# ]]; then
        r=$((16#${input:1:2}))
        g=$((16#${input:3:2}))
        b=$((16#${input:5:2}))
    else
        case "${input,,}" in
            red)     r=255; g=0;   b=0   ;;
            green)   r=0;   g=255; b=0   ;;
            blue)    r=0;   g=0;   b=255 ;;
            yellow)  r=255; g=255; b=0   ;;
            cyan)    r=0;   g=255; b=255 ;;
            magenta) r=255; g=0;   b=255 ;;
            white)   r=255; g=255; b=255 ;;
            black)   r=0;   g=0;   b=0   ;;
            orange)  r=255; g=165; b=0   ;;
            purple)  r=128; g=0;   b=128 ;;
            *)       echo -e "\033[1;31m  Unknown color: $input\033[0m"; return ;;
        esac
    fi
    local hex=$(printf '#%02x%02x%02x' $r $g $b)
    echo ""
    echo -e "\033[1;36m  ── Color Info ──\033[0m"
    echo -e "  HEX:   \033[1;97m${hex}\033[0m"
    echo -e "  RGB:   \033[1;97m${r}, ${g}, ${b}\033[0m"
    printf "  Preview: \033[48;2;%d;%d;%dm          \033[0m\n" $r $g $b
    echo ""
}
