#!/bin/bash
# QuinxOS Plugin: Universal Archive Extractor
# Usage: quinx-extract <file>

quinx-extract() {
    if [ -z "$1" ]; then
        echo -e "\033[1;36m  Usage: quinx-extract <file>\033[0m"
        return 1
    fi
    if [ ! -f "$1" ]; then
        echo -e "\033[1;31m  File not found: $1\033[0m"
        return 1
    fi
    case "$1" in
        *.tar.bz2)   tar xjf "$1"   ;;
        *.tar.gz)    tar xzf "$1"   ;;
        *.tar.xz)    tar xJf "$1"   ;;
        *.bz2)       bunzip2 "$1"   ;;
        *.rar)       unrar x "$1"   ;;
        *.gz)        gunzip "$1"    ;;
        *.tar)       tar xf "$1"    ;;
        *.tbz2)      tar xjf "$1"   ;;
        *.tgz)       tar xzf "$1"   ;;
        *.zip)       unzip "$1"     ;;
        *.Z)         uncompress "$1";;
        *.7z)        7z x "$1"      ;;
        *.xz)        unxz "$1"      ;;
        *.zst)       unzstd "$1"    ;;
        *)           echo -e "\033[1;31m  Unknown format: $1\033[0m"; return 1 ;;
    esac
    echo -e "\033[1;32m  ✓ Extracted: $1\033[0m"
}
