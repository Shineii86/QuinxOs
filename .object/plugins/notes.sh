#!/bin/bash
# QuinxOS Plugin: Quick Notes
# Usage: quinx-note [add|list|search|clear] [text]

QUINX_NOTES="$HOME/QuinxOS/.notes"

quinx-note() {
    mkdir -p "$QUINX_NOTES"
    case "${1:-list}" in
        add|a)
            shift
            local text="$*"
            if [ -z "$text" ]; then
                echo -ne "\033[1;36m  Note: \033[0m"
                read -r text
            fi
            local ts=$(date '+%Y-%m-%d %H:%M')
            echo "[$ts] $text" >> "$QUINX_NOTES/notes.txt"
            echo -e "\033[1;32m  ✓ Note saved\033[0m"
            ;;
        list|l|ls)
            if [ -f "$QUINX_NOTES/notes.txt" ] && [ -s "$QUINX_NOTES/notes.txt" ]; then
                echo -e "\033[1;36m  ── Your Notes ──\033[0m"
                nl -ba "$QUINX_NOTES/notes.txt"
            else
                echo -e "\033[2m  No notes yet. Use: quinx-note add 'text'\033[0m"
            fi
            ;;
        search|s)
            shift
            if [ -n "$1" ]; then
                grep -in "$1" "$QUINX_NOTES/notes.txt" 2>/dev/null || echo -e "\033[2m  No matches for: $1\033[0m"
            else
                echo -e "\033[1;36m  Usage: quinx-note search 'keyword'\033[0m"
            fi
            ;;
        clear|c)
            > "$QUINX_NOTES/notes.txt"
            echo -e "\033[1;31m  All notes cleared\033[0m"
            ;;
        *)
            echo -e "\033[1;36m  Usage: quinx-note [add|list|search|clear] [text]\033[0m"
            ;;
    esac
}
