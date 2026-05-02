#!/bin/bash
# QuinxOS Plugin: QR Code Generator
# Usage: quinx-qr "text or URL"

quinx-qr() {
    if [ -z "$1" ]; then
        echo -e "\033[1;36m  Usage: quinx-qr 'https://github.com/Shineii86'\033[0m"
        return
    fi
    local data="$1"
    echo -e "\033[1;36m  Generating QR code...\033[0m"
    if command -v qrencode &>/dev/null; then
        qrencode -t ANSIUTF8 "$data"
    else
        curl -s "https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=$(echo "$data" | sed 's/ /+/g')" > /tmp/quinx-qr.png 2>/dev/null
        if [ -f /tmp/quinx-qr.png ]; then
            echo -e "\033[1;32m  QR code saved to /tmp/quinx-qr.png\033[0m"
            [ -d "$HOME/QuinxOS" ] && cp /tmp/quinx-qr.png "$HOME/QuinxOS/"
        else
            echo -e "\033[1;31m  Failed to generate QR code\033[0m"
        fi
    fi
}
