#!/bin/bash
# +----------------------------------------------------------+
# |                      QuinxOS v6.0                        |
# |           Termux Optimization & Customization Suite      |
# |                      by Shineii86                        |
# +----------------------------------------------------------+

R='\033[1;31m'; G='\033[1;32m'; Y='\033[1;93m'; B='\033[1;94m'
C='\033[1;96m'; W='\033[1;97m'; M='\033[1;95m'; D='\033[2m'
RS='\033[0m'

QUINX_HOME="$HOME/QuinxOS"
QUINX_VERSION="6.0"
QUINX_MARKER="$HOME/.quinx-installed"
QUINX_THEMES="$QUINX_HOME/.object/themes"
QUINX_PLUGINS="$QUINX_HOME/.object/plugins"
QUINX_PROFILES="$QUINX_HOME/.profiles"

term_width=$(tput cols 2>/dev/null || echo 80)
BOX_WIDTH=$(( term_width > 64 ? 62 : term_width - 2 ))
margin=$(( (term_width - BOX_WIDTH) / 2 ))
left_pad=$(printf '%*s' "$margin" "")

draw_top()    { printf "${C}${left_pad}+"; for ((i=0; i<BOX_WIDTH-2; i++)); do printf "-"; done; printf "+${RS}\n"; }
draw_bot()    { printf "${C}${left_pad}+"; for ((i=0; i<BOX_WIDTH-2; i++)); do printf "-"; done; printf "+${RS}\n"; }
draw_sep()    { printf "${C}${left_pad}+"; for ((i=0; i<BOX_WIDTH-2; i++)); do printf "-"; done; printf "+${RS}\n"; }
print_line() {
    local text="$1" color="${2:-$W}" len=${#text} inner=$((BOX_WIDTH - 2))
    local sl=$(( (inner - len) / 2 )) sr=$(( inner - len - sl ))
    printf "${C}${left_pad}|%*s${color}%s${C}%*s|${RS}\n" $sl "" "$text" $sr ""
}
print_item() {
    local num="$1" label="$2" desc="$3" color="${4:-$G}"
    local full="  ${C}[${W}${num}${C}]${color} ${label}"
    printf "${C}${left_pad}|${RS}${full}"
    printf '%*s' $(( BOX_WIDTH - 2 - ${#full} - ${#desc} - 2 )) ""
    printf "${D}%s${RS}  ${C}|${RS}\n" "$desc"
}

# --- Banners -----------------------------------------------
banner_style_1() {
    echo ""
    echo -e "${C}     _  _ ____ _  _ ____ ____ _  _ ____ _  _ ___  ${RS}"
    echo -e "${C}     |\\/| |__  |  | |__  |__/ |  | |__  |\\/| |__] ${RS}"
    echo -e "${C}     |  | |___ |/\\| |___ |  \\ |/\\| |___ |  | |    ${RS}"
    echo ""
}
banner_style_2() {
    echo ""
    echo -e "${M}    +-------------------------------------------------+${RS}"
    echo -e "${M}    |  Q U I N X O S                                  |${RS}"
    echo -e "${M}    |  Termux Optimization Suite                      |${RS}"
    echo -e "${M}    +-------------------------------------------------+${RS}"
}
banner_style_3() {
    echo ""
    echo -e "${G}    _________________________________________________${RS}"
    echo -e "${G}    |  ___        _           _              _     |${RS}"
    echo -e "${G}    | |   | _ _ _| |___ ___ _| |___ ___ ___|_|___ |${RS}"
    echo -e "${G}    | | | || | | . | -_|   | . | . |_ -| -_| | .'||${RS}"
    echo -e "${G}    | |_|_|___|_|___|___|_|___|___|___|___|_|__,||${RS}"
    echo -e "${G}    |_________________________________________________|${RS}"
}
banner_style_4() {
    echo ""
    echo -e "${Y}          +---------------------------+${RS}"
    echo -e "${Y}          | ${R}  _  _ ___ _  _ ____ _  _  ${Y}|${RS}"
    echo -e "${Y}          | ${R}  |  |  |  |__| |  | |\\ |  ${Y}|${RS}"
    echo -e "${Y}          | ${R}  |__|  |  |  | |__| | \\|  ${Y}|${RS}"
    echo -e "${Y}          +---------------------------+${RS}"
}
banner_style_5() {
    echo ""
    echo -e "${R}    +------------------------------------------+${RS}"
    echo -e "${R}    |                                          |${RS}"
    echo -e "${R}    |   Q U I N X O S                          |${RS}"
    echo -e "${R}    |   The Ultimate Termux Suite               |${RS}"
    echo -e "${R}    |                                          |${RS}"
    echo -e "${R}    +------------------------------------------+${RS}"
}

show_banner() {
    clear
    local style="1"; [ -f "$QUINX_HOME/.banner-style" ] && style=$(cat "$QUINX_HOME/.banner-style")
    case $style in 1) banner_style_1 ;; 2) banner_style_2 ;; 3) banner_style_3 ;; 4) banner_style_4 ;; 5) banner_style_5 ;; *) banner_style_1 ;; esac
    echo ""
    echo -e "${M}         +---------------------------------------+${RS}"
    echo -e "${M}         | ${W}Termux Optimization Suite ${D}v${QUINX_VERSION}${M}         |${RS}"
    echo -e "${M}         +---------------------------------------+${RS}"
    # Anime quote or fun fact on boot
    local boot_msg_file=""
    local show_quote=$((RANDOM % 3))
    if [ $show_quote -eq 0 ] && [ -f "$QUINX_HOME/.object/anime-quotes.txt" ]; then
        local total=$(wc -l < "$QUINX_HOME/.object/anime-quotes.txt" 2>/dev/null)
        [ $total -gt 0 ] && local idx=$((RANDOM % total + 1)) && local quote=$(sed -n "${idx}p" "$QUINX_HOME/.object/anime-quotes.txt" 2>/dev/null) && echo -e "${M}    「 ${W}${quote}${M} 」${RS}"
    elif [ $show_quote -eq 1 ] && [ -f "$QUINX_HOME/.object/fun-facts.txt" ]; then
        local total=$(wc -l < "$QUINX_HOME/.object/fun-facts.txt" 2>/dev/null)
        [ $total -gt 0 ] && local idx=$((RANDOM % total + 1)) && local fact=$(sed -n "${idx}p" "$QUINX_HOME/.object/fun-facts.txt" 2>/dev/null) && echo -e "${Y}    💡 ${W}${fact}${RS}"
    fi
    echo ""
}

show_status() {
    local shell_now=$(basename "$SHELL" 2>/dev/null || echo "?")
    local z="${R}✗${RS}"; [ -d "$HOME/.oh-my-zsh" ] && z="${G}✓${RS}"
    local lk="${R}✗${RS}"; grep -q "#QUINX_LOCK_START" ~/.bashrc 2>/dev/null && lk="${G}✓${RS}"; grep -q "#QUINX_LOCK_START" ~/.zshrc 2>/dev/null && lk="${G}✓${RS}"
    local th="Cyber Midnight"; [ -f "$QUINX_HOME/.current-theme" ] && th=$(cat "$QUINX_HOME/.current-theme")
    local pc=$(ls "$QUINX_PLUGINS"/*.sh 2>/dev/null | wc -l)
    local profile="default"; [ -f "$QUINX_HOME/.active-profile" ] && profile=$(cat "$QUINX_HOME/.active-profile")
    draw_top
    print_line "SYSTEM STATUS" "$Y"
    draw_sep
    printf "${C}${left_pad}|${RS}  ${W}Shell:%-7s${RS} Zsh:%-3b${RS} Lock:%-3b${RS} Theme:%-10s${RS} Plugins:%-3s${RS} Profile:%-8s${RS}" \
        "$shell_now" "$z" "$lk" "$th" "$pc" "$profile"
    printf '%*s' $(( BOX_WIDTH - 58 )) "" "${C}|${RS}\n"
    print_line ""
}

# -----------------------------------------------------------
# 1. INTERACTIVE DASHBOARD
# -----------------------------------------------------------
do_dashboard() {
    echo -e "\033[?25l"  # hide cursor
    trap 'echo -e "\033[?25h"; return' INT
    while true; do
        clear
        local now=$(date '+%Y-%m-%d %H:%M:%S')
        local ip=$(ip route get 1.1.1.1 2>/dev/null | grep -oP 'src \K\S+' || echo "N/A")
        local bat="N/A"; [ -f /sys/class/power_supply/battery/capacity ] && bat="$(cat /sys/class/power_supply/battery/capacity 2>/dev/null)%"
        local mem=$(free -m 2>/dev/null | awk '/Mem:/{printf "%dMB/%dMB (%.0f%%)", $3, $2, $3/$2*100}')
        local swap=$(free -m 2>/dev/null | awk '/Swap:/{printf "%dMB/%dMB", $3, $2}')
        local disk=$(df -h / 2>/dev/null | awk 'NR==2{printf "%s/%s (%s)", $3, $2, $5}')
        local cpu=$(top -bn1 2>/dev/null | grep "CPU" | awk '{print $2}' || echo "?")
        local load=$(cat /proc/loadavg 2>/dev/null | awk '{print $1, $2, $3}' || echo "?")
        local procs=$(ps aux 2>/dev/null | wc -l)
        local uptime=$(uptime -p 2>/dev/null || echo "N/A")
        local kernel=$(uname -r 2>/dev/null)
        local arch=$(uname -m 2>/dev/null)

        echo ""
        echo -e "${C}  +----------------------------------------------------------+${RS}"
        echo -e "${C}  |${W}              QUINXOS LIVE DASHBOARD v${QUINX_VERSION}              ${C}|${RS}"
        echo -e "${C}  +----------------------------------------------------------+${RS}"
        echo -e "${C}  |${RS}                                                        ${C}|${RS}"
        echo -e "${C}  |${RS}  ${G}>${RS} Time:      ${W}${now}${RS}                     ${C}|${RS}"
        echo -e "${C}  |${RS}  ${G}>${RS} Uptime:    ${W}${uptime}${RS}                            ${C}|${RS}"
        echo -e "${C}  |${RS}  ${G}>${RS} Kernel:    ${W}${kernel} ${arch}${RS}                   ${C}|${RS}"
        echo -e "${C}  |${RS}                                                        ${C}|${RS}"
        echo -e "${C}  |${RS}  ${Y}>${RS} CPU:       ${W}${cpu}%${RS}  Load: ${W}${load}${RS}           ${C}|${RS}"
        echo -e "${C}  |${RS}  ${Y}>${RS} Memory:    ${W}${mem}${RS}                        ${C}|${RS}"
        echo -e "${C}  |${RS}  ${Y}>${RS} Swap:      ${W}${swap}${RS}                            ${C}|${RS}"
        echo -e "${C}  |${RS}  ${Y}>${RS} Disk:      ${W}${disk}${RS}                       ${C}|${RS}"
        echo -e "${C}  |${RS}                                                        ${C}|${RS}"
        echo -e "${C}  |${RS}  ${B}>${RS} Network:   ${W}IP: ${ip}${RS}                           ${C}|${RS}"
        echo -e "${C}  |${RS}  ${B}>${RS} Battery:   ${W}${bat}${RS}                                   ${C}|${RS}"
        echo -e "${C}  |${RS}  ${B}>${RS} Processes: ${W}${procs}${RS}                                     ${C}|${RS}"
        echo -e "${C}  |${RS}                                                        ${C}|${RS}"
        echo -e "${C}  +----------------------------------------------------------+${RS}"
        echo -e "${C}  |${RS}  ${D}Top Processes by CPU:${RS}                                  ${C}|${RS}"
        ps aux 2>/dev/null | sort -nrk 3 | head -5 | while IFS= read -r line; do
            printf "${C}  |${RS}  ${W}%-56s${RS}${C}|${RS}\n" "$(echo "$line" | awk '{printf "%-8s %5s%% %5s%% %s", $1, $3, $4, $11}')"
        done
        echo -e "${C}  |${RS}                                                        ${C}|${RS}"
        echo -e "${C}  +----------------------------------------------------------+${RS}"
        echo -e "${C}  |${RS}  ${D}Refreshing every 2s -- Press Ctrl+C to exit${RS}             ${C}|${RS}"
        echo -e "${C}  +----------------------------------------------------------+${RS}"
        sleep 2
    done
    echo -e "\033[?25h"
}

# -----------------------------------------------------------
# 2. FINGERPRINT LOCK
# -----------------------------------------------------------
do_fingerprint_lock() {
    clear; show_banner; draw_top
    print_line "FINGERPRINT LOCK" "$Y"
    draw_sep
    if ! command -v termux-fingerprint &>/dev/null; then
        print_line "termux-api not installed!" "$R"
        print_line "Run: pkg install termux-api" "$D"
        print_line "Then: termux-setup-storage" "$D"
        draw_bot; echo ""
        echo -ne "${left_pad}${C}  Press Enter...${RS}"; read -r; return
    fi
    print_line "Use biometric auth instead of password" "$D"
    draw_sep
    print_item "1" "Enable Fingerprint" "Lock with biometric" "$G"
    print_item "2" "Disable           " "Remove fingerprint lock" "$R"
    draw_sep
    print_item "0" "Back              " "Return to menu" "$R"
    draw_bot; echo ""
    echo -ne "${left_pad}${C}  Selection ❯ ${RS}"
    read -r fp_choice
    case $fp_choice in
        1)
            local fp_code='#QUINX_FINGERPRINT_START
clear
echo -e "\033[1;36m  +-------------------------------------+"
echo -e "  |     QUINX SHIELD — BIOMETRIC        |"
echo -e "  +-------------------------------------+\033[0m"
attempt=1
while [ $attempt -le 3 ]; do
    echo -e "\n\033[1;33m  Touch sensor to authenticate...\033[0m"
    result=$(termux-fingerprint 2>/dev/null)
    if echo "$result" | grep -q "AUTH_RESULT_SUCCESS"; then
        echo -e "\033[1;32m  ✓ BIOMETRIC AUTH SUCCESSFUL\033[0m"
        sleep 1; clear; break
    else
        echo -e "\033[1;31m  ✗ AUTH FAILED (Attempt $attempt/3)\033[0m"
        if [ $attempt -eq 3 ]; then
            echo -e "\033[1;31m  ✗ TOO MANY ATTEMPTS. SESSION TERMINATED.\033[0m"; exit
        fi
        attempt=$((attempt + 1))
    fi
done
#QUINX_FINGERPRINT_END'
            echo "$fp_code" > "$QUINX_HOME/.fp-lock"
            # Inject into shell rc
            for rc in ~/.bashrc ~/.zshrc; do
                [ -f "$rc" ] || continue
                sed -i '/#QUINX_FINGERPRINT_START/,/#QUINX_FINGERPRINT_END/d' "$rc"
                echo "$fp_code" > "$rc.tmp"; cat "$rc" >> "$rc.tmp"; mv "$rc.tmp" "$rc"
            done
            clear; show_banner; draw_top
            print_line "FINGERPRINT LOCK ACTIVATED ✓" "$G"
            draw_bot; sleep 2 ;;
        2)
            for rc in ~/.bashrc ~/.zshrc; do
                [ -f "$rc" ] && sed -i '/#QUINX_FINGERPRINT_START/,/#QUINX_FINGERPRINT_END/d' "$rc"
            done
            rm -f "$QUINX_HOME/.fp-lock"
            clear; show_banner; draw_top
            print_line "FINGERPRINT LOCK REMOVED" "$R"
            draw_bot; sleep 2 ;;
    esac
}

# -----------------------------------------------------------
# 3. COMMAND PALETTE
# -----------------------------------------------------------
do_command_palette() {
    clear; show_banner; draw_top
    print_line "COMMAND PALETTE" "$Y"
    draw_sep
    print_line "Type to search features, aliases, plugins" "$D"
    draw_sep
    print_line ""
    draw_bot; echo ""
    echo -ne "${left_pad}${C}  Search ❯ ${RS}"
    read -r query
    [ -z "$query" ] && return

    echo ""
    echo -e "${C}  -- Results --${RS}"

    # Search menu options
    local menu_items=("Core Setup" "Zsh Config" "Switch Zsh" "Switch Bash" "Banner Style" "Custom Theme" "Zsh Plugins" "Theme Gallery" "Dev Tools" "Quick Commands" "Aliases Manager" "Plugin System" "Custom ASCII Art" "Login Sound" "System Info" "Network Info" "MOTD Editor" "Backup Restore" "Quinx Shield" "Remove Lock" "Update" "Uninstall" "RGB Animation" "Dashboard" "Fingerprint Lock" "Command Palette" "Dotfiles Sync" "Theme Builder" "Profiles" "Git Dashboard" "Termux Hooks" "QuinxBench" "Startup Timer" "Color Export")
    local idx=1
    for item in "${menu_items[@]}"; do
        if echo "$item" | grep -qi "$query"; then
            echo -e "  ${G}[$idx]${RS} $item"
        fi
        idx=$((idx + 1))
    done

    # Search aliases
    if [ -f "$QUINX_HOME/.quinx-aliases" ]; then
        local alias_match=$(grep -i "$query" "$QUINX_HOME/.quinx-aliases" 2>/dev/null)
        [ -n "$alias_match" ] && echo -e "\n  ${Y}Aliases:${RS}\n  $alias_match"
    fi

    # Search plugins
    for p in "$QUINX_PLUGINS"/*.sh; do
        [ -f "$p" ] || continue
        if grep -qi "$query\|quinx-.*$query" "$p" 2>/dev/null; then
            echo -e "  ${B}Plugin:${RS} $(basename "$p" .sh)"
        fi
    done

    echo ""
    echo -ne "${left_pad}${C}  Press Enter...${RS}"
    read -r
}

# -----------------------------------------------------------
# 4. DOTFILES SYNC
# -----------------------------------------------------------
do_dotfiles_sync() {
    while true; do
        clear; show_banner; draw_top
        print_line "DOTFILES SYNC" "$Y"
        draw_sep
        print_line "Sync configs to GitHub" "$D"
        draw_sep
        print_item "1" "Push Configs   " "Upload to GitHub repo" "$G"
        print_item "2" "Pull Configs   " "Download from GitHub" "$G"
        print_item "3" "Set Repo URL   " "Configure sync repo" "$B"
        print_item "4" "View Synced    " "Show tracked files" "$B"
        draw_sep
        print_item "0" "Back           " "Return to menu" "$R"
        draw_bot; echo ""
        echo -ne "${left_pad}${C}  Selection ❯ ${RS}"
        read -r df_choice
        case $df_choice in
            1)
                local repo_url=$(cat "$QUINX_HOME/.dotfiles-repo" 2>/dev/null)
                if [ -z "$repo_url" ]; then
                    echo -e "\n${left_pad}${R}  Set repo URL first (option 3)${RS}"; sleep 2; continue
                fi
                local tmpdir=$(mktemp -d)
                cd "$tmpdir" && git init 2>/dev/null
                for f in ~/.zshrc ~/.bashrc ~/.gitconfig ~/.ssh/config; do
                    [ -f "$f" ] && cp "$f" .
                done
                [ -d ~/.termux ] && cp -r ~/.termux .
                [ -f "$QUINX_HOME/.current-theme" ] && cp "$QUINX_HOME/.current-theme" .
                [ -f "$QUINX_HOME/.banner-style" ] && cp "$QUINX_HOME/.banner-style" .
                [ -f "$QUINX_HOME/.quinx-aliases" ] && cp "$QUINX_HOME/.quinx-aliases" .
                git add . && git commit -m "dotfiles: $(date +%Y%m%d-%H%M%S)" 2>/dev/null
                git remote add origin "$repo_url" 2>/dev/null
                git push -u origin main --force 2>&1 | tail -3
                rm -rf "$tmpdir"
                echo -e "\n${left_pad}${G}  ✓ Configs pushed!${RS}"; sleep 2 ;;
            2)
                local repo_url=$(cat "$QUINX_HOME/.dotfiles-repo" 2>/dev/null)
                [ -z "$repo_url" ] && echo -e "\n${left_pad}${R}  Set repo URL first${RS}" && sleep 2 && continue
                local tmpdir=$(mktemp -d)
                git clone "$repo_url" "$tmpdir" 2>/dev/null
                [ -f "$tmpdir/.zshrc" ] && cp "$tmpdir/.zshrc" ~/.zshrc
                [ -f "$tmpdir/.bashrc" ] && cp "$tmpdir/.bashrc" ~/.bashrc
                [ -f "$tmpdir/.gitconfig" ] && cp "$tmpdir/.gitconfig" ~/.gitconfig
                [ -d "$tmpdir/.termux" ] && cp -r "$tmpdir/.termux/"* ~/.termux/ 2>/dev/null
                [ -f "$tmpdir/.current-theme" ] && cp "$tmpdir/.current-theme" "$QUINX_HOME/"
                [ -f "$tmpdir/.banner-style" ] && cp "$tmpdir/.banner-style" "$QUINX_HOME/"
                [ -f "$tmpdir/.quinx-aliases" ] && cp "$tmpdir/.quinx-aliases" "$QUINX_HOME/"
                rm -rf "$tmpdir"
                echo -e "\n${left_pad}${G}  ✓ Configs restored!${RS}"; sleep 2 ;;
            3)
                echo ""
                echo -ne "${left_pad}${C}  GitHub repo URL: ${RS}"
                read -r repo_input
                [ -n "$repo_input" ] && echo "$repo_input" > "$QUINX_HOME/.dotfiles-repo"
                echo -e "${left_pad}${G}  ✓ Saved${RS}"; sleep 2 ;;
            4)
                echo ""
                echo -e "${left_pad}${W}  Tracked files:${RS}"
                for f in ".zshrc" ".bashrc" ".gitconfig" ".termux/" ".current-theme" ".banner-style" ".quinx-aliases"; do
                    echo -e "  ${G}•${RS} $f"
                done
                echo ""; echo -ne "${left_pad}${C}  Press Enter...${RS}"; read -r ;;
            0) return ;;
        esac
    done
}

# -----------------------------------------------------------
# 5. THEME BUILDER
# -----------------------------------------------------------
do_theme_builder() {
    clear; show_banner; draw_top
    print_line "THEME BUILDER" "$Y"
    draw_sep
    print_line "Create custom color scheme" "$D"
    draw_sep
    print_line "Enter hex colors (e.g., #0d1117)" "$D"
    print_line ""
    draw_bot; echo ""

    local colors=()
    local labels=("Background" "Foreground" "Cursor" "Black" "Bright Black" "Red" "Bright Red" "Green" "Bright Green" "Yellow" "Bright Yellow" "Blue" "Bright Blue" "Magenta" "Bright Magenta" "Cyan" "Bright Cyan" "White" "Bright White")
    local defaults=("#0d1117" "#c9d1d9" "#00e5ff" "#0d1117" "#484f58" "#ff4757" "#ff6b81" "#2ed573" "#7bed9f" "#ffa502" "#ffc048" "#1e90ff" "#54a0ff" "#a855f7" "#c084fc" "#00e5ff" "#67e8f9" "#c9d1d9" "#f0f6fc")
    local keys=("background" "foreground" "cursor" "color0" "color8" "color1" "color9" "color2" "color10" "color3" "color11" "color4" "color12" "color5" "color13" "color6" "color14" "color7" "color15")

    for i in {0..18}; do
        echo -ne "${left_pad}${C}  ${labels[$i]} [${D}${defaults[$i]}${C}]: ${RS}"
        read -r color_val
        [ -z "$color_val" ] && color_val="${defaults[$i]}"
        colors[$i]="$color_val"
    done

    echo -ne "\n${left_pad}${C}  Theme name: ${RS}"
    read -r theme_name
    [ -z "$theme_name" ] && theme_name="Custom"

    local theme_file="$QUINX_THEMES/$(echo "$theme_name" | tr ' ' '-' | tr '[:upper:]' '[:lower:]').colors"
    echo "# $theme_name — Custom theme by QuinxOS Theme Builder" > "$theme_file"
    for i in {0..18}; do
        echo "${keys[$i]}=${colors[$i]}" >> "$theme_file"
    done

    cp "$theme_file" ~/.termux/colors.properties 2>/dev/null
    echo "$theme_name" > "$QUINX_HOME/.current-theme"
    termux-reload-settings 2>/dev/null

    clear; show_banner; draw_top
    print_line "THEME CREATED: $theme_name ✓" "$G"
    print_line "Saved: $theme_file" "$D"
    draw_bot; sleep 2
}

# -----------------------------------------------------------
# 6. PROFILE SYSTEM
# -----------------------------------------------------------
do_profiles() {
    while true; do
        clear; show_banner; draw_top
        print_line "PROFILE SYSTEM" "$Y"
        draw_sep
        print_line "Multiple configs for different contexts" "$D"
        draw_sep

        local active="default"; [ -f "$QUINX_HOME/.active-profile" ] && active=$(cat "$QUINX_HOME/.active-profile")
        printf "${C}${left_pad}|${RS}  ${W}Active Profile: ${G}%-20s${RS}" "$active"
        printf '%*s' $(( BOX_WIDTH - 2 - 32 )) "" "${C}|${RS}\n"
        draw_sep

        print_item "1" "Create Profile  " "New named profile" "$G"
        print_item "2" "Switch Profile  " "Load a profile" "$G"
        print_item "3" "List Profiles   " "Show all profiles" "$B"
        print_item "4" "Delete Profile  " "Remove a profile" "$R"
        print_item "5" "Save Current    " "Snapshot current config" "$Y"
        draw_sep
        print_item "0" "Back            " "Return to menu" "$R"
        draw_bot; echo ""
        echo -ne "${left_pad}${C}  Selection ❯ ${RS}"
        read -r prof_choice
        case $prof_choice in
            1)
                echo ""
                echo -ne "${left_pad}${C}  Profile name: ${RS}"
                read -r prof_name
                [ -z "$prof_name" ] && continue
                local prof_dir="$QUINX_PROFILES/$prof_name"
                mkdir -p "$prof_dir"
                echo "$prof_name" > "$QUINX_HOME/.active-profile"
                echo -e "${left_pad}${G}  ✓ Profile '$prof_name' created & active${RS}"; sleep 2 ;;
            2)
                echo ""
                local profiles=($(ls "$QUINX_PROFILES" 2>/dev/null))
                [ ${#profiles[@]} -eq 0 ] && echo -e "${left_pad}${D}  No profiles yet${RS}" && sleep 2 && continue
                for i in "${!profiles[@]}"; do
                    echo -e "  ${W}[$((i+1))]${G} ${profiles[$i]}${RS}"
                done
                echo ""
                echo -ne "${left_pad}${C}  Select: ${RS}"
                read -r prof_idx
                local selected="${profiles[$((prof_idx-1))]}"
                [ -z "$selected" ] && continue
                local prof_dir="$QUINX_PROFILES/$selected"
                # Apply profile
                [ -f "$prof_dir/.zshrc" ] && cp "$prof_dir/.zshrc" ~/.zshrc
                [ -f "$prof_dir/.current-theme" ] && cp "$prof_dir/.current-theme" "$QUINX_HOME/" && cp "$QUINX_THEMES/$(cat "$prof_dir/.current-theme" | tr ' ' '-' | tr '[:upper:]' '[:lower:]').colors" ~/.termux/colors.properties 2>/dev/null
                [ -f "$prof_dir/.banner-style" ] && cp "$prof_dir/.banner-style" "$QUINX_HOME/"
                [ -f "$prof_dir/.quinx-aliases" ] && cp "$prof_dir/.quinx-aliases" "$QUINX_HOME/"
                echo "$selected" > "$QUINX_HOME/.active-profile"
                echo -e "${left_pad}${G}  ✓ Switched to: $selected${RS}"; sleep 2 ;;
            3)
                echo ""
                echo -e "${left_pad}${W}  Profiles:${RS}"
                ls "$QUINX_PROFILES" 2>/dev/null | while read p; do
                    [ "$p" = "$active" ] && echo -e "  ${G}●${RS} $p (active)" || echo -e "  ${D}○${RS} $p"
                done
                [ ! -d "$QUINX_PROFILES" ] && echo -e "  ${D}No profiles yet${RS}"
                echo ""; echo -ne "${left_pad}${C}  Press Enter...${RS}"; read -r ;;
            4)
                echo ""
                echo -ne "${left_pad}${C}  Profile to delete: ${RS}"
                read -r del_name
                [ -d "$QUINX_PROFILES/$del_name" ] && rm -rf "$QUINX_PROFILES/$del_name" && echo -e "${left_pad}${G}  ✓ Deleted${RS}" || echo -e "${left_pad}${R}  Not found${RS}"
                sleep 2 ;;
            5)
                local prof_dir="$QUINX_PROFILES/$active"
                mkdir -p "$prof_dir"
                [ -f ~/.zshrc ] && cp ~/.zshrc "$prof_dir/"
                [ -f "$QUINX_HOME/.current-theme" ] && cp "$QUINX_HOME/.current-theme" "$prof_dir/"
                [ -f "$QUINX_HOME/.banner-style" ] && cp "$QUINX_HOME/.banner-style" "$prof_dir/"
                [ -f "$QUINX_HOME/.quinx-aliases" ] && cp "$QUINX_HOME/.quinx-aliases" "$prof_dir/"
                echo -e "${left_pad}${G}  ✓ Current config saved to '$active'${RS}"; sleep 2 ;;
            0) return ;;
        esac
    done
}

# -----------------------------------------------------------
# 7. GIT DASHBOARD
# -----------------------------------------------------------
do_git_dashboard() {
    clear; show_banner; draw_top
    print_line "GIT DASHBOARD" "$Y"
    draw_sep

    if ! git rev-parse --is-inside-work-tree &>/dev/null; then
        print_line "Not inside a git repository" "$R"
        print_line "Navigate to a repo first" "$D"
        draw_bot; echo ""
        echo -ne "${left_pad}${C}  Press Enter...${RS}"; read -r; return
    fi

    local branch=$(git symbolic-ref --short HEAD 2>/dev/null || echo "detached")
    local remote=$(git remote get-url origin 2>/dev/null || echo "none")
    local commits=$(git rev-list --count HEAD 2>/dev/null || echo "0")
    local changed=$(git status --porcelain 2>/dev/null | wc -l)
    local ahead=$(git rev-list --count @{u}..HEAD 2>/dev/null || echo "0")
    local behind=$(git rev-list --count HEAD..@{u} 2>/dev/null || echo "0")
    local last_commit=$(git log -1 --format="%ar" 2>/dev/null || echo "N/A")
    local author=$(git log -1 --format="%an" 2>/dev/null || echo "N/A")
    local stashes=$(git stash list 2>/dev/null | wc -l)
    local tags=$(git tag 2>/dev/null | wc -l)

    printf "${C}${left_pad}|${RS}  ${W}Branch:${RS}    ${G}%-30s${RS}" "$branch"
    printf '%*s' $(( BOX_WIDTH - 2 - 35 )) "" "${C}|${RS}\n"
    printf "${C}${left_pad}|${RS}  ${W}Remote:${RS}    ${G}%-30s${RS}" "$remote"
    printf '%*s' $(( BOX_WIDTH - 2 - 35 )) "" "${C}|${RS}\n"
    printf "${C}${left_pad}|${RS}  ${W}Commits:${RS}   ${G}%-30s${RS}" "$commits"
    printf '%*s' $(( BOX_WIDTH - 2 - 35 )) "" "${C}|${RS}\n"
    printf "${C}${left_pad}|${RS}  ${W}Changed:${RS}   ${G}%-30s${RS}" "$changed files"
    printf '%*s' $(( BOX_WIDTH - 2 - 35 )) "" "${C}|${RS}\n"
    printf "${C}${left_pad}|${RS}  ${W}Ahead:${RS}     ${G}%-30s${RS}" "$ahead commits"
    printf '%*s' $(( BOX_WIDTH - 2 - 35 )) "" "${C}|${RS}\n"
    printf "${C}${left_pad}|${RS}  ${W}Behind:${RS}    ${G}%-30s${RS}" "$behind commits"
    printf '%*s' $(( BOX_WIDTH - 2 - 35 )) "" "${C}|${RS}\n"
    printf "${C}${left_pad}|${RS}  ${W}Stashes:${RS}   ${G}%-30s${RS}" "$stashes"
    printf '%*s' $(( BOX_WIDTH - 2 - 35 )) "" "${C}|${RS}\n"
    printf "${C}${left_pad}|${RS}  ${W}Tags:${RS}      ${G}%-30s${RS}" "$tags"
    printf '%*s' $(( BOX_WIDTH - 2 - 35 )) "" "${C}|${RS}\n"
    printf "${C}${left_pad}|${RS}  ${W}Author:${RS}    ${G}%-30s${RS}" "$author"
    printf '%*s' $(( BOX_WIDTH - 2 - 35 )) "" "${C}|${RS}\n"
    printf "${C}${left_pad}|${RS}  ${W}Last:${RS}      ${G}%-30s${RS}" "$last_commit"
    printf '%*s' $(( BOX_WIDTH - 2 - 35 )) "" "${C}|${RS}\n"

    draw_sep
    print_line "RECENT COMMITS" "$Y"
    draw_sep
    git log --oneline -5 2>/dev/null | while IFS= read -r line; do
        printf "${C}${left_pad}|${RS}  ${W}%-56s${RS}" "$line"
        printf '%*s' $(( BOX_WIDTH - 2 - 58 )) "" "${C}|${RS}\n"
    done

    draw_sep
    print_line "CHANGED FILES" "$Y"
    draw_sep
    git status --short 2>/dev/null | head -8 | while IFS= read -r line; do
        printf "${C}${left_pad}|${RS}  ${W}%-56s${RS}" "$line"
        printf '%*s' $(( BOX_WIDTH - 2 - 58 )) "" "${C}|${RS}\n"
    done

    print_line ""
    draw_bot; echo ""
    echo -ne "${left_pad}${C}  Press Enter...${RS}"; read -r
}

# -----------------------------------------------------------
# 8. TERMUX API HOOKS
# -----------------------------------------------------------
do_termux_hooks() {
    while true; do
        clear; show_banner; draw_top
        print_line "TERMUX API HOOKS" "$Y"
        draw_sep
        if ! command -v termux-battery-status &>/dev/null; then
            print_line "termux-api not installed!" "$R"
            print_line "Run: pkg install termux-api" "$D"
            draw_bot; echo ""
            echo -ne "${left_pad}${C}  Press Enter...${RS}"; read -r; return
        fi
        print_item "1" "Battery Status  " "Show battery info" "$G"
        print_item "2" "Location        " "Get GPS coordinates" "$G"
        print_item "3" "Notifications   " "List notifications" "$B"
        print_item "4" "Battery Alert   " "Alert when low battery" "$Y"
        print_item "5" "Clipboard       " "Get/set clipboard" "$B"
        print_item "6" "Vibrate         " "Vibrate device" "$M"
        print_item "7" "Torch           " "Toggle flashlight" "$M"
        draw_sep
        print_item "0" "Back            " "Return to menu" "$R"
        draw_bot; echo ""
        echo -ne "${left_pad}${C}  Selection ❯ ${RS}"
        read -r hook_choice
        case $hook_choice in
            1)
                clear; show_banner; draw_top
                print_line "BATTERY STATUS" "$Y"; draw_sep
                local bat_info=$(termux-battery-status 2>/dev/null)
                echo "$bat_info" | python3 -c "
import sys,json
try:
    d=json.load(sys.stdin)
    for k,v in d.items():
        print(f'  {k}: {v}')
except: print('  Failed to parse')
" 2>/dev/null
                draw_bot; echo ""
                echo -ne "${left_pad}${C}  Press Enter...${RS}"; read -r ;;
            2)
                clear; show_banner; draw_top
                print_line "LOCATION" "$Y"; draw_sep
                local loc=$(termux-location 2>/dev/null)
                echo "$loc" | python3 -c "
import sys,json
try:
    d=json.load(sys.stdin)
    print(f'  Latitude:  {d.get(\"latitude\",\"N/A\")}')
    print(f'  Longitude: {d.get(\"longitude\",\"N/A\")}')
    print(f'  Altitude:  {d.get(\"altitude\",\"N/A\")}')
    print(f'  Accuracy:  {d.get(\"accuracy\",\"N/A\")}')
except: print('  Failed to get location')
" 2>/dev/null
                draw_bot; echo ""
                echo -ne "${left_pad}${C}  Press Enter...${RS}"; read -r ;;
            3)
                termux-notification-list 2>/dev/null | head -10
                echo ""; echo -ne "${left_pad}${C}  Press Enter...${RS}"; read -r ;;
            4)
                echo -ne "\n${left_pad}${C}  Alert below (e.g., 20%): ${RS}"
                read -r threshold
                [ -n "$threshold" ] && echo -e "${left_pad}${G}  ✓ Battery alert set at ${threshold}%. Add to HEARTBEAT.md.${RS}"
                sleep 2 ;;
            5)
                echo -e "\n${left_pad}${W}  Clipboard: $(termux-clipboard-get 2>/dev/null || echo 'empty')${RS}"
                echo -ne "${left_pad}${C}  Set clipboard (or Enter to skip): ${RS}"
                read -r clip_val
                [ -n "$clip_val" ] && termux-clipboard-set "$clip_val" && echo -e "${left_pad}${G}  ✓ Set${RS}"
                sleep 2 ;;
            6) termux-vibrate 2>/dev/null; echo -e "${left_pad}${G}  ✓ Vibrated${RS}"; sleep 1 ;;
            7)
                local torch_state=$(cat "$QUINX_HOME/.torch-state" 2>/dev/null || echo "off")
                if [ "$torch_state" = "off" ]; then
                    termux-torch on 2>/dev/null; echo "on" > "$QUINX_HOME/.torch-state"
                    echo -e "${left_pad}${G}  ✓ Torch ON${RS}"
                else
                    termux-torch off 2>/dev/null; echo "off" > "$QUINX_HOME/.torch-state"
                    echo -e "${left_pad}${G}  ✓ Torch OFF${RS}"
                fi; sleep 1 ;;
            0) return ;;
        esac
    done
}

# -----------------------------------------------------------
# 9. QUINXBENCH
# -----------------------------------------------------------
do_bench() {
    clear; show_banner; draw_top
    print_line "QUINXBENCH — SYSTEM BENCHMARK" "$Y"
    draw_sep
    print_line "Running tests..." "$D"
    draw_bot; echo ""

    # CPU benchmark
    echo -ne "${left_pad}${C}  CPU (prime calc):   ${RS}"
    local start=$(date +%s%N)
    python3 -c "
n=0
for i in range(2,1000):
    if all(i%j for j in range(2,i)): n+=1
" 2>/dev/null
    local end=$(date +%s%N)
    local cpu_ms=$(( (end - start) / 1000000 ))
    echo -e "${W}${cpu_ms}ms${RS}"

    # Disk write
    echo -ne "${left_pad}${C}  Disk (write 10MB):  ${RS}"
    start=$(date +%s%N)
    dd if=/dev/zero of=/tmp/quinx-bench bs=1M count=10 2>/dev/null
    end=$(date +%s%N)
    local disk_ms=$(( (end - start) / 1000000 ))
    rm -f /tmp/quinx-bench
    echo -e "${W}${disk_ms}ms${RS}"

    # Disk read
    dd if=/dev/zero of=/tmp/quinx-bench bs=1M count=10 2>/dev/null
    echo -ne "${left_pad}${C}  Disk (read 10MB):   ${RS}"
    start=$(date +%s%N)
    dd if=/tmp/quinx-bench of=/dev/null bs=1M 2>/dev/null
    end=$(date +%s%N)
    local read_ms=$(( (end - start) / 1000000 ))
    rm -f /tmp/quinx-bench
    echo -e "${W}${read_ms}ms${RS}"

    # Network
    echo -ne "${left_pad}${C}  Network (ping):     ${RS}"
    local ping_ms=$(ping -c3 -W3 8.8.8.8 2>/dev/null | tail -1 | awk -F'/' '{print $5}')
    echo -e "${W}${ping_ms:-N/A}ms avg${RS}"

    # Memory
    echo -ne "${left_pad}${C}  Memory speed:       ${RS}"
    local mem_speed=$(free -m 2>/dev/null | awk '/Mem:/{printf "%.0f%% used", $3/$2*100}')
    echo -e "${W}${mem_speed}${RS}"

    # Score
    local total=$(( cpu_ms + disk_ms + read_ms ))
    echo ""
    draw_sep
    if [ $total -lt 500 ]; then
        print_line "SCORE: EXCELLENT ★★★★★" "$G"
    elif [ $total -lt 1500 ]; then
        print_line "SCORE: GOOD ★★★★" "$Y"
    elif [ $total -lt 3000 ]; then
        print_line "SCORE: AVERAGE ★★★" "$Y"
    else
        print_line "SCORE: SLOW ★★" "$R"
    fi
    draw_bot; echo ""
    echo -ne "${left_pad}${C}  Press Enter...${RS}"; read -r
}

# -----------------------------------------------------------
# 10. STARTUP TIMER
# -----------------------------------------------------------
do_startup_timer() {
    clear; show_banner; draw_top
    print_line "STARTUP TIMER" "$Y"
    draw_sep
    print_line "Measures shell boot time" "$D"
    draw_sep
    print_item "1" "Enable Timer   " "Show load time at boot" "$G"
    print_item "2" "Disable Timer  " "Remove from boot" "$R"
    print_item "3" "Test Now       " "Measure current boot" "$B"
    draw_sep
    print_item "0" "Back           " "Return to menu" "$R"
    draw_bot; echo ""
    echo -ne "${left_pad}${C}  Selection ❯ ${RS}"
    read -r timer_choice
    case $timer_choice in
        1)
            local timer_code='
# QuinxOS Startup Timer
_QUINX_START=$(date +%s%N)'
            local timer_end='
_QUINX_END=$(date +%s%N)
_QUINX_MS=$(( (_QUINX_END - _QUINX_START) / 1000000 ))
echo -e "\033[2m  Shell loaded in ${_QUINX_MS}ms\033[0m"'
            # Add to top and bottom of zshrc
            for rc in ~/.zshrc ~/.bashrc; do
                [ -f "$rc" ] || continue
                sed -i '/# QuinxOS Startup Timer/d' "$rc"
                sed -i '/_QUINX_START=/d' "$rc"
                sed -i '/_QUINX_END=/d' "$rc"
                sed -i '/_QUINX_MS=/d' "$rc"
                sed -i '/Shell loaded in/d' "$rc"
                # Add timer start at top
                echo "$timer_code" > "$rc.tmp"; cat "$rc" >> "$rc.tmp"; mv "$rc.tmp" "$rc"
                # Add timer end at bottom
                echo "$timer_end" >> "$rc"
            done
            clear; show_banner; draw_top
            print_line "STARTUP TIMER ENABLED ✓" "$G"
            draw_bot; sleep 2 ;;
        2)
            for rc in ~/.zshrc ~/.bashrc; do
                [ -f "$rc" ] || continue
                sed -i '/# QuinxOS Startup Timer/d' "$rc"
                sed -i '/_QUINX_START=/d' "$rc"
                sed -i '/_QUINX_END=/d' "$rc"
                sed -i '/_QUINX_MS=/d' "$rc"
                sed -i '/Shell loaded in/d' "$rc"
            done
            clear; show_banner; draw_top
            print_line "STARTUP TIMER DISABLED" "$R"
            draw_bot; sleep 2 ;;
        3)
            echo ""
            echo -e "${left_pad}${C}  Measuring boot time...${RS}"
            local start=$(date +%s%N)
            source ~/.zshrc 2>/dev/null || source ~/.bashrc 2>/dev/null
            local end=$(date +%s%N)
            local ms=$(( (end - start) / 1000000 ))
            echo -e "\n${left_pad}${G}  Shell load time: ${W}${ms}ms${RS}"
            echo ""; echo -ne "${left_pad}${C}  Press Enter...${RS}"; read -r ;;
    esac
}

# -----------------------------------------------------------
# 11. COLOR SCHEME EXPORT
# -----------------------------------------------------------
do_color_export() {
    clear; show_banner; draw_top
    print_line "COLOR SCHEME EXPORT" "$Y"
    draw_sep
    print_line "Export current theme to other formats" "$D"
    draw_sep
    print_item "1" "Windows Terminal " "JSON format" "$G"
    print_item "2" "iTerm2           " "plist format" "$G"
    print_item "3" "Alacritty        " "YAML format" "$G"
    print_item "4" "Kitty            " "conf format" "$G"
    print_item "5" "All Formats      " "Export everything" "$Y"
    draw_sep
    print_item "0" "Back             " "Return to menu" "$R"
    draw_bot; echo ""
    echo -ne "${left_pad}${C}  Format ❯ ${RS}"
    read -r export_choice

    local current_theme=$(cat "$QUINX_HOME/.current-theme" 2>/dev/null || echo "Cyber Midnight")
    local theme_file="$QUINX_THEMES/$(echo "$current_theme" | tr ' ' '-' | tr '[:upper:]' '[:lower:]').colors"
    [ ! -f "$theme_file" ] && theme_file="$QUINX_THEMES/cyber-midnight.colors"

    # Read colors
    local bg=$(grep '^background=' "$theme_file" | cut -d= -f2)
    local fg=$(grep '^foreground=' "$theme_file" | cut -d= -f2)
    local c0=$(grep '^color0=' "$theme_file" | cut -d= -f2)
    local c1=$(grep '^color1=' "$theme_file" | cut -d= -f2)
    local c2=$(grep '^color2=' "$theme_file" | cut -d= -f2)
    local c3=$(grep '^color3=' "$theme_file" | cut -d= -f2)
    local c4=$(grep '^color4=' "$theme_file" | cut -d= -f2)
    local c5=$(grep '^color5=' "$theme_file" | cut -d= -f2)
    local c6=$(grep '^color6=' "$theme_file" | cut -d= -f2)
    local c7=$(grep '^color7=' "$theme_file" | cut -d= -f2)
    local c8=$(grep '^color8=' "$theme_file" | cut -d= -f2)
    local c9=$(grep '^color9=' "$theme_file" | cut -d= -f2)
    local c10=$(grep '^color10=' "$theme_file" | cut -d= -f2)
    local c11=$(grep '^color11=' "$theme_file" | cut -d= -f2)
    local c12=$(grep '^color12=' "$theme_file" | cut -d= -f2)
    local c13=$(grep '^color13=' "$theme_file" | cut -d= -f2)
    local c14=$(grep '^color14=' "$theme_file" | cut -d= -f2)
    local c15=$(grep '^color15=' "$theme_file" | cut -d= -f2)

    local export_dir="$QUINX_HOME/exports"
    mkdir -p "$export_dir"

    export_windows() {
        cat > "$export_dir/${current_theme}-windows-terminal.json" << EOF
{
    "name": "$current_theme",
    "background": "$bg",
    "foreground": "$fg",
    "cursorColor": "$(grep '^cursor=' "$theme_file" | cut -d= -f2)",
    "black": "$c0",
    "red": "$c1",
    "green": "$c2",
    "yellow": "$c3",
    "blue": "$c4",
    "purple": "$c5",
    "cyan": "$c6",
    "white": "$c7",
    "brightBlack": "$c8",
    "brightRed": "$c9",
    "brightGreen": "$c10",
    "brightYellow": "$c11",
    "brightBlue": "$c12",
    "brightPurple": "$c13",
    "brightCyan": "$c14",
    "brightWhite": "$c15"
}
EOF
    }

    export_iterm2() {
        cat > "$export_dir/${current_theme}-iterm2.itermcolors" << EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Ansi 0 Color</key><dict><key>Hex Color</key><string>$c0</string></dict>
    <key>Ansi 1 Color</key><dict><key>Hex Color</key><string>$c1</string></dict>
    <key>Ansi 2 Color</key><dict><key>Hex Color</key><string>$c2</string></dict>
    <key>Ansi 3 Color</key><dict><key>Hex Color</key><string>$c3</string></dict>
    <key>Ansi 4 Color</key><dict><key>Hex Color</key><string>$c4</string></dict>
    <key>Ansi 5 Color</key><dict><key>Hex Color</key><string>$c5</string></dict>
    <key>Ansi 6 Color</key><dict><key>Hex Color</key><string>$c6</string></dict>
    <key>Ansi 7 Color</key><dict><key>Hex Color</key><string>$c7</string></dict>
    <key>Background Color</key><dict><key>Hex Color</key><string>$bg</string></dict>
    <key>Foreground Color</key><dict><key>Hex Color</key><string>$fg</string></dict>
</dict>
</plist>
EOF
    }

    export_alacritty() {
        cat > "$export_dir/${current_theme}-alacritty.yml" << EOF
# $current_theme — QuinxOS Export
colors:
  primary:
    background: '$bg'
    foreground: '$fg'
  normal:
    black:   '$c0'
    red:     '$c1'
    green:   '$c2'
    yellow:  '$c3'
    blue:    '$c4'
    magenta: '$c5'
    cyan:    '$c6'
    white:   '$c7'
  bright:
    black:   '$c8'
    red:     '$c9'
    green:   '$c10'
    yellow:  '$c11'
    blue:    '$c12'
    magenta: '$c13'
    cyan:    '$c14'
    white:   '$c15'
EOF
    }

    export_kitty() {
        cat > "$export_dir/${current_theme}-kitty.conf" << EOF
# $current_theme — QuinxOS Export
background $bg
foreground $fg
cursor_color $(grep '^cursor=' "$theme_file" | cut -d= -f2)
color0 $c0
color1 $c1
color2 $c2
color3 $c3
color4 $c4
color5 $c5
color6 $c6
color7 $c7
color8 $c8
color9 $c9
color10 $c10
color11 $c11
color12 $c12
color13 $c13
color14 $c14
color15 $c15
EOF
    }

    case $export_choice in
        1) export_windows ;;
        2) export_iterm2 ;;
        3) export_alacritty ;;
        4) export_kitty ;;
        5) export_windows; export_iterm2; export_alacritty; export_kitty ;;
        0) return ;;
    esac

    clear; show_banner; draw_top
    print_line "EXPORTED: $current_theme ✓" "$G"
    print_line "$export_dir/" "$D"
    draw_bot; sleep 2
}

# -----------------------------------------------------------
# EXISTING FEATURES (carried from v4.2)
# -----------------------------------------------------------
generate_recovery_key() { cat /dev/urandom 2>/dev/null | tr -dc 'A-Za-z0-9' | head -c 16; }

do_necessary_setup() {
    clear; show_banner; draw_top; print_line "INSTALLING CORE DEPENDENCIES" "$Y"; draw_sep; print_line "Please wait..." "$D"; draw_bot; echo ""
    apt update -y && apt upgrade -y
    pkg install zsh git figlet toilet ruby wget curl -y; gem install lolcat; pkg install toilet figlet exa -y
    mkdir -p "$QUINX_HOME/.object"
    [ -f "$QUINX_HOME/.object/ANSI Shadow.flf" ] && cp -r "$QUINX_HOME/.object/ANSI Shadow.flf" "$PREFIX/share/figlet/ASCII-Shadow.flf" 2>/dev/null
    git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh 2>/dev/null
    rm -rf ~/.termux/colors.properties; rm -rf /data/data/com.termux/files/usr/etc/motd
    [ -f "$QUINX_HOME/.object/colors.properties" ] && cp -r "$QUINX_HOME/.object/colors.properties" ~/.termux/colors.properties
    [ -f "$QUINX_HOME/.object/termux.properties" ] && cp -r "$QUINX_HOME/.object/termux.properties" ~/.termux.properties
    curl -L https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/FiraCode/Regular/FiraCodeNerdFont-Regular.ttf > ~/.termux/font.ttf 2>/dev/null
    termux-reload-settings 2>/dev/null
    clear; show_banner; draw_top; print_line "SETUP COMPLETE ✓" "$G"; draw_bot; sleep 2
}

do_zsh_setup() {
    clear; show_banner; draw_top; print_line "CONFIGURING ZSH" "$Y"; draw_sep; print_line "Resetting .zshrc..." "$D"; draw_bot
    rm -rf ~/.zshrc; git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh 2>/dev/null
    cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
    clear; show_banner; draw_top; print_line "ZSH SETUP COMPLETE ✓" "$G"; draw_bot; sleep 2
}

do_set_zsh() { pkg install zsh -y; chsh -s zsh; clear; show_banner; draw_top; print_line "DEFAULT SHELL → ZSH ✓" "$G"; draw_bot; sleep 2; }
do_set_bash() { chsh -s bash; clear; show_banner; draw_top; print_line "DEFAULT SHELL → BASH ✓" "$G"; draw_bot; sleep 2; }

do_set_banner() {
    clear; show_banner; draw_top; print_line "BANNER STYLE" "$Y"; draw_sep
    print_item "1" "Block Letters" "Bold gradient" "$C"; print_item "2" "Box Art" "Framed pixel" "$M"; print_item "3" "Clean Box" "Minimal" "$G"
    print_item "4" "Naruto Style" "Anime red/gold" "$Y"; print_item "5" "Military" "AOT dark" "$R"
    draw_sep; print_item "0" "Back" "Return" "$R"; draw_bot; echo ""
    echo -ne "${left_pad}${C}  Style ❯ ${RS}"; read -r s
    case $s in 1|2|3|4|5) echo "$s" > "$QUINX_HOME/.banner-style"; clear; show_banner; draw_top; print_line "BANNER $s SET ✓" "$G"; draw_bot ;; 0) return ;; esac; sleep 2
}

do_set_theme() {
    clear; show_banner; draw_top; print_line "SHELL PROMPT NAME" "$Y"; draw_sep; print_line "Max 12 chars" "$D"; draw_bot; echo ""
    echo -ne "${left_pad}${C}  Name ❯ ${RS}"; read -r n
    [ -f "$QUINX_HOME/.object/quinx.zsh-theme" ] && mkdir -p ~/.oh-my-zsh/themes && sed "s/\PROC/${n}/g" "$QUINX_HOME/.object/quinx.zsh-theme" > ~/.oh-my-zsh/themes/quinx.zsh-theme 2>/dev/null
    clear; show_banner; draw_top; print_line "THEME: ${n}" "$G"; draw_bot; sleep 2
}

do_plugins() {
    clear; show_banner; draw_top; print_line "ZSH PLUGINS" "$Y"; draw_sep; print_line "Highlight + Autosuggestions" "$D"; draw_bot; echo ""
    git clone https://github.com/zsh-users/zsh-autosuggestions "$HOME/.oh-my-zsh/plugins/zsh-autosuggestions" 2>/dev/null
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME/.oh-my-zsh/plugins/zsh-syntax-highlighting" 2>/dev/null
    [ -f "$QUINX_HOME/.object/zshrc-full" ] && sed "s/\PROC/${USER:-Quinx}/g" "$QUINX_HOME/.object/zshrc-full" > ~/.zshrc
    [ -f "$QUINX_HOME/.object/quinx.zsh-theme" ] && mkdir -p ~/.oh-my-zsh/themes && sed "s/\PROC/${USER:-Quinx}/g" "$QUINX_HOME/.object/quinx.zsh-theme" > ~/.oh-my-zsh/themes/quinx.zsh-theme 2>/dev/null
    clear; show_banner; draw_top; print_line "PLUGINS INSTALLED ✓" "$G"; draw_bot; sleep 2
}

do_theme_presets() {
    clear; show_banner; draw_top; print_line "THEME GALLERY — 15 THEMES" "$Y"; draw_sep
    local names=("Cyber Midnight" "Matrix Green" "Solar Flare" "Arctic Blue" "Purple Haze" "Dracacula" "Nord" "Gruvbox" "Tokyo Night" "Catppuccin Mocha" "Everforest" "Monokai" "Synthwave" "Rose Pine" "Kanagawa" "Tokyo Day" "Naruto" "One Piece" "Attack on Titan" "Dragon Ball" "Demon Slayer" "Evangelion")
    local files=("cyber-midnight" "matrix-green" "solar-flare" "arctic-blue" "purple-haze" "dracacula" "nord" "gruvbox" "tokyo-night" "catppuccin-mocha" "everforest" "monokai" "synthwave" "rose-pine" "kanagawa" "tokyo-day" "naruto" "one-piece" "attack-on-titan" "dragon-ball" "demon-slayer" "evangelion")
    local colors=("$C" "$G" "$Y" "$B" "$M" "$M" "$B" "$Y" "$B" "$M" "$G" "$Y" "$R" "$M" "$B" "$W" "$Y" "$R" "$G" "$Y" "$R" "$M")
    for i in {0..21}; do
        local num=$(printf "%02d" $((i+1)))
        printf "${C}${left_pad}|${RS}  ${C}[${W}${num}${C}]${colors[$i]} %-18s${RS}" "${names[$i]}"
        printf '%*s' $(( BOX_WIDTH - 2 - 22 )) "" "${C}|${RS}\n"
    done
    draw_sep; print_item "0" "Back" "Return" "$R"; draw_bot; echo ""
    echo -ne "${left_pad}${C}  Theme ❯ ${RS}"; read -r t
    local idx=$(( ${t:-0} - 1 ))
    [ $idx -lt 0 ] || [ $idx -gt 21 ] && return
    [ -f "$QUINX_THEMES/${files[$idx]}.colors" ] && cp "$QUINX_THEMES/${files[$idx]}.colors" ~/.termux/colors.properties 2>/dev/null
    echo "${names[$idx]}" > "$QUINX_HOME/.current-theme"
    termux-reload-settings 2>/dev/null
    clear; show_banner; draw_top; print_line "APPLIED: ${names[$idx]} ✓" "$G"; draw_bot; sleep 2
}

do_dev_tools() {
    while true; do
        clear; show_banner; draw_top; print_line "DEV TOOLS" "$Y"; draw_sep
        print_item "01" "Python 3" "pip, ipython" "$G"; print_item "02" "Node.js" "npm, yarn" "$G"
        print_item "03" "Go" "compiler" "$G"; print_item "04" "Rust" "cargo" "$G"
        print_item "05" "Ruby" "gem" "$G"; print_item "06" "PHP" "" "$G"
        print_item "07" "Git+SSH" "" "$B"; print_item "08" "Neovim" "" "$B"
        print_item "09" "tmux" "" "$B"; print_item "10" "All Python" "numpy,pandas,flask" "$Y"
        print_item "11" "All Web" "node+php+ruby" "$Y"
        draw_sep; print_item "0" "Back" "Return" "$R"; draw_bot; echo ""
        echo -ne "${left_pad}${C}  ❯ ${RS}"; read -r d
        case $d in
            1|01) clear; pkg install python python-pip -y 2>&1 | tail -3; pip install ipython virtualenv 2>&1 | tail -2; echo -e "\n${G}  ✓ Python${RS}"; sleep 2 ;;
            2|02) clear; pkg install nodejs -y 2>&1 | tail -3; echo -e "\n${G}  ✓ Node.js${RS}"; sleep 2 ;;
            3|03) clear; pkg install golang -y 2>&1 | tail -3; echo -e "\n${G}  ✓ Go${RS}"; sleep 2 ;;
            4|04) clear; pkg install rust -y 2>&1 | tail -3; echo -e "\n${G}  ✓ Rust${RS}"; sleep 2 ;;
            5|05) clear; pkg install ruby -y 2>&1 | tail -3; echo -e "\n${G}  ✓ Ruby${RS}"; sleep 2 ;;
            6|06) clear; pkg install php -y 2>&1 | tail -3; echo -e "\n${G}  ✓ PHP${RS}"; sleep 2 ;;
            7|07) clear; pkg install git openssh -y 2>&1 | tail -3; echo -e "\n${G}  ✓ Git+SSH${RS}"; sleep 2 ;;
            8|08) clear; pkg install neovim -y 2>&1 | tail -3; echo -e "\n${G}  ✓ Neovim${RS}"; sleep 2 ;;
            9|09) clear; pkg install tmux -y 2>&1 | tail -3; echo -e "\n${G}  ✓ tmux${RS}"; sleep 2 ;;
            10) clear; pkg install python python-pip -y 2>&1 | tail -3; pip install numpy pandas flask requests ipython virtualenv 2>&1 | tail -3; echo -e "\n${G}  ✓ Python stack${RS}"; sleep 2 ;;
            11) clear; pkg install nodejs php ruby python -y 2>&1 | tail -3; echo -e "\n${G}  ✓ Web stack${RS}"; sleep 2 ;;
            0|00) return ;;
        esac
    done
}

do_quick_commands() {
    while true; do
        clear; show_banner; draw_top; print_line "QUICK COMMANDS" "$Y"; draw_sep
        print_item "01" "Git Init+Push" "Init & push repo" "$G"
        print_item "02" "Compress" "tar.gz directory" "$G"
        print_item "03" "Find Large" "Top 10 biggest files" "$G"
        print_item "04" "Kill Port" "Kill process on port" "$Y"
        print_item "05" "HTTP Serve" "Local server" "$Y"
        print_item "06" "Disk Usage" "df -h" "$B"
        print_item "07" "Process Top" "Top by CPU" "$B"
        print_item "08" "SSH Keygen" "ed25519 keypair" "$C"
        print_item "09" "WiFi Info" "Network details" "$C"
        draw_sep; print_item "0" "Back" "Return" "$R"; draw_bot; echo ""
        echo -ne "${left_pad}${C}  ❯ ${RS}"; read -r q
        case $q in
            1|01) echo ""; echo -ne "${left_pad}${C}  Repo: ${RS}"; read -r r; [ -n "$r" ] && mkdir -p "$r" && cd "$r" && git init && touch README.md && git add . && git commit -m "init" && cd ..; sleep 2 ;;
            2|02) echo ""; echo -ne "${left_pad}${C}  Folder: ${RS}"; read -r f; [ -d "$f" ] && tar czf "$(basename "$f").tar.gz" "$f" && echo -e "${G}  ✓ Done${RS}"; sleep 2 ;;
            3|03) clear; find / -type f -exec du -h {} + 2>/dev/null | sort -rh | head -10; echo ""; echo -ne "${left_pad}${C}  Enter...${RS}"; read -r ;;
            4|04) echo ""; echo -ne "${left_pad}${C}  Port: ${RS}"; read -r p; local pid=$(lsof -t -i:"$p" 2>/dev/null); [ -n "$pid" ] && kill -9 "$pid" && echo -e "${G}  ✓ Killed${RS}"; sleep 2 ;;
            5|05) echo ""; echo -ne "${left_pad}${C}  Port [8080]: ${RS}"; read -r sp; python3 -m http.server ${sp:-8080} 2>/dev/null ;;
            6|06) clear; df -h; echo ""; echo -ne "${left_pad}${C}  Enter...${RS}"; read -r ;;
            7|07) clear; ps aux | sort -nrk 3 | head -10; echo ""; echo -ne "${left_pad}${C}  Enter...${RS}"; read -r ;;
            8|08) echo ""; echo -ne "${left_pad}${C}  Email: ${RS}"; read -r e; [ -n "$e" ] && ssh-keygen -t ed25519 -C "$e" -f "$HOME/.ssh/id_ed25519" -N "" && cat "$HOME/.ssh/id_ed25519.pub"; echo ""; echo -ne "${left_pad}${C}  Enter...${RS}"; read -r ;;
            9|09) clear; echo "Hostname: $(hostname)"; echo "Local: $(ip route get 1.1.1.1 2>/dev/null | grep -oP 'src \K\S+')"; echo "Public: $(curl -s --max-time 5 ifconfig.me)"; echo ""; echo -ne "${left_pad}${C}  Enter...${RS}"; read -r ;;
            0|00) return ;;
        esac
    done
}

do_aliases_manager() {
    while true; do
        clear; show_banner; draw_top; print_line "ALIASES MANAGER" "$Y"; draw_sep
        print_item "1" "List" "Show aliases" "$G"; print_item "2" "Add" "New alias" "$G"
        print_item "3" "Remove" "Delete alias" "$R"; print_item "4" "Quick" "Common aliases" "$Y"
        draw_sep; print_item "0" "Back" "Return" "$R"; draw_bot; echo ""
        echo -ne "${left_pad}${C}  ❯ ${RS}"; read -r a
        local af="$QUINX_HOME/.quinx-aliases"
        case $a in
            1) clear; show_banner; draw_top; print_line "ALIASES" "$Y"; draw_sep
               [ -f "$af" ] && [ -s "$af" ] && while IFS= read -r l; do printf "${C}${left_pad}|${RS}  ${W}%-56s${RS}" "$l"; printf '%*s' $(( BOX_WIDTH - 60 )) "" "${C}|${RS}\n"; done < "$af" || print_line "None yet" "$D"
               draw_bot; echo ""; echo -ne "${left_pad}${C}  Enter...${RS}"; read -r ;;
            2) echo ""; echo -ne "${left_pad}${C}  Alias: ${RS}"; read -r an; echo -ne "${left_pad}${C}  Command: ${RS}"; read -r ac
               [ -n "$an" ] && [ -n "$ac" ] && echo "alias ${an}='${ac}'" >> "$af" && echo -e "${G}  ✓ Added${RS}"; sleep 2 ;;
            3) [ -f "$af" ] && nl -ba "$af" && echo "" && echo -ne "${left_pad}${C}  Line #: ${RS}" && read -r ln && [ -n "$ln" ] && sed -i "${ln}d" "$af"; sleep 2 ;;
            4) cat >> "$af" << 'A'
alias ll='ls -la' alias la='ls -a' alias cls='clear' alias ..='cd ..' alias ...='cd ../..'
alias update='apt update && apt upgrade -y' alias myip='curl -s ifconfig.me'
alias path='echo -e ${PATH//:/\\n}' alias mkdir='mkdir -pv'
A
               echo -e "${G}  ✓ Common aliases added${RS}"; sleep 2 ;;
            0) return ;;
        esac
    done
}

do_plugin_system() {
    while true; do
        clear; show_banner; draw_top; print_line "PLUGIN SYSTEM" "$Y"; draw_sep
        print_line "Auto-loaded from: .object/plugins/" "$D"; draw_sep
        local cnt=0
        for p in "$QUINX_PLUGINS"/*.sh; do [ -f "$p" ] || continue; printf "${C}${left_pad}|${RS}  ${G}●${RS} %-54s" "$(basename "$p" .sh)"; printf '%*s' $(( BOX_WIDTH - 58 )) "" "${C}|${RS}\n"; cnt=$((cnt+1)); done
        [ $cnt -eq 0 ] && print_line "No plugins" "$D"
        draw_sep; print_item "1" "Create Plugin" "Write new" "$G"; print_item "2" "Plugin Dir" "Open folder" "$B"
        draw_sep; print_item "0" "Back" "Return" "$R"; draw_bot; echo ""
        echo -ne "${left_pad}${C}  ❯ ${RS}"; read -r pc
        case $pc in
            1) echo ""; echo -ne "${left_pad}${C}  Plugin name: ${RS}"; read -r pn
               echo -e "${left_pad}${D}  Code (Ctrl+D done):${RS}"; local nf="$QUINX_PLUGINS/${pn}.sh"
               echo "#!/bin/bash" > "$nf"; echo "# $pn plugin" >> "$nf"; cat >> "$nf"; chmod +x "$nf"
               echo -e "\n${G}  ✓ Created: $pn${RS}"; sleep 2 ;;
            2) echo -e "\n${left_pad}${C}  Dir: $QUINX_PLUGINS${RS}"; echo -ne "${left_pad}${C}  Enter...${RS}"; read -r ;;
            0) return ;;
        esac
    done
}

do_custom_banner_text() {
    clear; show_banner; draw_top; print_line "CUSTOM ASCII ART" "$Y"; draw_sep
    print_line "Current: $(cat "$QUINX_HOME/.custom-banner-text" 2>/dev/null || echo 'PROC')" "$D"
    draw_bot; echo ""
    echo -ne "${left_pad}${C}  New text (max 12): ${RS}"; read -r ct
    [ -n "$ct" ] && echo "$ct" > "$QUINX_HOME/.custom-banner-text"
    clear; show_banner; draw_top; print_line "SET: $ct ✓" "$G"; draw_bot; sleep 2
}

do_login_sound() {
    clear; show_banner; draw_top; print_line "LOGIN SOUND" "$Y"; draw_sep
    print_item "1" "Enable Bell" "Terminal beep" "$G"; print_item "2" "Custom Sound" "Your audio file" "$G"; print_item "3" "Disable" "Silent" "$R"
    draw_sep; print_item "0" "Back" "Return" "$R"; draw_bot; echo ""
    echo -ne "${left_pad}${C}  ❯ ${RS}"; read -r sc
    case $sc in
        1) echo '# bell' > "$QUINX_HOME/.login-sound-mode"; clear; show_banner; draw_top; print_line "BELL ENABLED ✓" "$G"; draw_bot; sleep 2 ;;
        2) echo ""; echo -ne "${left_pad}${C}  File path: ${RS}"; read -r sf; [ -f "$sf" ] && cp "$sf" "$QUINX_HOME/.login-sound" && echo '# custom' > "$QUINX_HOME/.login-sound-mode" && echo -e "${G}  ✓ Set${RS}"; sleep 2 ;;
        3) rm -f "$QUINX_HOME/.login-sound" "$QUINX_HOME/.login-sound-mode"; clear; show_banner; draw_top; print_line "SOUND DISABLED" "$R"; draw_bot; sleep 2 ;;
        0) return ;;
    esac
}

do_sysinfo() {
    clear; show_banner; draw_top; print_line "SYSTEM INFORMATION" "$Y"; draw_sep
    for e in "OS:$(uname -o)" "Arch:$(uname -m)" "Kernel:$(uname -r)" "Uptime:$(uptime -p 2>/dev/null || echo N/A)" "CPU:$(nproc) cores" "Memory:$(free -h 2>/dev/null | awk '/Mem:/{print $3"/"$2}')" "Disk:$(df -h / 2>/dev/null | awk 'NR==2{print $3"/"$2" ("$5")"}')" "Packages:$(dpkg -l 2>/dev/null | grep -c '^ii')"; do
        local k="${e%%:*}"; local v="${e#*:}"; printf "${C}${left_pad}|${RS}  ${W}%-10s${RS} ${G}%-30s${RS}" "$k:" "$v"; printf '%*s' $(( BOX_WIDTH - 42 )) "" "${C}|${RS}\n"
    done
    print_line ""; draw_bot; echo ""; echo -ne "${left_pad}${C}  Enter...${RS}"; read -r
}

do_network_info() {
    clear; show_banner; draw_top; print_line "NETWORK" "$Y"; draw_sep
    for e in "Hostname:$(hostname)" "Local IP:$(ip route get 1.1.1.1 2>/dev/null | grep -oP 'src \K\S+')" "Public IP:$(curl -s --max-time 5 ifconfig.me)" "DNS:$(grep -m1 nameserver /etc/resolv.conf 2>/dev/null | awk '{print $2}')"; do
        local k="${e%%:*}"; local v="${e#*:}"; printf "${C}${left_pad}|${RS}  ${W}%-10s${RS} ${G}%-30s${RS}" "$k:" "$v"; printf '%*s' $(( BOX_WIDTH - 42 )) "" "${C}|${RS}\n"
    done
    draw_sep; print_line "PING TESTS" "$Y"; draw_sep
    for t in "8.8.8.8:Google" "1.1.1.1:Cloudflare"; do
        local a="${t%%:*}"; local n="${t#*:}"; local pt=$(ping -c1 -W3 "$a" 2>/dev/null | grep -oP 'time=\K\S+')
        [ -n "$pt" ] && printf "${C}${left_pad}|${RS}  ${W}%-12s${RS} ${G}✓ %s${RS}" "$n:" "$pt" || printf "${C}${left_pad}|${RS}  ${W}%-12s${RS} ${R}✗ Timeout${RS}" "$n:"
        printf '%*s' $(( BOX_WIDTH - 30 )) "" "${C}|${RS}\n"
    done
    print_line ""; draw_bot; echo ""; echo -ne "${left_pad}${C}  Enter...${RS}"; read -r
}

do_motd_editor() {
    clear; show_banner; draw_top; print_line "MOTD EDITOR" "$Y"; draw_sep
    print_item "1" "Custom MOTD" "Your message" "$G"; print_item "2" "Default" "QuinxOS msg" "$G"; print_item "3" "Disable" "No MOTD" "$R"
    draw_sep; print_item "0" "Back" "Return" "$R"; draw_bot; echo ""
    echo -ne "${left_pad}${C}  ❯ ${RS}"; read -r m
    local mf="/data/data/com.termux/files/usr/etc/motd"
    case $m in
        1) echo ""; echo -ne "${left_pad}${C}  Text: ${RS}"; read -r mt; echo -e "\033[1;96m${mt}\033[0m" > "$mf"; echo -e "${G}  ✓${RS}"; sleep 2 ;;
        2) echo -e "\033[1;96m\n  +---------------------------------------+\n  |        Welcome to QuinxOS v5.0        |\n  |       by Shineii86                    |\n  +---------------------------------------+\n\033[0m" > "$mf"; echo -e "${G}  ✓${RS}"; sleep 2 ;;
        3) rm -f "$mf"; echo -e "${G}  ✓ Disabled${RS}"; sleep 2 ;;
        0) return ;;
    esac
}

do_backup() {
    clear; show_banner; draw_top; print_line "BACKUP & RESTORE" "$Y"; draw_sep
    print_item "1" "Backup" "Save config" "$G"; print_item "2" "Restore" "Load config" "$G"; print_item "0" "Back" "Return" "$R"
    draw_bot; echo ""; echo -ne "${left_pad}${C}  ❯ ${RS}"; read -r bc
    case $bc in
        1) local bd="$QUINX_HOME/backups/$(date +%Y%m%d_%H%M%S)"; mkdir -p "$bd"
           for f in ~/.zshrc ~/.bashrc "$QUINX_HOME/.current-theme" "$QUINX_HOME/.banner-style" "$QUINX_HOME/.quinx-aliases"; do [ -f "$f" ] && cp "$f" "$bd/"; done
           [ -d ~/.termux ] && cp -r ~/.termux "$bd/"
           clear; show_banner; draw_top; print_line "BACKUP SAVED ✓" "$G"; print_line "$bd" "$D"; draw_bot; sleep 2 ;;
        2) local lt=$(ls -t "$QUINX_HOME/backups/" 2>/dev/null | head -1)
           [ -n "$lt" ] && { local bd="$QUINX_HOME/backups/$lt"; [ -f "$bd/.zshrc" ] && cp "$bd/.zshrc" ~/.zshrc; [ -f "$bd/.bashrc" ] && cp "$bd/.bashrc" ~/.bashrc; [ -d "$bd/.termux" ] && cp -r "$bd/.termux/"* ~/.termux/ 2>/dev/null; clear; show_banner; draw_top; print_line "RESTORED ✓" "$G"; draw_bot; } || echo -e "\n${left_pad}${R}  No backups${RS}"; sleep 2 ;;
    esac
}

do_cyber_lock() {
    clear; show_banner; draw_top; print_line "QUINX SHIELD" "$Y"; draw_sep; print_line "Encrypted terminal lock" "$D"; draw_bot; echo ""
    echo -ne "${left_pad}${C}  Create Key ❯ ${RS}"; read -s np; echo
    echo -ne "${left_pad}${C}  Confirm Key ❯ ${RS}"; read -s cp; echo
    [ "$np" != "$cp" ] && echo -e "\n${left_pad}${R}  ✗ Mismatch${RS}" && sleep 2 && return
    local rk=$(generate_recovery_key); echo "$rk" > "$QUINX_HOME/.quinx-recovery"; chmod 600 "$QUINX_HOME/.quinx-recovery"
    cat > "$QUINX_HOME/quinx-unlock" << 'U'
#!/bin/bash
echo -ne "\n  Recovery key: "; read -s k; echo
[ -f "$HOME/QuinxOS/.quinx-recovery" ] && [ "$k" = "$(cat "$HOME/QuinxOS/.quinx-recovery")" ] && sed -i '/#QUINX_LOCK_START/,/#QUINX_LOCK_END/d' ~/.bashrc 2>/dev/null && [ -f ~/.zshrc ] && sed -i '/#QUINX_LOCK_START/,/#QUINX_LOCK_END/d' ~/.zshrc 2>/dev/null && rm -f "$HOME/QuinxOS/.quinx-recovery" && echo -e "\n  ✓ Removed" && exit 0
echo -e "\n  ✗ Invalid key"
U
    chmod +x "$QUINX_HOME/quinx-unlock"
    local lc='#QUINX_LOCK_START
clear; echo -e "\033[1;36m  +-------------------------------------+\n  |     QUINX SHIELD — ACCESS GATE      |\n  +-------------------------------------+\033[0m"
a=1; while [ $a -le 3 ]; do echo -ne "\n\033[1;33m  [Attempt $a/3] Key: \033[0m"; read -s p; echo
[ "$p" = "'"$np"'" ] && echo -e "\033[1;32m  ✓ GRANTED\033[0m" && sleep 1 && clear && break
echo -e "\033[1;31m  ✗ DENIED\033[0m"; [ $a -eq 3 ] && echo -e "\033[1;31m  LOCKED. bash ~/QuinxOS/quinx-unlock\033[0m" && exit; a=$((a+1)); done
#QUINX_LOCK_END'
    for rc in ~/.bashrc ~/.zshrc; do [ -f "$rc" ] && echo "$lc" > "$rc.tmp" && cat "$rc" >> "$rc.tmp" && mv "$rc.tmp" "$rc"; done
    clear; show_banner; draw_top; print_line "SHIELD ACTIVATED ✓" "$G"; draw_sep; print_line "⚠ SAVE YOUR RECOVERY KEY ⚠" "$R"; print_line ""; print_line "Key: $rk" "$G"; print_line "File: $QUINX_HOME/.quinx-recovery" "$D"; print_line "Unlock: bash ~/QuinxOS/quinx-unlock" "$D"; print_line ""; draw_bot; echo ""
    echo -ne "${left_pad}${C}  Press Enter after saving key...${RS}"; read -r
}

do_remove_lock() {
    sed -i '/#QUINX_LOCK_START/,/#QUINX_LOCK_END/d' ~/.bashrc 2>/dev/null
    [ -f ~/.zshrc ] && sed -i '/#QUINX_LOCK_START/,/#QUINX_LOCK_END/d' ~/.zshrc 2>/dev/null
    rm -f "$QUINX_HOME/.quinx-recovery" "$QUINX_HOME/quinx-unlock" 2>/dev/null
    clear; show_banner; draw_top; print_line "SHIELD DEACTIVATED" "$R"; draw_bot; sleep 2
}

do_update() {
    clear; show_banner; draw_top; print_line "UPDATING QUINXOS" "$Y"; draw_sep; print_line "Pulling from GitHub..." "$D"; draw_bot; echo ""
    rm -rf "$QUINX_HOME"; cd "$HOME"; git clone https://github.com/Shineii86/QuinxOS.git 2>/dev/null; cd "$QUINX_HOME"
    clear; show_banner; draw_top; print_line "UPDATE COMPLETE ✓" "$G"; draw_bot; sleep 2
}

do_uninstall() {
    clear; show_banner; draw_top; print_line "UNINSTALL QUINXOS" "$R"; draw_sep; print_line "Removes everything QuinxOS" "$D"
    print_line "Keeps: Oh My Zsh, shell configs, font" "$D"; draw_sep
    print_item "1" "Confirm" "Remove" "$R"; print_item "0" "Cancel" "Keep" "$G"; draw_bot; echo ""
    echo -ne "${left_pad}${C}  ❯ ${RS}"; read -r u
    [ "$u" = "1" ] && { sed -i '/#QUINX_LOCK_START/,/#QUINX_LOCK_END/d' ~/.bashrc ~/.zshrc 2>/dev/null; rm -f ~/.oh-my-zsh/themes/quinx.zsh-theme /data/data/com.termux/files/usr/etc/motd 2>/dev/null; rm -rf "$QUINX_HOME" "$QUINX_MARKER"
    clear; show_banner; draw_top; print_line "UNINSTALLED ✓" "$R"; print_line "Thanks for using QuinxOS!" "$W"; draw_bot; echo ""; echo -ne "${left_pad}${C}  Enter...${RS}"; read -r; exit 0; }
}

do_rgb_animation() {
    clear; echo -e "\n${C}  RGB Animation Preview${RS}\n  "
    for i in {1..40}; do
        case $((i % 6)) in 0) c="\033[1;31m" ;; 1) c="\033[1;33m" ;; 2) c="\033[1;32m" ;; 3) c="\033[1;36m" ;; 4) c="\033[1;34m" ;; 5) c="\033[1;35m" ;; esac
        echo -ne "${c}▓\033[0m"; sleep 0.03
    done
    echo -e "  \033[1;32mDONE\033[0m\n"; echo -ne "${left_pad}${C}  Enter...${RS}"; read -r
}

# -----------------------------------------------------------
# ANIME THEMES + GITHUB + FUN FEATURES (v6.0)
# -----------------------------------------------------------

do_anime_themes() {
    clear; show_banner; draw_top
    print_line "ANIME THEMES" "$M"
    draw_sep
    local names=("Naruto" "One Piece" "Attack on Titan" "Dragon Ball" "Demon Slayer" "Evangelion")
    local files=("naruto" "one-piece" "attack-on-titan" "dragon-ball" "demon-slayer" "evangelion")
    local descs=("Orange & black" "Red, gold, ocean" "Military green" "Orange & blue" "Purple & crimson" "EVA-01 purple")
    for i in {0..5}; do
        printf "${C}${left_pad}|${RS}  ${C}[${W}0$((i+1))${C}]${M} %-18s${RS}" "${names[$i]}"
        printf "${D}%s${RS}" "${descs[$i]}"
        printf '%*s' $(( BOX_WIDTH - 2 - 22 - ${#descs[$i]} )) "" "${C}|${RS}\n"
    done
    draw_sep; print_item "0" "Back" "Return" "$R"; draw_bot; echo ""
    echo -ne "${left_pad}${C}  Theme ❯ ${RS}"; read -r t
    local idx=$(( ${t:-0} - 1 ))
    [ $idx -lt 0 ] || [ $idx -gt 5 ] && return
    [ -f "$QUINX_THEMES/${files[$idx]}.colors" ] && cp "$QUINX_THEMES/${files[$idx]}.colors" ~/.termux/colors.properties 2>/dev/null
    echo "${names[$idx]}" > "$QUINX_HOME/.current-theme"
    termux-reload-settings 2>/dev/null
    clear; show_banner; draw_top; print_line "APPLIED: ${names[$idx]} ✓" "$G"; draw_bot; sleep 2
}

do_anime_banner() {
    clear; show_banner; draw_top
    print_line "ANIME ASCII BANNERS" "$M"
    draw_sep
    print_item "1" "Naruto   " "Believe it!" "$Y"
    print_item "2" "Luffy    " "Gomu Gomu no!" "$R"
    print_item "3" "Eren     " "Fight!" "$G"
    print_item "4" "Goku     " "Kamehameha!" "$Y"
    print_item "5" "Tanjiro  " "Water Breathing" "$B"
    print_item "6" "Rei      " "I mustn't run" "$M"
    draw_sep; print_item "0" "Back" "Return" "$R"; draw_bot; echo ""
    echo -ne "${left_pad}${C}  Character ❯ ${RS}"; read -r c
    local chars=("naruto" "luffy" "eren" "goku" "tanjiro" "rei")
    local idx=$(( ${c:-0} - 1 ))
    [ $idx -lt 0 ] || [ $idx -gt 5 ] && return
    clear
    echo ""
    echo -e "${M}  -- ${chars[$idx]^} --${RS}"
    echo ""
    sed -n "/===${chars[$idx]}===/,/===/p" "$QUINX_HOME/.object/anime-art.txt" 2>/dev/null | grep -v "==="
    echo ""
    echo -ne "${left_pad}${C}  Press Enter...${RS}"; read -r
}

do_github_stats() {
    while true; do
        clear; show_banner; draw_top
        print_line "GITHUB INTEGRATION" "$Y"
        draw_sep
        print_item "1" "Profile Stats  " "Stars, repos, followers" "$G"
        print_item "2" "Notifications  " "PRs, issues, reviews" "$G"
        print_item "3" "Streak Counter  " "Contribution streak" "$Y"
        print_item "4" "Repo Quick View " "Search any repo" "$B"
        draw_sep; print_item "0" "Back" "Return" "$R"; draw_bot; echo ""
        echo -ne "${left_pad}${C}  ❯ ${RS}"; read -r gh_choice
        case $gh_choice in
            1) echo ""; echo -ne "${left_pad}${C}  GitHub username: ${RS}"; read -r gh_user
               [ -n "$gh_user" ] && quinx-ghstats "$gh_user" 2>/dev/null || echo -e "${R}  Plugin not loaded${RS}"
               echo ""; echo -ne "${left_pad}${C}  Enter...${RS}"; read -r ;;
            2) quinx-ghnotifs 2>/dev/null || echo -e "${R}  Install gh: pkg install gh${RS}"
               echo ""; echo -ne "${left_pad}${C}  Enter...${RS}"; read -r ;;
            3) echo ""; echo -ne "${left_pad}${C}  GitHub username: ${RS}"; read -r gh_user
               [ -n "$gh_user" ] && quinx-ghstreak "$gh_user" 2>/dev/null
               echo ""; echo -ne "${left_pad}${C}  Enter...${RS}"; read -r ;;
            4) echo ""; echo -ne "${left_pad}${C}  Repo (owner/name): ${RS}"; read -r gh_repo
               [ -n "$gh_repo" ] && quinx-ghrepo "$gh_repo" 2>/dev/null
               echo ""; echo -ne "${left_pad}${C}  Enter...${RS}"; read -r ;;
            0) return ;;
        esac
    done
}

do_matrix_rain() {
    echo -e "\n${left_pad}${G}  Matrix Rain — 15s — Ctrl+C to stop${RS}"
    sleep 1
    local cols=$(tput cols 2>/dev/null || echo 80)
    local lines=$(tput lines 2>/dev/null || echo 24)
    local chars="01アイウエオカキクケコサシスセソタチツテトナニヌネノハヒフヘホマミムメモ"
    local start=$(date +%s)
    trap 'echo -e "\033[0m"; clear; return' INT
    while true; do
        [ $(($(date +%s) - start)) -ge 15 ] && break
        local col=$((RANDOM % cols)) len=$((RANDOM % 15 + 3))
        for ((i=0; i<len; i++)); do
            local row=$((RANDOM % lines)) char="${chars:$((RANDOM % ${#chars})):1}"
            [ $i -lt 2 ] && echo -ne "\033[${row};${col}H\033[1;37m${char}\033[0m" && continue
            [ $i -lt 5 ] && echo -ne "\033[${row};${col}H\033[1;32m${char}\033[0m" && continue
            echo -ne "\033[${row};${col}H\033[2;32m${char}\033[0m"
        done
        sleep 0.02
    done
    echo -e "\033[0m"; clear
}

do_auto_theme() {
    clear; show_banner; draw_top
    print_line "AUTO DARK/LIGHT THEME" "$Y"
    draw_sep
    print_line "Switches theme based on time of day" "$D"
    draw_sep
    print_item "1" "Enable  " "Auto-switch at 6AM/6PM" "$G"
    print_item "2" "Disable " "Manual theme only" "$R"
    draw_sep; print_item "0" "Back" "Return" "$R"; draw_bot; echo ""
    echo -ne "${left_pad}${C}  ❯ ${RS}"; read -r at_choice
    case $at_choice in
        1)
            # Add auto-theme to zshrc/bashrc
            local auto_code='
# QuinxOS Auto Theme
_hour=$(date +%H)
if [ $_hour -ge 6 ] && [ $_hour -lt 18 ]; then
    [ -f "$HOME/QuinxOS/.object/themes/arctic-blue.colors" ] && cp "$HOME/QuinxOS/.object/themes/arctic-blue.colors" ~/.termux/colors.properties 2>/dev/null
else
    [ -f "$HOME/QuinxOS/.object/themes/cyber-midnight.colors" ] && cp "$HOME/QuinxOS/.object/themes/cyber-midnight.colors" ~/.termux/colors.properties 2>/dev/null
fi'
            for rc in ~/.zshrc ~/.bashrc; do
                [ -f "$rc" ] || continue
                sed -i '/# QuinxOS Auto Theme/,/^fi$/d' "$rc"
                echo "$auto_code" >> "$rc"
            done
            clear; show_banner; draw_top
            print_line "AUTO THEME ENABLED ✓" "$G"
            print_line "6AM: Arctic Blue | 6PM: Cyber Midnight" "$D"
            draw_bot; sleep 2 ;;
        2)
            for rc in ~/.zshrc ~/.bashrc; do
                [ -f "$rc" ] && sed -i '/# QuinxOS Auto Theme/,/^fi$/d' "$rc"
            done
            clear; show_banner; draw_top; print_line "AUTO THEME DISABLED" "$R"; draw_bot; sleep 2 ;;
    esac
}

do_neofetch_banner() {
    clear
    local user=$(whoami 2>/dev/null)
    local host=$(hostname 2>/dev/null)
    local os=$(uname -o 2>/dev/null)
    local kernel=$(uname -r 2>/dev/null)
    local arch=$(uname -m 2>/dev/null)
    local shell=$(basename "$SHELL" 2>/dev/null)
    local uptime=$(uptime -p 2>/dev/null || echo "N/A")
    local pkgs=$(dpkg -l 2>/dev/null | grep -c '^ii')
    local mem=$(free -h 2>/dev/null | awk '/Mem:/{print $3"/"$2}')
    local disk=$(df -h / 2>/dev/null | awk 'NR==2{print $3"/"$2}')
    local term=$(echo "$TERM")
    local theme=$(cat "$QUINX_HOME/.current-theme" 2>/dev/null || echo "Default")

    echo ""
    echo -e "${C}              ▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄${RS}"
    echo -e "${C}            ▄█${M}▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀${C}█▄${RS}"
    echo -e "${C}          ▄█${M}                     ${C}█▄${RS}"
    echo -e "${C}        ▄█${M}   ${C}█▀█ █▀█ █▀▄ █▀▀${M}   ${C}█▄${RS}"
    echo -e "${C}      ▄█${M}     ${C}█▀▀ █▀█ █▀▄ █▀▀${M}     ${C}█▄${RS}"
    echo -e "${C}    ▄█${M}       ${C}▀   ▀  ▀ ▀  ▀▀▀${M}       ${C}█▄${RS}"
    echo -e "${C}  ▄█${M}                                   ${C}█▄${RS}"
    echo -e "${C}  █${M}▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀${M}▀▀▀${C}█${RS}"
    echo -e "${C}  █${RS}                                     ${C}█${RS}"
    echo -e "${C}  █${RS}  ${W}${user}${C}@${W}${host}${RS}                           ${C}█${RS}"
    echo -e "${C}  █${RS}  ${D}-----------------------${RS}            ${C}█${RS}"
    echo -e "${C}  █${RS}  ${W}OS:${RS}       ${G}${os}${RS}                   ${C}█${RS}"
    echo -e "${C}  █${RS}  ${W}Kernel:${RS}   ${G}${kernel}${RS}     ${C}█${RS}"
    echo -e "${C}  █${RS}  ${W}Arch:${RS}     ${G}${arch}${RS}                    ${C}█${RS}"
    echo -e "${C}  █${RS}  ${W}Shell:${RS}    ${G}${shell}${RS}                      ${C}█${RS}"
    echo -e "${C}  █${RS}  ${W}Uptime:${RS}   ${G}${uptime}${RS}  ${C}█${RS}"
    echo -e "${C}  █${RS}  ${W}Packages:${RS} ${G}${pkgs}${RS}                        ${C}█${RS}"
    echo -e "${C}  █${RS}  ${W}Memory:${RS}   ${G}${mem}${RS}                   ${C}█${RS}"
    echo -e "${C}  █${RS}  ${W}Disk:${RS}     ${G}${disk}${RS}                    ${C}█${RS}"
    echo -e "${C}  █${RS}  ${W}Theme:${RS}    ${M}${theme}${RS}                   ${C}█${RS}"
    echo -e "${C}  █${RS}  ${W}Terminal:${RS} ${G}${term}${RS}                    ${C}█${RS}"
    echo -e "${C}  █${RS}                                     ${C}█${RS}"
    echo -e "${C}  █▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄█${RS}"
    echo ""
    echo -e "  ${R}███${G}███${Y}███${B}███${M}███${C}███${W}███${RS}"
    echo ""
    echo -ne "${left_pad}${C}  Press Enter...${RS}"; read -r
}

do_fun_stuff() {
    while true; do
        clear; show_banner; draw_top
        print_line "FUN STUFF" "$M"
        draw_sep
        print_item "1" "Anime Quote    " "Random quote" "$M"
        print_item "2" "Anime Art      " "Character ASCII art" "$M"
        print_item "3" "Waifu Mascot   " "Random character" "$R"
        print_item "4" "Fun Fact       " "Random fact" "$Y"
        print_item "5" "Matrix Rain    " "Animated green rain" "$G"
        print_item "6" "Neofetch-style " "System info banner" "$C"
        print_item "7" "Auto Theme     " "Dark/Light by time" "$B"
        draw_sep; print_item "0" "Back" "Return" "$R"; draw_bot; echo ""
        echo -ne "${left_pad}${C}  ❯ ${RS}"; read -r fun_choice
        case $fun_choice in
            1) clear; echo ""; quinx-anime-quote 2>/dev/null || { local qf="$QUINX_HOME/.object/anime-quotes.txt"; local t=$(wc -l < "$qf"); echo -e "\n${M}  「 $(sed -n "$((RANDOM % t + 1))p" "$qf") 」${RS}\n"; }; echo -ne "${left_pad}${C}  Enter...${RS}"; read -r ;;
            2) do_anime_banner ;;
            3) clear; echo ""; local af="$QUINX_HOME/.object/anime-art.txt"; local arts=("naruto" "luffy" "eren" "goku" "tanjiro" "rei"); local r=$((RANDOM % ${#arts[@]})); echo -e "${M}  -- ${arts[$r]^} --${RS}\n"; sed -n "/===${arts[$r]}===/,/===/p" "$af" 2>/dev/null | grep -v "==="; echo ""; echo -ne "${left_pad}${C}  Enter...${RS}"; read -r ;;
            4) clear; echo ""; local ff="$QUINX_HOME/.object/fun-facts.txt"; local t=$(wc -l < "$ff"); echo -e "\n${Y}  💡 $(sed -n "$((RANDOM % t + 1))p" "$ff")${RS}\n"; echo -ne "${left_pad}${C}  Enter...${RS}"; read -r ;;
            5) do_matrix_rain ;;
            6) do_neofetch_banner ;;
            7) do_auto_theme ;;
            0) return ;;
        esac
    done
}

# --- Auto-Update ------------------------------------------
check_for_updates() {
    local lc="$QUINX_HOME/.last-update-check" now=$(date +%s)
    [ -f "$lc" ] && [ $(( now - $(cat "$lc") )) -lt 86400 ] && return
    echo "$now" > "$lc"
    local rv=$(curl -s --max-time 5 "https://raw.githubusercontent.com/Shineii86/QuinxOS/main/install.sh" 2>/dev/null | grep -m1 'QUINX_VERSION=' | cut -d'"' -f2)
    [ -n "$rv" ] && [ "$rv" != "$QUINX_VERSION" ] && { echo ""; draw_top; print_line "UPDATE: v${QUINX_VERSION} → v${rv}" "$Y"; print_line "Run option [26] to update" "$D"; draw_bot; sleep 2; }
}

# --- First-Run Wizard -------------------------------------
do_first_run_wizard() {
    clear; echo ""
    banner_style_1; echo ""
    echo -e "${M}  +-------------------------------------------------------+${RS}"
    echo -e "${M}  |     ${W}WELCOME TO QUINXOS v${QUINX_VERSION} SETUP WIZARD${M}          |${RS}"
    echo -e "${M}  +-------------------------------------------------------+${RS}"
    echo ""
    echo -e "${C}  Step 1: Shell${RS}  [1] Zsh  [2] Bash"; echo -ne "  Choice: "; read -r s
    case $s in 2) chsh -s bash ;; *) pkg install zsh -y 2>&1 | tail -1; chsh -s zsh ;; esac
    echo ""
    echo -e "${C}  Step 2: Theme (1-22)${RS}"
    echo "  1.Cyber Midnight 2.Matrix Green 3.Solar Flare 4.Arctic Blue 5.Purple Haze"
    echo "  6.Dracacula 7.Nord 8.Gruvbox 9.Tokyo Night 10.Catppuccin"
    echo "  11.Everforest 12.Monokai 13.Synthwave 14.Rose Pine 15.Kanagawa 16.Tokyo Day"
    echo "  17.Naruto 18.One Piece 19.Attack on Titan 20.Dragon Ball 21.Demon Slayer 22.Evangelion"
    echo -ne "  Choice: "; read -r tw
    local tf=("cyber-midnight" "matrix-green" "solar-flare" "arctic-blue" "purple-haze" "dracacula" "nord" "gruvbox" "tokyo-night" "catppuccin-mocha" "everforest" "monokai" "synthwave" "rose-pine" "kanagawa" "tokyo-day" "naruto" "one-piece" "attack-on-titan" "dragon-ball" "demon-slayer" "evangelion")
    local tn=("Cyber Midnight" "Matrix Green" "Solar Flare" "Arctic Blue" "Purple Haze" "Dracacula" "Nord" "Gruvbox" "Tokyo Night" "Catppuccin Mocha" "Everforest" "Monokai" "Synthwave" "Rose Pine" "Kanagawa" "Tokyo Day" "Naruto" "One Piece" "Attack on Titan" "Dragon Ball" "Demon Slayer" "Evangelion")
    local idx=$(( ${tw:-1} - 1 )); [ $idx -lt 0 ] && idx=0; [ $idx -gt 21 ] && idx=0
    [ -f "$QUINX_THEMES/${tf[$idx]}.colors" ] && cp "$QUINX_THEMES/${tf[$idx]}.colors" ~/.termux/colors.properties 2>/dev/null
    echo "${tn[$idx]}" > "$QUINX_HOME/.current-theme"
    echo ""
    echo -e "${C}  Step 3: Banner [1] Block [2] Box [3] Clean [4] Naruto [5] Military${RS}"; echo -ne "  Choice: "; read -r b; echo "$b" > "$QUINX_HOME/.banner-style"
    echo ""
    echo -e "${C}  Step 4: Display Name${RS}"; echo -ne "  Name: "; read -r dn; [ -z "$dn" ] && dn="${USER:-Quinx}"
    echo ""
    echo -ne "  ${W}Installing...${RS} "
    apt update -y 2>&1 | tail -1; apt upgrade -y 2>&1 | tail -1
    pkg install zsh git figlet toilet ruby wget curl -y 2>&1 | tail -1; gem install lolcat 2>&1 | tail -1
    git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh 2>&1 | tail -1
    git clone https://github.com/zsh-users/zsh-autosuggestions "$HOME/.oh-my-zsh/plugins/zsh-autosuggestions" 2>&1 | tail -1
    git clone https://github.com/zsh-users/zsh-syntax-highlighting "$HOME/.oh-my-zsh/plugins/zsh-syntax-highlighting" 2>&1 | tail -1
    [ -f "$QUINX_HOME/.object/ANSI Shadow.flf" ] && cp "$QUINX_HOME/.object/ANSI Shadow.flf" "$PREFIX/share/figlet/ASCII-Shadow.flf" 2>/dev/null
    curl -L https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/FiraCode/Regular/FiraCodeNerdFont-Regular.ttf > ~/.termux/font.ttf 2>/dev/null
    [ -f "$QUINX_HOME/.object/zshrc-full" ] && sed "s/\PROC/${dn}/g" "$QUINX_HOME/.object/zshrc-full" > ~/.zshrc
    [ -f "$QUINX_HOME/.object/quinx.zsh-theme" ] && mkdir -p ~/.oh-my-zsh/themes && sed "s/\PROC/${dn}/g" "$QUINX_HOME/.object/quinx.zsh-theme" > ~/.oh-my-zsh/themes/quinx.zsh-theme 2>/dev/null
    [ -f "$QUINX_HOME/.object/termux.properties" ] && cp "$QUINX_HOME/.object/termux.properties" ~/.termux.properties
    termux-reload-settings 2>/dev/null
    echo -e "${G}✓${RS}"
    echo "v${QUINX_VERSION}" > "$QUINX_MARKER"
    mkdir -p "$QUINX_PROFILES/default"
    echo ""
    echo -e "${M}  +-------------------------------------------------------+${RS}"
    echo -e "${M}  |  ${G}✓ SETUP COMPLETE!${M}  Shell:${G}$(basename "$SHELL")${M}  Theme:${G}${tn[$idx]}${M}      |${RS}"
    echo -e "${M}  +-------------------------------------------------------+${RS}"
    echo ""; echo -ne "${C}  Enter to continue...${RS}"; read -r
}

# -----------------------------------------------------------
# MAIN MENU — 28 OPTIONS
# -----------------------------------------------------------
main_menu() {
    while true; do
        show_banner; show_status; echo ""
        draw_top; print_line "MAIN MENU" "$Y"; draw_sep
        print_item "01" "Core Setup       " "Deps & fonts" "$G"
        print_item "02" "Zsh Config       " "Reset zsh" "$G"
        print_item "03" "Switch → Zsh     " "Default shell" "$G"
        print_item "04" "Switch → Bash    " "Default shell" "$G"
        print_item "05" "Banner Style     " "5 designs" "$Y"
        print_item "06" "Custom Theme     " "Prompt name" "$Y"
        print_item "07" "Zsh Plugins      " "Highlight+Auto" "$Y"
        print_item "08" "Theme Gallery    " "22 color schemes" "$C"
        print_item "09" "Theme Builder    " "Create custom" "$C"
        print_item "10" "Color Export     " "Win/iTerm/Alacritty" "$C"
        print_item "11" "Anime Themes     " "6 anime schemes" "$M"
        print_item "12" "Dev Tools        " "Python,Node,Go..." "$B"
        print_item "13" "Quick Commands   " "Git,serve,compress" "$B"
        print_item "14" "Aliases Manager  " "Shell shortcuts" "$B"
        print_item "15" "Plugin System    " "Custom scripts" "$B"
        print_item "16" "Custom ASCII Art " "Banner text" "$M"
        print_item "17" "Login Sound      " "Audio on boot" "$M"
        print_item "18" "Dashboard        " "Live system monitor" "$G"
        print_item "19" "Git Dashboard    " "Repo info & status" "$G"
        print_item "20" "GitHub Integration" "Stats, streak, repos" "$Y"
        print_item "21" "System Info      " "Device details" "$W"
        print_item "22" "Network Info     " "IP, DNS, ping" "$W"
        print_item "23" "QuinxBench       " "System benchmark" "$Y"
        print_item "24" "Neofetch Banner  " "System info art" "$C"
        print_item "25" "Profiles         " "Multi-config" "$C"
        print_item "26" "Dotfiles Sync    " "GitHub sync" "$C"
        print_item "27" "Termux API Hooks " "Battery, GPS, torch" "$B"
        print_item "28" "Fun Stuff        " "Anime, Matrix, facts" "$M"
        print_item "29" "MOTD Editor      " "Boot message" "$M"
        print_item "30" "Backup/Restore   " "Save/load config" "$M"
        print_item "31" "Startup Timer    " "Shell load time" "$D"
        draw_sep
        print_item "32" "Quinx Shield     " "Terminal lock" "$R"
        print_item "33" "Fingerprint Lock " "Biometric auth" "$R"
        print_item "34" "Remove Lock      " "Deactivate" "$R"
        print_item "35" "Command Palette  " "Search features" "$G"
        print_item "36" "Update QuinxOS   " "Pull latest" "$G"
        print_item "37" "Uninstall        " "Remove all" "$R"
        print_item "38" "RGB Animation    " "Preview effect" "$Y"
        draw_sep
        print_item "00" "Exit             " "Close terminal" "$R"
        draw_bot; echo ""
        echo -ne "${left_pad}${C}  +- ❯ ${RS}"
        read -r opt; echo ""
        case $opt in
            1|01)  do_necessary_setup ;;     2|02)  do_zsh_setup ;;
            3|03)  do_set_zsh ;;             4|04)  do_set_bash ;;
            5|05)  do_set_banner ;;          6|06)  do_set_theme ;;
            7|07)  do_plugins ;;             8|08)  do_theme_presets ;;
            9|09)  do_theme_builder ;;       10)    do_color_export ;;
            11)    do_anime_themes ;;        12)    do_dev_tools ;;
            13)    do_quick_commands ;;      14)    do_aliases_manager ;;
            15)    do_plugin_system ;;       16)    do_custom_banner_text ;;
            17)    do_login_sound ;;         18)    do_dashboard ;;
            19)    do_git_dashboard ;;       20)    do_github_stats ;;
            21)    do_sysinfo ;;             22)    do_network_info ;;
            23)    do_bench ;;               24)    do_neofetch_banner ;;
            25)    do_profiles ;;            26)    do_dotfiles_sync ;;
            27)    do_termux_hooks ;;        28)    do_fun_stuff ;;
            29)    do_motd_editor ;;         30)    do_backup ;;
            31)    do_startup_timer ;;       32)    do_cyber_lock ;;
            33)    do_fingerprint_lock ;;    34)    do_remove_lock ;;
            35)    do_command_palette ;;     36)    do_update ;;
            37)    do_uninstall ;;           38)    do_rgb_animation ;;
            0|00)  clear; echo -e "${C}  QuinxOS ${W}— Session ended.${RS}\n"; exit 0 ;;
        esac
    done
}

# -----------------------------------------------------------
# ENTRY
# -----------------------------------------------------------
[ ! -f "$QUINX_MARKER" ] && [ "$1" != "--skip-wizard" ] && do_first_run_wizard
check_for_updates
main_menu
