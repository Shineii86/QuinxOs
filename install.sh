#!/bin/bash
# ╔══════════════════════════════════════════════════════════╗
# ║                    QuinxOS v4.2                          ║
# ║         Termux Optimization & Customization Suite        ║
# ║                    by Shineii86                          ║
# ╚══════════════════════════════════════════════════════════╝

# ─── Color Palette ─────────────────────────────────────────
R='\033[1;31m'; G='\033[1;32m'; Y='\033[1;93m'; B='\033[1;94m'
C='\033[1;96m'; W='\033[1;97m'; M='\033[1;95m'; D='\033[2m'
RS='\033[0m'; BL='\033[5m'; UL='\033[4m'

# ─── Paths ─────────────────────────────────────────────────
QUINX_HOME="$HOME/QuinxOS"
QUINX_VERSION="4.2"
QUINX_MARKER="$HOME/.quinx-installed"
QUINX_THEMES="$QUINX_HOME/.object/themes"
QUINX_PLUGINS="$QUINX_HOME/.object/plugins"

# ─── Layout Engine ─────────────────────────────────────────
term_width=$(tput cols 2>/dev/null || echo 80)
BOX_WIDTH=$(( term_width > 64 ? 62 : term_width - 2 ))
margin=$(( (term_width - BOX_WIDTH) / 2 ))
left_pad=$(printf '%*s' "$margin" "")

draw_top()    { printf "${C}${left_pad}╔"; for ((i=0; i<BOX_WIDTH-2; i++)); do printf "═"; done; printf "╗${RS}\n"; }
draw_bot()    { printf "${C}${left_pad}╚"; for ((i=0; i<BOX_WIDTH-2; i++)); do printf "═"; done; printf "╝${RS}\n"; }
draw_sep()    { printf "${C}${left_pad}╠"; for ((i=0; i<BOX_WIDTH-2; i++)); do printf "─"; done; printf "╣${RS}\n"; }
draw_empty()  { printf "${C}${left_pad}║${RS}"; printf '%*s' $((BOX_WIDTH-2)) ""; printf "${C}║${RS}\n"; }

print_line() {
    local text="$1" color="${2:-$W}"
    local len=${#text}
    local inner=$((BOX_WIDTH - 2))
    local space_l=$(( (inner - len) / 2 ))
    local space_r=$(( inner - len - space_l ))
    printf "${C}${left_pad}║%*s${color}%s${C}%*s║${RS}\n" $space_l "" "$text" $space_r ""
}

print_item() {
    local num="$1" label="$2" desc="$3" color="${4:-$G}"
    local num_fmt="${C}[${W}${num}${C}]${color}"
    local full="  ${num_fmt} ${label}"
    printf "${C}${left_pad}║${RS}${full}"
    local remaining=$(( BOX_WIDTH - 2 - ${#full} - ${#desc} - 2 ))
    printf '%*s' $remaining ""
    printf "${D}%s${RS}  ${C}║${RS}\n" "$desc"
}

# ─── ASCII Art Banners ─────────────────────────────────────
banner_style_1() {
    echo ""
    echo -e "${C}    ██████╗ ██╗   ██╗██╗███╗   ██╗██╗  ██╗ ██████╗ ███████╗${RS}"
    echo -e "${C}   ██╔═══██╗██║   ██║██║████╗  ██║╚██╗██╔╝██╔═══██╗██╔════╝${RS}"
    echo -e "${C}   ██║   ██║██║   ██║██║██╔██╗ ██║ ╚███╔╝ ██║   ██║███████╗${RS}"
    echo -e "${C}   ██║▄▄ ██║██║   ██║██║██║╚██╗██║ ██╔██╗ ██║   ██║╚════██║${RS}"
    echo -e "${C}   ╚██████╔╝╚██████╔╝██║██║ ╚████║██╔╝ ██╗╚██████╔╝███████║${RS}"
    echo -e "${C}    ╚══▀▀═╝  ╚═════╝ ╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝${RS}"
}

banner_style_2() {
    echo ""
    echo -e "${M}    ▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄${RS}"
    echo -e "${M}   █░█▀▄░█░█░█▄░█░█▀▀░█░█░█▀█░█▀▀░█▀█░█▀▄░█▀▀░█▀▄░█${RS}"
    echo -e "${M}   █░█░█░█░█░█░▀█░█░░░█▀█░█▄█░█░░░█░█░█░█░█▀▀░█░█░█${RS}"
    echo -e "${M}   █░▀▀░░▀▀▀░▀░░▀░▀▀▀░▀░▀░▀░▀░▀▀▀░▀▀▀░▀▀░░▀▀▀░▀▀░░▀${RS}"
    echo -e "${M}   ▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀${RS}"
}

banner_style_3() {
    echo ""
    echo -e "${G}   ╔═══════════════════════════════════════════════════╗${RS}"
    echo -e "${G}   ║                                                   ║${RS}"
    echo -e "${G}   ║   ░█▀▄░█░█░█▄░█░█▀▀░█░█░█▀█░█▀▀░█▀█░█▀▄░█▀▀    ║${RS}"
    echo -e "${G}   ║   ░█░█░█░█░█░▀█░█░░░█▀█░█▄█░█░░░█░█░█░█░█▀▀    ║${RS}"
    echo -e "${G}   ║   ░▀▀░░▀▀▀░▀░░▀░▀▀▀░▀░▀░▀░▀░▀▀▀░▀▀▀░▀▀░░▀▀▀    ║${RS}"
    echo -e "${G}   ║                                                   ║${RS}"
    echo -e "${G}   ╚═══════════════════════════════════════════════════╝${RS}"
}

show_banner() {
    clear
    local style_file="$QUINX_HOME/.banner-style"
    local style="1"
    [ -f "$style_file" ] && style=$(cat "$style_file")
    case $style in
        1) banner_style_1 ;; 2) banner_style_2 ;; 3) banner_style_3 ;;
        *) banner_style_1 ;;
    esac
    echo ""
    echo -e "${M}         ╔═══════════════════════════════════════╗${RS}"
    echo -e "${M}         ║  ${W}Termux Optimization Suite ${D}v${QUINX_VERSION}${M}       ║${RS}"
    echo -e "${M}         ╚═══════════════════════════════════════╝${RS}"
    echo ""
}

# ─── Status Bar ────────────────────────────────────────────
show_status() {
    local shell_now=$(basename "$SHELL" 2>/dev/null || echo "unknown")
    local zsh_status="${R}✗${RS}"; [ -d "$HOME/.oh-my-zsh" ] && zsh_status="${G}✓${RS}"
    local lock_status="${R}✗${RS}"
    grep -q "#QUINX_LOCK_START" ~/.bashrc 2>/dev/null && lock_status="${G}✓${RS}"
    grep -q "#QUINX_LOCK_START" ~/.zshrc 2>/dev/null && lock_status="${G}✓${RS}"
    local theme_name="Cyber Midnight"
    [ -f "$QUINX_HOME/.current-theme" ] && theme_name=$(cat "$QUINX_HOME/.current-theme")
    local plugin_count=$(ls "$QUINX_PLUGINS"/*.sh 2>/dev/null | wc -l || echo "0")

    draw_top
    print_line ""
    print_line "SYSTEM STATUS" "$Y"
    draw_sep
    printf "${C}${left_pad}║${RS}  Shell: ${W}%-8s${RS} Zsh: ${W}%-3b${RS} Lock: ${W}%-3b${RS} Theme: ${W}%-12s${RS} Plugins: ${W}%-3s${RS}" \
        "$shell_now" "$zsh_status" "$lock_status" "$theme_name" "$plugin_count"
    local total_len=$(( 8 + 7 + 7 + 8 + 12 + 10 + 3 )
    )
    local remaining=$(( BOX_WIDTH - 2 - total_len ))
    [ $remaining -lt 0 ] && remaining=0
    printf '%*s' $remaining ""
    printf "${C}║${RS}\n"
    print_line ""
}

# ─── Auto-Update Check ─────────────────────────────────────
check_for_updates() {
    local last_check="$QUINX_HOME/.last-update-check"
    local now=$(date +%s)
    if [ -f "$last_check" ]; then
        local last=$(cat "$last_check")
        local diff=$(( now - last ))
        [ $diff -lt 86400 ] && return
    fi
    echo "$now" > "$last_check"
    local remote_ver=$(curl -s --max-time 5 "https://raw.githubusercontent.com/Shineii86/QuinxOS/main/install.sh" 2>/dev/null | grep -m1 'QUINX_VERSION=' | cut -d'"' -f2)
    if [ -n "$remote_ver" ] && [ "$remote_ver" != "$QUINX_VERSION" ]; then
        echo ""
        draw_top
        print_line ""
        print_line "UPDATE AVAILABLE" "$Y"
        print_line "Current: v${QUINX_VERSION} → Latest: v${remote_ver}" "$W"
        print_line "Run option [20] to update" "$D"
        print_line ""
        draw_bot
        sleep 2
    fi
}

# ═══════════════════════════════════════════════════════════
# FEATURE 1: LOGIN SOUND
# ═══════════════════════════════════════════════════════════
do_login_sound() {
    clear; show_banner
    draw_top
    print_line "LOGIN SOUND" "$Y"
    draw_sep
    print_line "Play audio on terminal boot" "$D"
    draw_sep
    print_item "1" "Enable Bell     " "Terminal beep on login" "$G"
    print_item "2" "Custom Sound    " "Use your own audio file" "$G"
    print_item "3" "Disable         " "Silent boot" "$R"
    draw_sep
    print_item "0" "Back            " "Return to menu" "$R"
    draw_bot; echo ""
    echo -ne "${left_pad}${C}  Selection ❯ ${RS}"
    read -r sound_choice
    case $sound_choice in
        1)
            echo '# Sound enabled: bell' > "$QUINX_HOME/.login-sound-mode"
            clear; show_banner; draw_top
            print_line "LOGIN BELL ENABLED ✓" "$G"
            draw_bot; sleep 2 ;;
        2)
            echo ""
            echo -ne "${left_pad}${C}  Path to audio file: ${RS}"
            read -r sound_file
            if [ -f "$sound_file" ]; then
                cp "$sound_file" "$QUINX_HOME/.login-sound"
                echo '# Sound enabled: custom' > "$QUINX_HOME/.login-sound-mode"
                clear; show_banner; draw_top
                print_line "CUSTOM SOUND SET ✓" "$G"
                draw_bot
            else
                echo -e "\n${left_pad}${R}  File not found${RS}"
            fi
            sleep 2 ;;
        3)
            rm -f "$QUINX_HOME/.login-sound" "$QUINX_HOME/.login-sound-mode"
            clear; show_banner; draw_top
            print_line "LOGIN SOUND DISABLED ✓" "$R"
            draw_bot; sleep 2 ;;
        0) return ;;
    esac
}

# ═══════════════════════════════════════════════════════════
# FEATURE 4: RGB ANIMATION
# ═══════════════════════════════════════════════════════════
do_rgb_animation() {
    clear
    echo ""
    echo -e "${C}  QuinxOS RGB Animation Preview${RS}"
    echo ""
    echo -ne "  "
    for i in {1..40}; do
        case $((i % 6)) in
            0) color="\033[1;31m" ;; 1) color="\033[1;33m" ;;
            2) color="\033[1;32m" ;; 3) color="\033[1;36m" ;;
            4) color="\033[1;34m" ;; 5) color="\033[1;35m" ;;
        esac
        echo -ne "${color}▓\033[0m"
        sleep 0.03
    done
    echo -e "  \033[1;32mDONE\033[0m"
    echo ""
    echo -e "${C}  This animation plays on every terminal boot.${RS}"
    echo -e "${D}  Built into your zshrc automatically.${RS}"
    echo ""
    echo -ne "${left_pad}${C}  Press Enter to return...${RS}"
    read -r
}

# ═══════════════════════════════════════════════════════════
# FEATURE 5: THEME GALLERY (15 themes)
# ═══════════════════════════════════════════════════════════
do_theme_presets() {
    clear; show_banner
    draw_top
    print_line "THEME GALLERY — 15 THEMES" "$Y"
    draw_sep
    print_item "01" "Cyber Midnight  " "Deep space + neon" "$C"
    print_item "02" "Matrix Green     " "Classic hacker" "$G"
    print_item "03" "Solar Flare      " "Warm dark + orange" "$Y"
    print_item "04" "Arctic Blue      " "Cool blue / ice" "$B"
    print_item "05" "Purple Haze      " "Purple + magenta" "$M"
    print_item "06" "Dracacula        " "Dracula-inspired" "$M"
    print_item "07" "Nord             " "Arctic north-blue" "$B"
    print_item "08" "Gruvbox          " "Retro groove warm" "$Y"
    print_item "09" "Tokyo Night      " "Clean VS Code dark" "$B"
    print_item "10" "Catppuccin Mocha " "Smooth pastel dark" "$M"
    print_item "11" "Everforest       " "Nature green dark" "$G"
    print_item "12" "Monokai          " "Classic code editor" "$Y"
    print_item "13" "Synthwave        " "Neon retro 80s" "$R"
    print_item "14" "Rose Pine        " "Gentle pine/rose" "$M"
    print_item "15" "Kanagawa         " "Japanese ink dark" "$B"
    draw_sep
    print_item "0"  "Back             " "Return to menu" "$R"
    draw_bot; echo ""
    echo -ne "${left_pad}${C}  Theme ❯ ${RS}"
    read -r theme_choice

    local theme_file="" theme_name=""
    case $theme_choice in
        1|01)  theme_file="cyber-midnight.colors"; theme_name="Cyber Midnight" ;;
        2|02)  theme_file="matrix-green.colors"; theme_name="Matrix Green" ;;
        3|03)  theme_file="solar-flare.colors"; theme_name="Solar Flare" ;;
        4|04)  theme_file="arctic-blue.colors"; theme_name="Arctic Blue" ;;
        5|05)  theme_file="purple-haze.colors"; theme_name="Purple Haze" ;;
        6|06)  theme_file="dracacula.colors"; theme_name="Dracacula" ;;
        7|07)  theme_file="nord.colors"; theme_name="Nord" ;;
        8|08)  theme_file="gruvbox.colors"; theme_name="Gruvbox" ;;
        9|09)  theme_file="tokyo-night.colors"; theme_name="Tokyo Night" ;;
        10)    theme_file="catppuccin-mocha.colors"; theme_name="Catppuccin Mocha" ;;
        11)    theme_file="everforest.colors"; theme_name="Everforest" ;;
        12)    theme_file="monokai.colors"; theme_name="Monokai" ;;
        13)    theme_file="synthwave.colors"; theme_name="Synthwave" ;;
        14)    theme_file="rose-pine.colors"; theme_name="Rose Pine" ;;
        15)    theme_file="kanagawa.colors"; theme_name="Kanagawa" ;;
        0) return ;;
        *) return ;;
    esac

    if [ -f "$QUINX_THEMES/$theme_file" ]; then
        cp "$QUINX_THEMES/$theme_file" ~/.termux/colors.properties 2>/dev/null
        echo "$theme_name" > "$QUINX_HOME/.current-theme"
        termux-reload-settings 2>/dev/null
        clear; show_banner; draw_top
        print_line "THEME APPLIED: $theme_name ✓" "$G"
        draw_bot
    else
        clear; show_banner; draw_top
        print_line "THEME FILE NOT FOUND" "$R"
        draw_bot
    fi
    sleep 2
}

# ═══════════════════════════════════════════════════════════
# FEATURE 6: ALIASES MANAGER
# ═══════════════════════════════════════════════════════════
do_aliases_manager() {
    while true; do
        clear; show_banner
        draw_top
        print_line "ALIASES MANAGER" "$Y"
        draw_sep
        print_line "Create & manage shell shortcuts" "$D"
        draw_sep
        print_item "1" "List Aliases   " "Show all saved aliases" "$G"
        print_item "2" "Add Alias      " "Create new alias" "$G"
        print_item "3" "Remove Alias   " "Delete an alias" "$R"
        print_item "4" "Quick Aliases  " "Add common aliases" "$Y"
        draw_sep
        print_item "0" "Back           " "Return to menu" "$R"
        draw_bot; echo ""
        echo -ne "${left_pad}${C}  Selection ❯ ${RS}"
        read -r alias_choice

        local alias_file="$QUINX_HOME/.quinx-aliases"
        case $alias_choice in
            1)
                clear; show_banner; draw_top
                print_line "SAVED ALIASES" "$Y"
                draw_sep
                if [ -f "$alias_file" ] && [ -s "$alias_file" ]; then
                    while IFS= read -r line; do
                        printf "${C}${left_pad}║${RS}  ${W}%-40s${RS}" "$line"
                        printf '%*s' $(( BOX_WIDTH - 2 - 42 )) "" "${C}║${RS}\n"
                    done < "$alias_file"
                else
                    print_line "No aliases saved yet" "$D"
                fi
                draw_bot; echo ""
                echo -ne "${left_pad}${C}  Press Enter...${RS}"
                read -r ;;
            2)
                echo ""
                echo -ne "${left_pad}${C}  Alias name (e.g., 'll'): ${RS}"
                read -r alias_name
                echo -ne "${left_pad}${C}  Command: ${RS}"
                read -r alias_cmd
                if [ -n "$alias_name" ] && [ -n "$alias_cmd" ]; then
                    echo "alias ${alias_name}='${alias_cmd}'" >> "$alias_file"
                    source "$alias_file" 2>/dev/null
                    echo -e "\n${left_pad}${G}  ✓ alias ${alias_name}='${alias_cmd}'${RS}"
                fi
                sleep 2 ;;
            3)
                if [ -f "$alias_file" ] && [ -s "$alias_file" ]; then
                    echo ""
                    nl -ba "$alias_file"
                    echo ""
                    echo -ne "${left_pad}${C}  Line number to remove: ${RS}"
                    read -r line_num
                    if [ -n "$line_num" ]; then
                        sed -i "${line_num}d" "$alias_file"
                        echo -e "${left_pad}${G}  ✓ Removed${RS}"
                    fi
                else
                    echo -e "\n${left_pad}${D}  No aliases to remove${RS}"
                fi
                sleep 2 ;;
            4)
                cat >> "$alias_file" << 'ALIASES'
alias ll='ls -la'
alias la='ls -a'
alias cls='clear'
alias ..='cd ..'
alias ...='cd ../..'
alias update='apt update && apt upgrade -y'
alias myip='curl -s ifconfig.me'
alias ports='netstat -tulanp'
alias path='echo -e ${PATH//:/\\n}'
alias mkdir='mkdir -pv'
ALIASES
                source "$alias_file" 2>/dev/null
                clear; show_banner; draw_top
                print_line "COMMON ALIASES ADDED ✓" "$G"
                print_line "ll, la, cls, .., ..., update, myip, ports, path, mkdir" "$D"
                draw_bot; sleep 2 ;;
            0) return ;;
        esac
    done
}

# ═══════════════════════════════════════════════════════════
# FEATURE 7: PLUGIN SYSTEM
# ═══════════════════════════════════════════════════════════
do_plugin_system() {
    while true; do
        clear; show_banner
        draw_top
        print_line "PLUGIN SYSTEM" "$Y"
        draw_sep
        print_line "Auto-loaded from: $QUINX_PLUGINS" "$D"
        draw_sep

        # List installed plugins
        local count=0
        if [ -d "$QUINX_PLUGINS" ]; then
            for p in "$QUINX_PLUGINS"/*.sh; do
                [ -f "$p" ] || continue
                local pname=$(basename "$p" .sh)
                printf "${C}${left_pad}║${RS}  ${G}●${RS} %-25s" "$pname"
                printf '%*s' $(( BOX_WIDTH - 2 - 28 )) "" "${C}║${RS}\n"
                count=$((count + 1))
            done
        fi
        [ $count -eq 0 ] && print_line "No plugins installed" "$D"

        draw_sep
        print_item "1" "View Plugin Info " "Show plugin details" "$G"
        print_item "2" "Create Plugin    " "Write a new plugin" "$G"
        print_item "3" "Plugin Directory " "Open plugins folder" "$B"
        draw_sep
        print_item "0" "Back             " "Return to menu" "$R"
        draw_bot; echo ""
        echo -ne "${left_pad}${C}  Selection ❯ ${RS}"
        read -r plug_choice
        case $plug_choice in
            1)
                echo ""
                echo -ne "${left_pad}${C}  Plugin name: ${RS}"
                read -r plug_name
                local plug_file="$QUINX_PLUGINS/${plug_name}.sh"
                if [ -f "$plug_file" ]; then
                    clear; show_banner; draw_top
                    print_line "PLUGIN: $plug_name" "$Y"
                    draw_sep
                    head -5 "$plug_file" | while IFS= read -r line; do
                        printf "${C}${left_pad}║${RS}  ${W}%-56s${RS}" "$line"
                        printf '%*s' $(( BOX_WIDTH - 2 - 58 )) "" "${C}║${RS}\n"
                    done
                    draw_bot
                else
                    echo -e "\n${left_pad}${R}  Plugin not found${RS}"
                fi
                echo ""; echo -ne "${left_pad}${C}  Press Enter...${RS}"
                read -r ;;
            2)
                echo ""
                echo -ne "${left_pad}${C}  Plugin name: ${RS}"
                read -r new_plugin
                echo -e "${left_pad}${D}  Enter function (Ctrl+D when done):${RS}"
                local new_file="$QUINX_PLUGINS/${new_plugin}.sh"
                echo "#!/bin/bash" > "$new_file"
                echo "# QuinxOS Plugin: $new_plugin" >> "$new_file"
                echo "" >> "$new_file"
                cat >> "$new_file"
                chmod +x "$new_file"
                echo -e "\n${left_pad}${G}  ✓ Plugin created: $new_plugin${RS}"
                sleep 2 ;;
            3)
                echo -e "\n${left_pad}${C}  Plugins dir: $QUINX_PLUGINS${RS}"
                echo -e "${left_pad}${D}  Drop .sh files there, restart terminal to load.${RS}"
                echo ""; echo -ne "${left_pad}${C}  Press Enter...${RS}"
                read -r ;;
            0) return ;;
        esac
    done
}

# ═══════════════════════════════════════════════════════════
# FEATURE 8: QUICK COMMANDS
# ═══════════════════════════════════════════════════════════
do_quick_commands() {
    while true; do
        clear; show_banner
        draw_top
        print_line "QUICK COMMANDS" "$Y"
        draw_sep
        print_line "Common operations in one place" "$D"
        draw_sep
        print_item "01" "Git Init + Push  " "Initialize & push repo" "$G"
        print_item "02" "Compress Folder  " "tar.gz a directory" "$G"
        print_item "03" "Find Large Files " "Top 10 biggest files" "$G"
        print_item "04" "Kill Port        " "Kill process on port" "$Y"
        print_item "05" "Quick HTTP Serve " "Start local server" "$Y"
        print_item "06" "Disk Usage       " "Show disk usage" "$B"
        print_item "07" "Process Monitor  " "Top processes by CPU" "$B"
        print_item "08" "SSH Key Gen      " "Generate SSH keypair" "$C"
        print_item "09" "WiFi Info        " "Show network details" "$C"
        print_item "10" "Systemd Status   " "List running services" "$M"
        draw_sep
        print_item "0"  "Back             " "Return to menu" "$R"
        draw_bot; echo ""
        echo -ne "${left_pad}${C}  Select ❯ ${RS}"
        read -r qc_choice
        case $qc_choice in
            1|01)
                echo ""
                echo -ne "${left_pad}${C}  Repo name: ${RS}"
                read -r repo_name
                if [ -n "$repo_name" ]; then
                    mkdir -p "$repo_name" && cd "$repo_name"
                    git init && touch README.md && git add . && git commit -m "init"
                    echo -e "${left_pad}${G}  ✓ Git repo initialized${RS}"
                    echo -ne "${left_pad}${C}  Push to GitHub URL (or Enter to skip): ${RS}"
                    read -r remote_url
                    [ -n "$remote_url" ] && git remote add origin "$remote_url" && git push -u origin main
                    cd ..
                fi
                sleep 2 ;;
            2|02)
                echo ""
                echo -ne "${left_pad}${C}  Folder path: ${RS}"
                read -r folder_path
                if [ -d "$folder_path" ]; then
                    tar czf "$(basename "$folder_path").tar.gz" "$folder_path"
                    echo -e "${left_pad}${G}  ✓ Compressed: $(basename "$folder_path").tar.gz${RS}"
                else
                    echo -e "${left_pad}${R}  Directory not found${RS}"
                fi
                sleep 2 ;;
            3|03)
                clear; show_banner; draw_top
                print_line "TOP 10 LARGEST FILES" "$Y"
                draw_sep
                find / -type f -exec du -h {} + 2>/dev/null | sort -rh | head -10 | while IFS= read -r line; do
                    printf "${C}${left_pad}║${RS}  ${W}%-56s${RS}" "$line"
                    printf '%*s' $(( BOX_WIDTH - 2 - 58 )) "" "${C}║${RS}\n"
                done
                draw_bot; echo ""
                echo -ne "${left_pad}${C}  Press Enter...${RS}"
                read -r ;;
            4|04)
                echo ""
                echo -ne "${left_pad}${C}  Port number: ${RS}"
                read -r port_num
                if [ -n "$port_num" ]; then
                    local pid=$(lsof -t -i:"$port_num" 2>/dev/null)
                    if [ -n "$pid" ]; then
                        kill -9 "$pid"
                        echo -e "${left_pad}${G}  ✓ Killed process $pid on port $port_num${RS}"
                    else
                        echo -e "${left_pad}${D}  No process on port $port_num${RS}"
                    fi
                fi
                sleep 2 ;;
            5|05)
                echo ""
                echo -ne "${left_pad}${C}  Port [8080]: ${RS}"
                read -r serve_port
                serve_port=${serve_port:-8080}
                echo -e "${left_pad}${G}  Starting server on :$serve_port ...${RS}"
                echo -e "${left_pad}${D}  Press Ctrl+C to stop${RS}"
                python3 -m http.server "$serve_port" 2>/dev/null || python -m SimpleHTTPServer "$serve_port" 2>/dev/null ;;
            6|06)
                clear; show_banner; draw_top
                print_line "DISK USAGE" "$Y"
                draw_sep
                df -h 2>/dev/null | while IFS= read -r line; do
                    printf "${C}${left_pad}║${RS}  ${W}%-56s${RS}" "$line"
                    printf '%*s' $(( BOX_WIDTH - 2 - 58 )) "" "${C}║${RS}\n"
                done
                draw_bot; echo ""
                echo -ne "${left_pad}${C}  Press Enter...${RS}"
                read -r ;;
            7|07)
                clear; show_banner; draw_top
                print_line "TOP PROCESSES (CPU)" "$Y"
                draw_sep
                ps aux 2>/dev/null | sort -nrk 3 | head -10 | while IFS= read -r line; do
                    printf "${C}${left_pad}║${RS}  ${W}%-56s${RS}" "$line"
                    printf '%*s' $(( BOX_WIDTH - 2 - 58 )) "" "${C}║${RS}\n"
                done
                draw_bot; echo ""
                echo -ne "${left_pad}${C}  Press Enter...${RS}"
                read -r ;;
            8|08)
                echo ""
                echo -ne "${left_pad}${C}  Email (for key comment): ${RS}"
                read -r ssh_email
                if [ -n "$ssh_email" ]; then
                    ssh-keygen -t ed25519 -C "$ssh_email" -f "$HOME/.ssh/id_ed25519" -N ""
                    echo -e "\n${left_pad}${G}  ✓ SSH key generated${RS}"
                    echo -e "${left_pad}${W}  Public key:${RS}"
                    cat "$HOME/.ssh/id_ed25519.pub"
                fi
                echo ""; echo -ne "${left_pad}${C}  Press Enter...${RS}"
                read -r ;;
            9|09)
                clear; show_banner; draw_top
                print_line "NETWORK DETAILS" "$Y"
                draw_sep
                local h=$(hostname 2>/dev/null)
                local lip=$(ip route get 1.1.1.1 2>/dev/null | grep -oP 'src \K\S+')
                local pip=$(curl -s --max-time 5 ifconfig.me 2>/dev/null || echo "N/A")
                printf "${C}${left_pad}║${RS}  ${W}Hostname:${RS}    ${G}%-30s${RS}" "$h"
                printf '%*s' $(( BOX_WIDTH - 2 - 35 )) "" "${C}║${RS}\n"
                printf "${C}${left_pad}║${RS}  ${W}Local IP:${RS}    ${G}%-30s${RS}" "${lip:-N/A}"
                printf '%*s' $(( BOX_WIDTH - 2 - 35 )) "" "${C}║${RS}\n"
                printf "${C}${left_pad}║${RS}  ${W}Public IP:${RS}   ${G}%-30s${RS}" "$pip"
                printf '%*s' $(( BOX_WIDTH - 2 - 35 )) "" "${C}║${RS}\n"
                draw_bot; echo ""
                echo -ne "${left_pad}${C}  Press Enter...${RS}"
                read -r ;;
            10)
                clear; show_banner; draw_top
                print_line "RUNNING SERVICES" "$Y"
                draw_sep
                ps aux 2>/dev/null | awk '{print $11}' | sort | uniq -c | sort -rn | head -15 | while IFS= read -r line; do
                    printf "${C}${left_pad}║${RS}  ${W}%-56s${RS}" "$line"
                    printf '%*s' $(( BOX_WIDTH - 2 - 58 )) "" "${C}║${RS}\n"
                done
                draw_bot; echo ""
                echo -ne "${left_pad}${C}  Press Enter...${RS}"
                read -r ;;
            0|00) return ;;
        esac
    done
}

# ═══════════════════════════════════════════════════════════
# FEATURE 9: CUSTOM ASCII ART
# ═══════════════════════════════════════════════════════════
do_custom_banner_text() {
    clear; show_banner
    draw_top
    print_line "CUSTOM ASCII ART" "$Y"
    draw_sep
    print_line "Set your own banner text" "$D"
    draw_bot; echo ""
    echo -e "${left_pad}${C}  Current custom text: ${W}$(cat "$QUINX_HOME/.custom-banner-text" 2>/dev/null || echo 'PROC')${RS}"
    echo ""
    echo -ne "${left_pad}${C}  Enter new text (max 12 chars): ${RS}"
    read -r custom_text
    if [ -n "$custom_text" ]; then
        echo "$custom_text" > "$QUINX_HOME/.custom-banner-text"
        clear; show_banner; draw_top
        print_line "CUSTOM TEXT SET: $custom_text" "$G"
        print_line "Preview with: figlet -f ASCII-Shadow '$custom_text'" "$D"
        draw_bot
    fi
    sleep 2
}

# ─── Core Functions ────────────────────────────────────────
do_necessary_setup() {
    clear; show_banner; draw_top
    print_line "INSTALLING CORE DEPENDENCIES" "$Y"
    draw_sep
    print_line "Please wait..." "$D"
    draw_bot; echo ""
    apt update -y && apt upgrade -y
    pkg install zsh git figlet toilet ruby wget curl -y
    gem install lolcat; pkg install toilet figlet exa -y
    mkdir -p "$QUINX_HOME/.object"
    [ -f "$QUINX_HOME/.object/ANSI Shadow.flf" ] && cp -r "$QUINX_HOME/.object/ANSI Shadow.flf" "$PREFIX/share/figlet/ASCII-Shadow.flf" 2>/dev/null
    git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh 2>/dev/null
    rm -rf ~/.termux/colors.properties; rm -rf /data/data/com.termux/files/usr/etc/motd
    [ -f "$QUINX_HOME/.object/colors.properties" ] && cp -r "$QUINX_HOME/.object/colors.properties" ~/.termux/colors.properties
    [ -f "$QUINX_HOME/.object/termux.properties" ] && cp -r "$QUINX_HOME/.object/termux.properties" ~/.termux.properties
    curl -L https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/FiraCode/Regular/FiraCodeNerdFont-Regular.ttf > ~/.termux/font.ttf 2>/dev/null
    termux-reload-settings 2>/dev/null
    clear; show_banner; draw_top
    print_line "SETUP COMPLETE ✓" "$G"
    draw_bot; sleep 2
}

do_zsh_setup() {
    clear; show_banner; draw_top
    print_line "CONFIGURING ZSH ENVIRONMENT" "$Y"
    draw_sep; print_line "Resetting .zshrc and installing Oh My Zsh..." "$D"; draw_bot
    rm -rf ~/.zshrc; git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh 2>/dev/null
    cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
    clear; show_banner; draw_top
    print_line "ZSH SETUP COMPLETE ✓" "$G"
    draw_bot; sleep 2
}

do_set_zsh() { pkg install zsh -y; chsh -s zsh; clear; show_banner; draw_top; print_line "DEFAULT SHELL → ZSH ✓" "$G"; draw_bot; sleep 2; }
do_set_bash() { chsh -s bash; clear; show_banner; draw_top; print_line "DEFAULT SHELL → BASH ✓" "$G"; draw_bot; sleep 2; }

do_set_banner() {
    clear; show_banner; draw_top
    print_line "BANNER STYLE SELECTOR" "$Y"
    draw_sep
    print_item "1" "Block Letters " "Bold gradient style" "$C"
    print_item "2" "Box Art      " "Framed pixel art" "$M"
    print_item "3" "Clean Box    " "Minimal frame" "$G"
    draw_sep
    print_item "0" "Back         " "Return to menu" "$R"
    draw_bot; echo ""
    echo -ne "${left_pad}${C}  Style ❯ ${RS}"
    read -r style_choice
    case $style_choice in
        1|2|3) echo "$style_choice" > "$QUINX_HOME/.banner-style"; clear; show_banner; draw_top; print_line "BANNER STYLE $style_choice SET ✓" "$G"; draw_bot ;;
        0) return ;;
    esac; sleep 2
}

do_set_theme() {
    clear; show_banner; draw_top
    print_line "SHELL THEME SETUP" "$Y"
    draw_sep; print_line "Max 12 characters recommended" "$D"; draw_bot; echo ""
    echo -ne "${left_pad}${C}  Enter Shell Name ❯ ${RS}"
    read -r shell_name
    if [ -f "$QUINX_HOME/.object/quinx.zsh-theme" ]; then
        mkdir -p ~/.oh-my-zsh/themes
        sed "s/\PROC/${shell_name}/g" "$QUINX_HOME/.object/quinx.zsh-theme" > ~/.oh-my-zsh/themes/quinx.zsh-theme 2>/dev/null
    fi
    clear; show_banner; draw_top; print_line "THEME SET TO: ${shell_name}" "$G"; draw_bot; sleep 2
}

do_plugins() {
    clear; show_banner; draw_top
    print_line "INSTALLING ZSH PLUGINS" "$Y"
    draw_sep; print_line "Syntax Highlighting + Autosuggestions" "$D"; draw_bot; echo ""
    git clone https://github.com/zsh-users/zsh-autosuggestions "$HOME/.oh-my-zsh/plugins/zsh-autosuggestions" 2>/dev/null
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME/.oh-my-zsh/plugins/zsh-syntax-highlighting" 2>/dev/null
    if [ -f "$QUINX_HOME/.object/zshrc-full" ]; then sed "s/\PROC/${USER:-Quinx}/g" "$QUINX_HOME/.object/zshrc-full" > ~/.zshrc; fi
    if [ -f "$QUINX_HOME/.object/quinx.zsh-theme" ]; then mkdir -p ~/.oh-my-zsh/themes; sed "s/\PROC/${USER:-Quinx}/g" "$QUINX_HOME/.object/quinx.zsh-theme" > ~/.oh-my-zsh/themes/quinx.zsh-theme 2>/dev/null; fi
    clear; show_banner; draw_top
    print_line "PLUGINS INSTALLED ✓" "$G"
    print_line "Syntax Highlighting: ACTIVE" "$G"
    print_line "Autosuggestions: ACTIVE" "$G"
    draw_bot; sleep 2
}

do_sysinfo() {
    clear; show_banner; draw_top
    print_line "SYSTEM INFORMATION" "$Y"
    draw_sep
    local arch=$(uname -m 2>/dev/null) kernel=$(uname -r 2>/dev/null) os_name=$(uname -o 2>/dev/null)
    local uptime_info=$(uptime -p 2>/dev/null || echo "N/A")
    local disk=$(df -h / 2>/dev/null | tail -1 | awk '{print $3"/"$2" ("$5" used)"}')
    local mem=$(free -h 2>/dev/null | awk '/Mem:/{print $3"/"$2}')
    local cpu=$(nproc 2>/dev/null || echo "?")
    local pkgs=$(dpkg -l 2>/dev/null | grep -c '^ii' || echo "?")
    for entry in "OS:${os_name}" "Arch:${arch}" "Kernel:${kernel}" "Uptime:${uptime_info}" "CPU:${cpu} cores" "Memory:${mem}" "Disk:${disk}" "Packages:${pkgs} installed"; do
        local key="${entry%%:*}"; local val="${entry#*:}"
        printf "${C}${left_pad}║${RS}  ${W}%-10s${RS} ${G}%-30s${RS}" "$key:" "$val"
        printf '%*s' $(( BOX_WIDTH - 2 - 42 )) "" "${C}║${RS}\n"
    done
    print_line ""; draw_bot; echo ""
    echo -ne "${left_pad}${C}  Press Enter to return...${RS}"
    read -r
}

do_network_info() {
    clear; show_banner; draw_top
    print_line "NETWORK INFORMATION" "$Y"
    draw_sep
    local local_ip=$(ip route get 1.1.1.1 2>/dev/null | grep -oP 'src \K\S+')
    local public_ip=$(curl -s --max-time 5 ifconfig.me 2>/dev/null || echo "N/A")
    local dns=$(grep -m1 'nameserver' /etc/resolv.conf 2>/dev/null | awk '{print $2}' || echo "N/A")
    local hostname=$(hostname 2>/dev/null || echo "N/A")
    for entry in "Hostname:${hostname}" "Local IP:${local_ip:-N/A}" "Public IP:${public_ip}" "DNS:${dns}"; do
        local key="${entry%%:*}"; local val="${entry#*:}"
        printf "${C}${left_pad}║${RS}  ${W}%-10s${RS} ${G}%-30s${RS}" "$key:" "$val"
        printf '%*s' $(( BOX_WIDTH - 2 - 42 )) "" "${C}║${RS}\n"
    done
    draw_sep; print_line "CONNECTIVITY TEST" "$Y"; draw_sep
    for target in "8.8.8.8:Google DNS" "1.1.1.1:Cloudflare"; do
        local addr="${target%%:*}"; local name="${target#*:}"
        local ping_t=$(ping -c1 -W3 "$addr" 2>/dev/null | grep -oP 'time=\K\S+')
        if [ -n "$ping_t" ]; then
            printf "${C}${left_pad}║${RS}  ${W}%-12s${RS} ${G}✓ %s${RS}" "$name:" "$ping_t"
            printf '%*s' $(( BOX_WIDTH - 2 - 18 - ${#ping_t} )) "" "${C}║${RS}\n"
        else
            printf "${C}${left_pad}║${RS}  ${W}%-12s${RS} ${R}✗ Timeout${RS}" "$name:"
            printf '%*s' $(( BOX_WIDTH - 2 - 23 )) "" "${C}║${RS}\n"
        fi
    done
    print_line ""; draw_bot; echo ""
    echo -ne "${left_pad}${C}  Press Enter to return...${RS}"
    read -r
}

do_backup() {
    clear; show_banner; draw_top
    print_line "BACKUP & RESTORE" "$Y"
    draw_sep
    print_item "1" "Backup  " "Save current config" "$G"
    print_item "2" "Restore " "Load saved config" "$G"
    print_item "0" "Back    " "Return to menu" "$R"
    draw_bot; echo ""
    echo -ne "${left_pad}${C}  Selection ❯ ${RS}"
    read -r choice
    case $choice in
        1)
            local backup_dir="$QUINX_HOME/backups/$(date +%Y%m%d_%H%M%S)"
            mkdir -p "$backup_dir"
            for f in ~/.zshrc ~/.bashrc "$QUINX_HOME/.current-theme" "$QUINX_HOME/.banner-style" "$QUINX_HOME/.quinx-aliases" "$QUINX_HOME/.custom-banner-text"; do
                [ -f "$f" ] && cp "$f" "$backup_dir/"
            done
            [ -d ~/.termux ] && cp -r ~/.termux "$backup_dir/"
            [ -d ~/.oh-my-zsh/themes ] && cp -r ~/.oh-my-zsh/themes "$backup_dir/themes" 2>/dev/null
            clear; show_banner; draw_top; print_line "BACKUP SAVED ✓" "$G"; print_line "$backup_dir" "$D"; draw_bot; sleep 2 ;;
        2)
            if [ -d "$QUINX_HOME/backups" ]; then
                local latest=$(ls -t "$QUINX_HOME/backups/" 2>/dev/null | head -1)
                if [ -n "$latest" ]; then
                    local bdir="$QUINX_HOME/backups/$latest"
                    for f in .zshrc .bashrc .current-theme .banner-style .quinx-aliases .custom-banner-text; do
                        [ -f "$bdir/$f" ] && cp "$bdir/$f" "$QUINX_HOME/"
                    done
                    [ -f "$bdir/.zshrc" ] && cp "$bdir/.zshrc" ~/.zshrc
                    [ -f "$bdir/.bashrc" ] && cp "$bdir/.bashrc" ~/.bashrc
                    [ -d "$bdir/.termux" ] && cp -r "$bdir/.termux/"* ~/.termux/ 2>/dev/null
                    clear; show_banner; draw_top; print_line "RESTORED FROM: $latest" "$G"; draw_bot
                else echo -e "\n${left_pad}${R}  No backups found.${RS}"
                fi
            else echo -e "\n${left_pad}${R}  No backups directory.${RS}"
            fi; sleep 2 ;;
    esac
}

# ─── Motd Editor ──────────────────────────────────────────
do_motd_editor() {
    clear; show_banner; draw_top
    print_line "MOTD EDITOR" "$Y"
    draw_sep
    print_item "1" "Set Custom MOTD " "Write your own message" "$G"
    print_item "2" "Default MOTD    " "QuinxOS branded message" "$G"
    print_item "3" "Disable MOTD    " "No message on boot" "$R"
    draw_sep
    print_item "0" "Back            " "Return to menu" "$R"
    draw_bot; echo ""
    echo -ne "${left_pad}${C}  Selection ❯ ${RS}"
    read -r motd_choice
    local motd_file="/data/data/com.termux/files/usr/etc/motd"
    case $motd_choice in
        1) echo ""; echo -ne "${left_pad}${C}  Enter MOTD text: ${RS}"; read -r motd_text
           echo -e "\033[1;96m${motd_text}\033[0m" > "$motd_file"
           clear; show_banner; draw_top; print_line "CUSTOM MOTD SET ✓" "$G"; draw_bot; sleep 2 ;;
        2) cat > "$motd_file" << 'MOTD_EOF'
\033[1;96m
  ╔═══════════════════════════════════════╗
  ║        Welcome to QuinxOS v4.2        ║
  ║       by Shineii86                    ║
  ╚═══════════════════════════════════════╝
\033[0m
MOTD_EOF
           clear; show_banner; draw_top; print_line "DEFAULT MOTD SET ✓" "$G"; draw_bot; sleep 2 ;;
        3) rm -f "$motd_file"; clear; show_banner; draw_top; print_line "MOTD DISABLED ✓" "$G"; draw_bot; sleep 2 ;;
        0) return ;;
    esac
}

# ─── Quinx Shield ─────────────────────────────────────────
generate_recovery_key() { cat /dev/urandom 2>/dev/null | tr -dc 'A-Za-z0-9' | head -c 16; }

do_cyber_lock() {
    clear; show_banner; draw_top
    print_line "QUINX SHIELD — SECURITY LOCK" "$Y"
    draw_sep; print_line "Protect your terminal with encrypted access" "$D"; draw_bot; echo ""
    echo -ne "${left_pad}${C}  Create Access Key ❯ ${RS}"; read -s new_pass; echo
    echo -ne "${left_pad}${C}  Confirm Access Key ❯ ${RS}"; read -s confirm_pass; echo
    if [ "$new_pass" != "$confirm_pass" ]; then echo -e "\n${left_pad}${R}  ✗ Keys do not match. Aborting.${RS}"; sleep 2; return; fi

    local recovery_key=$(generate_recovery_key)
    echo "$recovery_key" > "$QUINX_HOME/.quinx-recovery"; chmod 600 "$QUINX_HOME/.quinx-recovery"

    # Emergency unlock script
    cat > "$QUINX_HOME/quinx-unlock" << 'UNLOCK_EOF'
#!/bin/bash
R='\033[1;31m'; G='\033[1;32m'; C='\033[1;96m'; W='\033[1;97m'; RS='\033[0m'
echo -e "\n${C}  QUINX SHIELD — EMERGENCY UNLOCK${RS}\n"
echo -ne "  Enter recovery key: "; read -s input_key; echo
QUINX_HOME="$HOME/QuinxOS"
if [ -f "$QUINX_HOME/.quinx-recovery" ] && [ "$input_key" = "$(cat "$QUINX_HOME/.quinx-recovery")" ]; then
    sed -i '/#QUINX_LOCK_START/,/#QUINX_LOCK_END/d' ~/.bashrc 2>/dev/null
    [ -f ~/.zshrc ] && sed -i '/#QUINX_LOCK_START/,/#QUINX_LOCK_END/d' ~/.zshrc 2>/dev/null
    echo -e "\n  ${G}✓ QUINX SHIELD REMOVED${RS}"; rm -f "$QUINX_HOME/.quinx-recovery"; exit 0
fi
echo -e "\n  ${R}✗ INVALID KEY${RS}"; exit 1
UNLOCK_EOF
    chmod +x "$QUINX_HOME/quinx-unlock"

    local lock_code='#QUINX_LOCK_START
clear
echo -e "\033[1;36m  ┌─────────────────────────────────────┐"
echo -e "  │     QUINX SHIELD — ACCESS GATE      │"
echo -e "  └─────────────────────────────────────┘\033[0m"
echo -e "\033[1;33m  Initializing security protocols...\033[0m"; sleep 0.5
attempt=1
while [ $attempt -le 3 ]; do
    echo -e "\n\033[1;36m  ╔══════════════════════════════════════╗"
    echo -e "  ║        \033[1;31mQUINX SHIELD ACCESS           \033[1;36m║"
    echo -e "  ╚══════════════════════════════════════╝\033[0m"
    echo -ne "\033[1;33m  [Attempt $attempt/3] Enter Key: \033[0m"; read -s pass_input; echo
    if [ "$pass_input" = "'"$new_pass"'" ]; then
        echo -e "\033[1;32m  ✓ ACCESS GRANTED.\033[0m"; sleep 1; clear; break
    else
        echo -e "\033[1;31m  ✗ ACCESS DENIED.\033[0m"
        if [ $attempt -eq 3 ]; then
            echo -e "\033[1;31m  ╔══════════════════════════════════════╗"
            echo -e "  ║   LOCKED OUT — RECOVERY OPTIONS      ║"
            echo -e "  ╠══════════════════════════════════════╣"
            echo -e "  ║  1. bash ~/QuinxOS/quinx-unlock      ║"
            echo -e "  ║  2. Enter recovery key below          ║"
            echo -e "  ║  3. nano ~/.bashrc (delete lock)      ║"
            echo -e "  ╚══════════════════════════════════════╝\033[0m"
            echo -ne "\033[1;33m  Recovery key (or Enter to exit): \033[0m"; read -s rkey; echo
            if [ -n "$rkey" ] && [ -f "'"$QUINX_HOME"'/.quinx-recovery" ] && [ "$rkey" = "$(cat '"$QUINX_HOME"'/ 2>/dev/null/.quinx-recovery)" ]; then
                sed -i "/#QUINX_LOCK_START/,/#QUINX_LOCK_END/d" ~/.bashrc 2>/dev/null
                [ -f ~/.zshrc ] && sed -i "/#QUINX_LOCK_START/,/#QUINX_LOCK_END/d" ~/.zshrc 2>/dev/null
                echo -e "\033[1;32m  ✓ RECOVERY SUCCESSFUL.\033[0m"; rm -f "'"$QUINX_HOME"'/.quinx-recovery"; sleep 2; clear; break
            fi
            echo -e "\033[1;31m  ✗ SESSION TERMINATED.\033[0m"; exit
        fi; attempt=$((attempt + 1))
    fi
done
#QUINX_LOCK_END'

    add_to_top() {
        if [ -f "$1" ]; then echo "$lock_code" > "$1.tmp"; cat "$1" >> "$1.tmp"; mv "$1.tmp" "$1"
        else echo "$lock_code" > "$1"; fi
    }
    add_to_top ~/.bashrc; [ -f ~/.zshrc ] && add_to_top ~/.zshrc

    clear; show_banner; draw_top
    print_line ""; print_line "QUINX SHIELD ACTIVATED ✓" "$G"
    draw_sep; print_line "⚠ SAVE YOUR RECOVERY KEY ⚠" "$R"
    print_line ""; print_line "Key: $recovery_key" "$G"
    print_line "File: $QUINX_HOME/.quinx-recovery" "$D"
    print_line "Unlock: bash ~/QuinxOS/quinx-unlock" "$D"
    print_line ""; draw_bot; echo ""
    echo -ne "${left_pad}${C}  Press Enter after saving your key...${RS}"; read -r
}

do_remove_lock() {
    sed -i '/#QUINX_LOCK_START/,/#QUINX_LOCK_END/d' ~/.bashrc 2>/dev/null
    [ -f ~/.zshrc ] && sed -i '/#QUINX_LOCK_START/,/#QUINX_LOCK_END/d' ~/.zshrc 2>/dev/null
    rm -f "$QUINX_HOME/.quinx-recovery" "$QUINX_HOME/quinx-unlock" 2>/dev/null
    clear; show_banner; draw_top; print_line ""; print_line "QUINX SHIELD DEACTIVATED" "$R"; print_line ""; draw_bot; sleep 2
}

do_update() {
    clear; show_banner; draw_top; print_line "UPDATING QUINXOS" "$Y"
    draw_sep; print_line "Pulling latest from GitHub..." "$D"; draw_bot; echo ""
    rm -rf "$QUINX_HOME"; cd "$HOME"
    git clone https://github.com/Shineii86/QuinxOS.git 2>/dev/null; cd "$QUINX_HOME"
    clear; show_banner; draw_top; print_line "UPDATE COMPLETE ✓" "$G"; draw_bot; sleep 2
}

do_uninstall() {
    clear; show_banner; draw_top
    print_line "UNINSTALL QUINXOS" "$R"
    draw_sep; print_line "This will remove all QuinxOS components" "$D"; draw_sep
    print_line "Removes: QuinxOS dir, themes, shield, plugins" "$D"
    print_line "Keeps: Oh My Zsh, .zshrc, .bashrc, font" "$D"
    draw_sep
    print_item "1" "Confirm Uninstall" "Remove QuinxOS" "$R"
    print_item "0" "Cancel           " "Keep everything" "$G"
    draw_bot; echo ""
    echo -ne "${left_pad}${C}  Are you sure? ❯ ${RS}"
    read -r confirm
    case $confirm in
        1)
            sed -i '/#QUINX_LOCK_START/,/#QUINX_LOCK_END/d' ~/.bashrc 2>/dev/null
            [ -f ~/.zshrc ] && sed -i '/#QUINX_LOCK_START/,/#QUINX_LOCK_END/d' ~/.zshrc 2>/dev/null
            rm -f ~/.oh-my-zsh/themes/quinx.zsh-theme 2>/dev/null
            rm -f /data/data/com.termux/files/usr/etc/motd 2>/dev/null
            rm -rf "$QUINX_HOME" "$QUINX_MARKER"
            clear; show_banner; draw_top; print_line ""; print_line "QUINXOS UNINSTALLED ✓" "$R"
            print_line "Thank you for using QuinxOS!" "$W"; print_line ""; draw_bot
            echo ""; echo -ne "${left_pad}${C}  Press Enter...${RS}"; read -r; exit 0 ;;
        *) return ;;
    esac
}

# ═══════════════════════════════════════════════════════════
# FIRST-RUN WIZARD
# ═══════════════════════════════════════════════════════════
do_first_run_wizard() {
    clear
    echo ""
    echo -e "${C}    ██████╗ ██╗   ██╗██╗███╗   ██╗██╗  ██╗ ██████╗ ███████╗${RS}"
    echo -e "${C}   ██╔═══██╗██║   ██║██║████╗  ██║╚██╗██╔╝██╔═══██╗██╔════╝${RS}"
    echo -e "${C}   ██║   ██║██║   ██║██║██╔██╗ ██║ ╚███╔╝ ██║   ██║███████╗${RS}"
    echo -e "${C}   ██║▄▄ ██║██║   ██║██║██║╚██╗██║ ██╔██╗ ██║   ██║╚════██║${RS}"
    echo -e "${C}   ╚██████╔╝╚██████╔╝██║██║ ╚████║██╔╝ ██╗╚██████╔╝███████║${RS}"
    echo -e "${C}    ╚══▀▀═╝  ╚═════╝ ╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝${RS}"
    echo ""
    echo -e "${M}  ╔═══════════════════════════════════════════════════════════╗${RS}"
    echo -e "${M}  ║           ${W}WELCOME TO QUINXOS v${QUINX_VERSION} SETUP WIZARD${M}           ║${RS}"
    echo -e "${M}  ╚═══════════════════════════════════════════════════════════╝${RS}"
    echo ""

    # Shell
    echo -e "${C}  ── Step 1/4: Choose Your Shell ──${RS}"
    echo -e "  ${W}[1]${G} Zsh (recommended)${RS}  ${W}[2]${G} Bash${RS}"
    echo -ne "${C}  Your choice [1-2]: ${RS}"; read -r shell_choice
    case $shell_choice in
        2) chsh -s bash ;;
        *) pkg install zsh -y 2>&1 | tail -1; chsh -s zsh ;;
    esac

    # Theme
    echo ""
    echo -e "${C}  ── Step 2/4: Choose Your Theme ──${RS}"
    echo -e "  ${W}[1]${C} Cyber Midnight  ${W}[2]${G} Matrix Green  ${W}[3]${Y} Solar Flare${RS}"
    echo -e "  ${W}[4]${B} Arctic Blue     ${W}[5]${M} Purple Haze   ${W}[6]${M} Dracacula${RS}"
    echo -e "  ${W}[7]${B} Nord            ${W}[8]${Y} Gruvbox       ${W}[9]${B} Tokyo Night${RS}"
    echo -e "  ${W}[10]${M} Catppuccin    ${W}[11]${G} Everforest    ${W}[12]${Y} Monokai${RS}"
    echo -e "  ${W}[13]${R} Synthwave     ${W}[14]${M} Rose Pine     ${W}[15]${B} Kanagawa${RS}"
    echo -ne "${C}  Your choice [1-15]: ${RS}"; read -r tw
    local tfiles=("cyber-midnight" "matrix-green" "solar-flare" "arctic-blue" "purple-haze" "dracacula" "nord" "gruvbox" "tokyo-night" "catppuccin-mocha" "everforest" "monokai" "synthwave" "rose-pine" "kanagawa")
    local tnames=("Cyber Midnight" "Matrix Green" "Solar Flare" "Arctic Blue" "Purple Haze" "Dracacula" "Nord" "Gruvbox" "Tokyo Night" "Catppuccin Mocha" "Everforest" "Monokai" "Synthwave" "Rose Pine" "Kanagawa")
    local idx=$(( ${tw:-1} - 1 ))
    [ $idx -lt 0 ] && idx=0; [ $idx -gt 14 ] && idx=0
    [ -f "$QUINX_THEMES/${tfiles[$idx]}.colors" ] && cp "$QUINX_THEMES/${tfiles[$idx]}.colors" ~/.termux/colors.properties 2>/dev/null
    echo "${tnames[$idx]}" > "$QUINX_HOME/.current-theme"
    echo -e "\n  ${G}Theme: ${tnames[$idx]}${RS}"

    # Banner
    echo ""
    echo -e "${C}  ── Step 3/4: Banner Style ──${RS}"
    echo -e "  ${W}[1]${C} Block Letters  ${W}[2]${M} Box Art  ${W}[3]${G} Clean Box${RS}"
    echo -ne "${C}  Your choice [1-3]: ${RS}"; read -r banner_choice
    echo "$banner_choice" > "$QUINX_HOME/.banner-style"

    # Name
    echo ""
    echo -e "${C}  ── Step 4/4: Display Name ──${RS}"
    echo -ne "${C}  Enter name (max 12): ${RS}"; read -r display_name
    [ -z "$display_name" ] && display_name="${USER:-Quinx}"

    # Install
    echo ""
    echo -e "${C}  ── Installing Components ──${RS}"
    echo -ne "  ${W}Dependencies: ${RS}"
    apt update -y 2>&1 | tail -1 && apt upgrade -y 2>&1 | tail -1
    pkg install zsh git figlet toilet ruby wget curl -y 2>&1 | tail -1
    gem install lolcat 2>&1 | tail -1; echo -e "${G}✓${RS}"
    echo -ne "  ${W}Oh My Zsh:    ${RS}"
    git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh 2>&1 | tail -1; echo -e "${G}✓${RS}"
    echo -ne "  ${W}Zsh Plugins:  ${RS}"
    git clone https://github.com/zsh-users/zsh-autosuggestions "$HOME/.oh-my-zsh/plugins/zsh-autosuggestions" 2>&1 | tail -1
    git clone https://github.com/zsh-users/zsh-syntax-highlighting "$HOME/.oh-my-zsh/plugins/zsh-syntax-highlighting" 2>&1 | tail -1
    echo -e "${G}✓${RS}"
    echo -ne "  ${W}Font:         ${RS}"
    [ -f "$QUINX_HOME/.object/ANSI Shadow.flf" ] && cp "$QUINX_HOME/.object/ANSI Shadow.flf" "$PREFIX/share/figlet/ASCII-Shadow.flf" 2>/dev/null
    curl -L https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/FiraCode/Regular/FiraCodeNerdFont-Regular.ttf > ~/.termux/font.ttf 2>/dev/null
    echo -e "${G}✓${RS}"
    echo -ne "  ${W}Config:       ${RS}"
    [ -f "$QUINX_HOME/.object/termux.properties" ] && cp "$QUINX_HOME/.object/termux.properties" ~/.termux.properties
    [ -f "$QUINX_HOME/.object/zshrc-full" ] && sed "s/\PROC/${display_name}/g" "$QUINX_HOME/.object/zshrc-full" > ~/.zshrc
    [ -f "$QUINX_HOME/.object/quinx.zsh-theme" ] && mkdir -p ~/.oh-my-zsh/themes && sed "s/\PROC/${display_name}/g" "$QUINX_HOME/.object/quinx.zsh-theme" > ~/.oh-my-zsh/themes/quinx.zsh-theme 2>/dev/null
    termux-reload-settings 2>/dev/null; echo -e "${G}✓${RS}"

    echo "v${QUINX_VERSION}" > "$QUINX_MARKER"

    echo ""
    echo -e "${M}  ╔═══════════════════════════════════════════════════════════╗${RS}"
    echo -e "${M}  ║              ${G}✓ SETUP COMPLETE!${M}                          ║${RS}"
    echo -e "${M}  ║  ${W}Shell: ${G}$(basename "$SHELL")${M}   Theme: ${G}${tnames[$idx]}${M}   Name: ${G}${display_name}${M}  ║${RS}"
    echo -e "${M}  ║  ${W}Restart your terminal to see the changes!${M}               ║${RS}"
    echo -e "${M}  ╚═══════════════════════════════════════════════════════════╝${RS}"
    echo ""
    echo -ne "${C}  Press Enter to continue...${RS}"; read -r
}

# ═══════════════════════════════════════════════════════════
# MAIN MENU — 20 OPTIONS
# ═══════════════════════════════════════════════════════════
main_menu() {
    while true; do
        show_banner; show_status; echo ""
        draw_top
        print_line "MAIN MENU" "$Y"
        draw_sep
        print_item "01" "Core Setup       " "Install deps & fonts" "$G"
        print_item "02" "Zsh Config       " "Reset zsh environment" "$G"
        print_item "03" "Switch → Zsh     " "Set Zsh as default" "$G"
        print_item "04" "Switch → Bash    " "Set Bash as default" "$G"
        print_item "05" "Banner Style     " "3 banner designs" "$Y"
        print_item "06" "Custom Theme     " "Set shell prompt name" "$Y"
        print_item "07" "Zsh Plugins      " "Highlight + Autosuggest" "$Y"
        print_item "08" "Theme Gallery    " "15 color schemes" "$C"
        print_item "09" "Dev Tools        " "Python, Node, Go..." "$C"
        print_item "10" "Quick Commands   " "Git, compress, serve..." "$C"
        print_item "11" "Aliases Manager  " "Shell shortcuts" "$B"
        print_item "12" "Plugin System    " "Load custom scripts" "$B"
        print_item "13" "Custom ASCII Art " "Your own banner text" "$B"
        print_item "14" "Login Sound      " "Audio on boot" "$B"
        print_item "15" "System Info      " "Device details" "$M"
        print_item "16" "Network Info     " "IP, DNS, ping" "$M"
        print_item "17" "MOTD Editor      " "Boot message" "$M"
        print_item "18" "Backup/Restore   " "Save/load configs" "$M"
        print_item "19" "Quinx Shield     " "Terminal lock" "$R"
        print_item "20" "Remove Lock      " "Deactivate shield" "$R"
        draw_sep
        print_item "21" "Update QuinxOS   " "Pull latest version" "$G"
        print_item "22" "Uninstall        " "Remove completely" "$R"
        print_item "23" "RGB Animation    " "Preview boot effect" "$Y"
        draw_sep
        print_item "00" "Exit             " "Close terminal" "$R"
        draw_bot; echo ""
        echo -ne "${left_pad}${C}  ┌─ Selection ❯ ${RS}"
        read -r opt; echo ""

        case $opt in
            1|01)  do_necessary_setup ;;   2|02)  do_zsh_setup ;;
            3|03)  do_set_zsh ;;           4|04)  do_set_bash ;;
            5|05)  do_set_banner ;;        6|06)  do_set_theme ;;
            7|07)  do_plugins ;;           8|08)  do_theme_presets ;;
            9|09)  do_dev_tools ;;         10)    do_quick_commands ;;
            11)    do_aliases_manager ;;   12)    do_plugin_system ;;
            13)    do_custom_banner_text ;;14)    do_login_sound ;;
            15)    do_sysinfo ;;           16)    do_network_info ;;
            17)    do_motd_editor ;;       18)    do_backup ;;
            19)    do_cyber_lock ;;        20)    do_remove_lock ;;
            21)    do_update ;;            22)    do_uninstall ;;
            23)    do_rgb_animation ;;
            0|00)  clear; echo -e "${C}  QuinxOS ${W}— Session ended. See you next time.${RS}\n"; exit 0 ;;
            *)     continue ;;
        esac
    done
}

# ═══════════════════════════════════════════════════════════
# DEV TOOLS (from v4.1)
# ═══════════════════════════════════════════════════════════
do_dev_tools() {
    while true; do
        clear; show_banner; draw_top
        print_line "DEV TOOLS INSTALLER" "$Y"
        draw_sep
        print_item "01" "Python 3     " "pip, venv, ipython" "$G"
        print_item "02" "Node.js      " "npm, yarn" "$G"
        print_item "03" "Go           " "Go compiler" "$G"
        print_item "04" "Rust         " "cargo, rustc" "$G"
        print_item "05" "Ruby         " "gem, bundler" "$G"
        print_item "06" "PHP          " "php" "$G"
        print_item "07" "Git + SSH    " "git, openssh" "$B"
        print_item "08" "Neovim       " "Modern editor" "$B"
        print_item "09" "tmux         " "Terminal multiplexer" "$B"
        print_item "10" "All Python   " "python + numpy, pandas, flask" "$Y"
        print_item "11" "All Web      " "node + npm + php + ruby" "$Y"
        draw_sep
        print_item "0"  "Back         " "Return to menu" "$R"
        draw_bot; echo ""
        echo -ne "${left_pad}${C}  Select ❯ ${RS}"
        read -r dev_choice
        case $dev_choice in
            1|01) clear; echo -e "\n${C}  Installing Python 3...${RS}\n"; pkg install python python-pip -y 2>&1 | tail -3; pip install ipython virtualenv 2>&1 | tail -2; echo -e "\n${G}  ✓ Python 3 installed${RS}"; sleep 2 ;;
            2|02) clear; echo -e "\n${C}  Installing Node.js...${RS}\n"; pkg install nodejs -y 2>&1 | tail -3; npm install -g yarn 2>&1 | tail -2; echo -e "\n${G}  ✓ Node.js installed${RS}"; sleep 2 ;;
            3|03) clear; echo -e "\n${C}  Installing Go...${RS}\n"; pkg install golang -y 2>&1 | tail -3; echo -e "\n${G}  ✓ Go installed${RS}"; sleep 2 ;;
            4|04) clear; echo -e "\n${C}  Installing Rust...${RS}\n"; pkg install rust -y 2>&1 | tail -3; echo -e "\n${G}  ✓ Rust installed${RS}"; sleep 2 ;;
            5|05) clear; echo -e "\n${C}  Installing Ruby...${RS}\n"; pkg install ruby -y 2>&1 | tail -3; gem install bundler 2>&1 | tail -2; echo -e "\n${G}  ✓ Ruby installed${RS}"; sleep 2 ;;
            6|06) clear; echo -e "\n${C}  Installing PHP...${RS}\n"; pkg install php -y 2>&1 | tail -3; echo -e "\n${G}  ✓ PHP installed${RS}"; sleep 2 ;;
            7|07) clear; echo -e "\n${C}  Installing Git + SSH...${RS}\n"; pkg install git openssh -y 2>&1 | tail -3; echo -e "\n${G}  ✓ Git + SSH installed${RS}"; sleep 2 ;;
            8|08) clear; echo -e "\n${C}  Installing Neovim...${RS}\n"; pkg install neovim -y 2>&1 | tail -3; echo -e "\n${G}  ✓ Neovim installed${RS}"; sleep 2 ;;
            9|09) clear; echo -e "\n${C}  Installing tmux...${RS}\n"; pkg install tmux -y 2>&1 | tail -3; echo -e "\n${G}  ✓ tmux installed${RS}"; sleep 2 ;;
            10) clear; echo -e "\n${C}  Installing Python stack...${RS}\n"; pkg install python python-pip -y 2>&1 | tail -3; pip install numpy pandas flask requests ipython virtualenv 2>&1 | tail -3; echo -e "\n${G}  ✓ Python stack installed${RS}"; sleep 2 ;;
            11) clear; echo -e "\n${C}  Installing Web stack...${RS}\n"; pkg install nodejs php ruby python -y 2>&1 | tail -3; npm install -g yarn 2>&1 | tail -2; gem install bundler 2>&1 | tail -2; echo -e "\n${G}  ✓ Web stack installed${RS}"; sleep 2 ;;
            0|00) return ;;
        esac
    done
}

# ═══════════════════════════════════════════════════════════
# ENTRY POINT
# ═══════════════════════════════════════════════════════════
if [ ! -f "$QUINX_MARKER" ] && [ "$1" != "--skip-wizard" ]; then
    do_first_run_wizard
fi
check_for_updates
main_menu
