#!/bin/bash
# QuinxOS Plugin: Anime Features
# Commands: quinx-anime-quote, quinx-waifu, quinx-anime-art

QUINX_ANIME="$HOME/QuinxOS/.object"

quinx-anime-quote() {
    local quotes_file="$QUINX_ANIME/anime-quotes.txt"
    if [ -f "$quotes_file" ]; then
        local total=$(wc -l < "$quotes_file")
        local idx=$((RANDOM % total + 1))
        local quote=$(sed -n "${idx}p" "$quotes_file")
        echo ""
        echo -e "\033[1;35m  「 ${quote} 」\033[0m"
        echo ""
    fi
}

quinx-waifu() {
    echo -e "\033[1;35m"
    local art_files=("naruto" "luffy" "eren" "goku" "tanjiro" "rei")
    local idx=$((RANDOM % ${#art_files[@]}))
    local name="${art_files[$idx]}"
    echo -e "  \033[1;97m── $name ──\033[0m"
    echo ""
    # Extract art block from anime-art.txt
    sed -n "/===${name}===/,/===/p" "$QUINX_ANIME/anime-art.txt" 2>/dev/null | grep -v "===" | head -10
    echo -e "\033[0m"
}

quinx-anime-art() {
    local art_file="$QUINX_ANIME/anime-art.txt"
    if [ ! -f "$art_file" ]; then
        echo -e "\033[1;31m  Anime art file not found\033[0m"
        return
    fi
    echo ""
    echo -e "\033[1;35m  Available Characters:\033[0m"
    grep "===" "$art_file" | sed 's/===/  /g' | tr '\n' ' '
    echo ""
    echo ""
    echo -ne "\033[1;36m  Choose: \033[0m"
    read -r choice
    [ -z "$choice" ] && return
    echo ""
    echo -e "\033[1;35m"
    sed -n "/===${choice}===/,/===/p" "$art_file" 2>/dev/null | grep -v "==="
    echo -e "\033[0m"
}

quinx-funfact() {
    local facts_file="$QUINX_ANIME/fun-facts.txt"
    if [ -f "$facts_file" ]; then
        local total=$(wc -l < "$facts_file")
        local idx=$((RANDOM % total + 1))
        local fact=$(sed -n "${idx}p" "$facts_file")
        echo ""
        echo -e "\033[1;33m  💡 $fact\033[0m"
        echo ""
    fi
}
