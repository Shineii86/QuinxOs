#!/bin/bash
# QuinxOS Plugin: Dictionary
# Usage: quinx-define <word>

quinx-define() {
    if [ -z "$1" ]; then
        echo -e "\033[1;36m  Usage: quinx-define 'ephemeral'\033[0m"
        return
    fi
    echo -e "\033[1;36m  Looking up: $1\033[0m"
    local result=$(curl -s "https://api.dictionaryapi.dev/api/v2/entries/en/$1" 2>/dev/null)
    if echo "$result" | grep -q '"word"'; then
        local word=$(echo "$result" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d[0]['word'])" 2>/dev/null)
        local phonetic=$(echo "$result" | python3 -c "import sys,json; d=json.load(sys.stdin); p=d[0].get('phonetics',[{}]); print(p[0].get('text',''))" 2>/dev/null)
        local meaning=$(echo "$result" | python3 -c "
import sys,json
d=json.load(sys.stdin)
m=d[0]['meanings'][0]
pos=m['partOfSpeech']
defn=m['definitions'][0]['definition']
print(f'{pos}: {defn}')
" 2>/dev/null)
        echo ""
        echo -e "  \033[1;97m${word}\033[0m \033[2m${phonetic}\033[0m"
        echo -e "  \033[1;32m${meaning}\033[0m"
        echo ""
    else
        echo -e "\033[1;31m  Word not found: $1\033[0m"
    fi
}
