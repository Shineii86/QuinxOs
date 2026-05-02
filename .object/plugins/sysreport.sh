#!/bin/bash
# QuinxOS Plugin: System Report
# Usage: quinx-report

quinx-report() {
    local report_file="$HOME/QuinxOS/system-report-$(date +%Y%m%d).txt"
    echo -e "\033[1;36m  Generating system report...\033[0m"

    {
        echo "═══════════════════════════════════════"
        echo "  QuinxOS System Report"
        echo "  Generated: $(date)"
        echo "═══════════════════════════════════════"
        echo ""
        echo "── System ──"
        echo "  OS:       $(uname -o 2>/dev/null)"
        echo "  Host:     $(hostname 2>/dev/null)"
        echo "  Kernel:   $(uname -r 2>/dev/null)"
        echo "  Arch:     $(uname -m 2>/dev/null)"
        echo "  Uptime:   $(uptime -p 2>/dev/null || echo 'N/A')"
        echo ""
        echo "── Hardware ──"
        echo "  CPU:      $(nproc 2>/dev/null) cores"
        echo "  Memory:   $(free -h 2>/dev/null | awk '/Mem:/{print $3"/"$2}')"
        echo "  Swap:     $(free -h 2>/dev/null | awk '/Swap:/{print $3"/"$2}')"
        echo ""
        echo "── Storage ──"
        df -h / 2>/dev/null | awk 'NR==1{print "  "$0} NR==2{print "  "$0}'
        echo ""
        echo "── Network ──"
        echo "  Local IP: $(ip route get 1.1.1.1 2>/dev/null | grep -oP 'src \K\S+')"
        echo "  Public:   $(curl -s --max-time 5 ifconfig.me 2>/dev/null || echo 'N/A')"
        echo ""
        echo "── Packages ──"
        echo "  Installed: $(dpkg -l 2>/dev/null | grep -c '^ii') packages"
        echo ""
        echo "── Shell ──"
        echo "  Shell:    $SHELL"
        echo "  Zsh:      $([ -d ~/.oh-my-zsh ] && echo 'Installed' || echo 'Not installed')"
        echo "  QuinxOS:  v$(cat "$HOME/QuinxOS/.quinx-version" 2>/dev/null || echo 'unknown')"
        echo ""
        echo "── Top Processes ──"
        ps aux 2>/dev/null | sort -nrk 3 | head -5 | awk '{printf "  %-8s %5s%% CPU  %5s%% RAM  %s\n", $1, $3, $4, $11}'
        echo ""
        echo "═══════════════════════════════════════"
    } | tee "$report_file"

    echo ""
    echo -e "\033[1;32m  ✓ Report saved: $report_file\033[0m"
}
