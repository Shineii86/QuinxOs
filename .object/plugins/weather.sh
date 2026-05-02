#!/bin/bash
# QuinxOS Plugin: Weather
# Usage: quinx-weather [city]

quinx-weather() {
    local city="${1:-}"
    if [ -z "$city" ]; then
        echo -e "\033[1;36m  Usage: quinx-weather <city>\033[0m"
        echo -e "  Example: quinx-weather London"
        return
    fi
    curl -s "wttr.in/${city}?format=3" 2>/dev/null || echo "  Failed to fetch weather"
}
