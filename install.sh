#!/bin/bash
# ╔══════════════════════════════════════════════════════════╗
# ║                    QuinxOS v4.1                          ║
# ║         Termux Optimization & Customization Suite        ║
# ║                    by Shineii86                          ║
# ╚══════════════════════════════════════════════════════════╝

# ─── Color Palette ─────────────────────────────────────────
R='\033[1;31m'; G='\033[1;32m'; Y='\033[1;93m'; B='\033[1;94m'
C='\033[1;96m'; W='\033[1;97m'; M='\033[1;95m'; D='\033[2m'
RS='\033[0m'; BL='\033[5m'; UL='\033[4m'

# ─── Paths ─────────────────────────────────────────────────
QUINX_HOME="$HOME/QuinxOS"
QUINX_VERSION="4.1"
QUINX_MARKER="$HOME/.quinx-installed"
QUINX_THEMES="$QUINX_HOME/.object/themes"

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
    local desc_color="${D}"
    printf "${C}${left_pad}║${RS}${full}"
    local remaining=$(( BOX_WIDTH - 2 - ${#full} - ${#desc} - 2 ))
    printf '%*s' $remaining ""
    printf "${desc_color}%s${RS}  ${C}║${RS}\n" "$desc"
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
        1) banner_style_1 ;;
        2) banner_style_2 ;;
        3) banner_style_3 ;;
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
    local zsh_status="${R}✗${RS}"
    [ -d "$HOME/.oh-my-zsh" ] && zsh_status="${G}✓${RS}"
    local lock_status="${R}✗${RS}"
    grep -q "#QUINX_LOCK_START" ~/.bashrc 2>/dev/null && lock_status="${G}✓${RS}"
    grep -q "#QUINX_LOCK_START" ~/.zshrc 2>/dev/null && lock_status="${G}✓${RS}"
    local theme_name="Cyber Midnight"
    [ -f "$QUINX_HOME/.current-theme" ] && theme_name=$(cat "$QUINX_HOME/.current-theme")

    draw_top
    print_line ""
    print_line "SYSTEM STATUS" "$Y"
    draw_sep
    printf "${C}${left_pad}║${RS}  Shell: ${W}%-10s${RS} Zsh: ${W}%-4b${RS} Lock: ${W}%-4b${RS} Theme: ${W}%-14s${RS}" "$shell_now" "$zsh_status" "$lock_status" "$theme_name"
    local total_len=$(( 10 + 8 + 8 + 8 + 14 ))
    local remaining=$(( BOX_WIDTH - 2 - total_len ))
    printf '%*s' $remaining ""
    printf "${C}║${RS}\n"
    print_line ""
}

# ─── Auto-Update Check ─────────────────────────────────────
check_for_updates() {
    local last_check="$QUINX_HOME/.last-update-check"
    local now=$(date +%s)
    # Only check once per day
    if [ -f "$last_check" ]; then
        local last=$(cat "$last_check")
        local diff=$(( now - last ))
        [ $diff -lt 86400 ] && return
    fi
    echo "$now" > "$last_check"

    # Compare local version with remote
    local remote_ver=$(curl -s "https://raw.githubusercontent.com/Shineii86/QuinxOS/main/install.sh" 2>/dev/null | grep -m1 'QUINX_VERSION=' | cut -d'"' -f2)
    if [ -n "$remote_ver" ] && [ "$remote_ver" != "$QUINX_VERSION" ]; then
        echo ""
        draw_top
        print_line ""
        print_line "UPDATE AVAILABLE" "$Y"
        print_line "Current: v${QUINX_VERSION} → Latest: v${remote_ver}" "$W"
        print_line "Run option [14] to update" "$D"
        print_line ""
        draw_bot
        sleep 2
    fi
}

# ═══════════════════════════════════════════════════════════
# FEATURE 1: THEME PRESETS
# ═══════════════════════════════════════════════════════════
do_theme_presets() {
    clear; show_banner
    draw_top
    print_line "THEME PRESETS" "$Y"
    draw_sep
    print_line "Select a color scheme" "$D"
    draw_sep
    print_item "1" "Cyber Midnight " "Deep space + neon" "$C"
    print_item "2" "Matrix Green   " "Classic hacker" "$G"
    print_item "3" "Solar Flare    " "Warm dark + orange" "$Y"
    print_item "4" "Arctic Blue    " "Cool blue / ice" "$B"
    print_item "5" "Purple Haze    " "Purple + magenta" "$M"
    print_item "6" "Dracacula      " "Dracula-inspired" "$M"
    print_item "7" "Nord           " "Arctic north-blue" "$B"
    draw_sep
    print_item "0" "Back           " "Return to menu" "$R"
    draw_bot
    echo ""
    echo -ne "${left_pad}${C}  Theme ❯ ${RS}"
    read -r theme_choice

    local theme_file=""
    local theme_name=""
    case $theme_choice in
        1) theme_file="cyber-midnight.colors"; theme_name="Cyber Midnight" ;;
        2) theme_file="matrix-green.colors"; theme_name="Matrix Green" ;;
        3) theme_file="solar-flare.colors"; theme_name="Solar Flare" ;;
        4) theme_file="arctic-blue.colors"; theme_name="Arctic Blue" ;;
        5) theme_file="purple-haze.colors"; theme_name="Purple Haze" ;;
        6) theme_file="dracacula.colors"; theme_name="Dracacula" ;;
        7) theme_file="nord.colors"; theme_name="Nord" ;;
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
# FEATURE 2: DEV TOOLS INSTALLER
# ═══════════════════════════════════════════════════════════
do_dev_tools() {
    while true; do
        clear; show_banner
        draw_top
        print_line "DEV TOOLS INSTALLER" "$Y"
        draw_sep
        print_line "Quick-install popular dev tools" "$D"
        draw_sep
        print_item "01" "Python 3     " "pip, venv, ipython" "$G"
        print_item "02" "Node.js      " "npm, yarn" "$G"
        print_item "03" "Go           " "Go compiler + tools" "$G"
        print_item "04" "Rust         " "cargo, rustc" "$G"
        print_item "05" "Ruby         " "gem, bundler" "$G"
        print_item "06" "PHP          " "php, composer" "$G"
        print_item "07" "Git + GitHub  " "git, gh cli, ssh" "$B"
        print_item "08" "Neovim       " "Modern vim editor" "$B"
        print_item "09" "tmux         " "Terminal multiplexer" "$B"
        print_item "10" "All Python   " "python + numpy, pandas, flask" "$Y"
        print_item "11" "All Web      " "node + npm + php + ruby" "$Y"
        draw_sep
        print_item "0"  "Back         " "Return to menu" "$R"
        draw_bot
        echo ""
        echo -ne "${left_pad}${C}  Select ❯ ${RS}"
        read -r dev_choice

        case $dev_choice in
            1|01)
                clear; echo -e "\n${C}  Installing Python 3...${RS}\n"
                pkg install python python-pip -y 2>&1 | tail -3
                pip install ipython virtualenv 2>&1 | tail -2
                echo -e "\n${G}  ✓ Python 3 installed${RS}"; sleep 2 ;;
            2|02)
                clear; echo -e "\n${C}  Installing Node.js...${RS}\n"
                pkg install nodejs -y 2>&1 | tail -3
                npm install -g yarn 2>&1 | tail -2
                echo -e "\n${G}  ✓ Node.js installed${RS}"; sleep 2 ;;
            3|03)
                clear; echo -e "\n${C}  Installing Go...${RS}\n"
                pkg install golang -y 2>&1 | tail -3
                echo -e "\n${G}  ✓ Go installed${RS}"; sleep 2 ;;
            4|04)
                clear; echo -e "\n${C}  Installing Rust...${RS}\n"
                pkg install rust -y 2>&1 | tail -3
                echo -e "\n${G}  ✓ Rust installed${RS}"; sleep 2 ;;
            5|05)
                clear; echo -e "\n${C}  Installing Ruby...${RS}\n"
                pkg install ruby -y 2>&1 | tail -3
                gem install bundler 2>&1 | tail -2
                echo -e "\n${G}  ✓ Ruby installed${RS}"; sleep 2 ;;
            6|06)
                clear; echo -e "\n${C}  Installing PHP...${RS}\n"
                pkg install php -y 2>&1 | tail -3
                echo -e "\n${G}  ✓ PHP installed${RS}"; sleep 2 ;;
            7|07)
                clear; echo -e "\n${C}  Installing Git + GitHub tools...${RS}\n"
                pkg install git openssh -y 2>&1 | tail -3
                echo -e "\n${G}  ✓ Git + SSH installed${RS}"; sleep 2 ;;
            8|08)
                clear; echo -e "\n${C}  Installing Neovim...${RS}\n"
                pkg install neovim -y 2>&1 | tail -3
                echo -e "\n${G}  ✓ Neovim installed${RS}"; sleep 2 ;;
            9|09)
                clear; echo -e "\n${C}  Installing tmux...${RS}\n"
                pkg install tmux -y 2>&1 | tail -3
                echo -e "\n${G}  ✓ tmux installed${RS}"; sleep 2 ;;
            10)
                clear; echo -e "\n${C}  Installing Python stack...${RS}\n"
                pkg install python python-pip -y 2>&1 | tail -3
                pip install numpy pandas flask requests ipython virtualenv 2>&1 | tail -3
                echo -e "\n${G}  ✓ Python stack installed${RS}"; sleep 2 ;;
            11)
                clear; echo -e "\n${C}  Installing Web stack...${RS}\n"
                pkg install nodejs php ruby python -y 2>&1 | tail -3
                npm install -g yarn 2>&1 | tail -2
                gem install bundler 2>&1 | tail -2
                echo -e "\n${G}  ✓ Web stack installed${RS}"; sleep 2 ;;
            0|00) return ;;
            *) continue ;;
        esac
    done
}

# ═══════════════════════════════════════════════════════════
# FEATURE 3: NETWORK INFO
# ═══════════════════════════════════════════════════════════
do_network_info() {
    clear; show_banner
    draw_top
    print_line "NETWORK INFORMATION" "$Y"
    draw_sep

    local local_ip=$(ip route get 1.1.1.1 2>/dev/null | grep -oP 'src \K\S+')
    local public_ip=$(curl -s --max-time 5 ifconfig.me 2>/dev/null || echo "N/A")
    local dns=$(grep -m1 'nameserver' /etc/resolv.conf 2>/dev/null | awk '{print $2}' || echo "N/A")
    local hostname=$(hostname 2>/dev/null || echo "N/A")
    local wifi=$(dumpsys wifi 2>/dev/null | grep -m1 'mWifiInfo' | grep -oP 'SSID: \K[^,]+' || echo "N/A")

    printf "${C}${left_pad}║${RS}  ${W}Hostname:${RS}   ${G}%-30s${RS}" "$hostname"
    printf '%*s' $(( BOX_WIDTH - 2 - 35 )) "" "${C}║${RS}\n"
    printf "${C}${left_pad}║${RS}  ${W}Local IP:${RS}   ${G}%-30s${RS}" "${local_ip:-N/A}"
    printf '%*s' $(( BOX_WIDTH - 2 - 35 )) "" "${C}║${RS}\n"
    printf "${C}${left_pad}║${RS}  ${W}Public IP:${RS}  ${G}%-30s${RS}" "$public_ip"
    printf '%*s' $(( BOX_WIDTH - 2 - 35 )) "" "${C}║${RS}\n"
    printf "${C}${left_pad}║${RS}  ${W}DNS:${RS}       ${G}%-30s${RS}" "$dns"
    printf '%*s' $(( BOX_WIDTH - 2 - 35 )) "" "${C}║${RS}\n"

    draw_sep
    print_line "CONNECTIVITY TEST" "$Y"
    draw_sep

    local ping_result=$(ping -c1 -W3 8.8.8.8 2>/dev/null | grep -oP 'time=\K\S+')
    if [ -n "$ping_result" ]; then
        printf "${C}${left_pad}║${RS}  ${W}Google DNS:${RS}  ${G}✓ ${ping_result}${RS}"
        local p=${#ping_result}
        printf '%*s' $(( BOX_WIDTH - 2 - 20 - p )) "" "${C}║${RS}\n"
    else
        printf "${C}${left_pad}║${RS}  ${W}Google DNS:${RS}  ${R}✗ Timeout${RS}"
        printf '%*s' $(( BOX_WIDTH - 2 - 24 )) "" "${C}║${RS}\n"
    fi

    local ping_cloud=$(ping -c1 -W3 1.1.1.1 2>/dev/null | grep -oP 'time=\K\S+')
    if [ -n "$ping_cloud" ]; then
        printf "${C}${left_pad}║${RS}  ${W}Cloudflare:${RS}  ${G}✓ ${ping_cloud}${RS}"
        local p=${#ping_cloud}
        printf '%*s' $(( BOX_WIDTH - 2 - 20 - p )) "" "${C}║${RS}\n"
    else
        printf "${C}${left_pad}║${RS}  ${W}Cloudflare:${RS}  ${R}✗ Timeout${RS}"
        printf '%*s' $(( BOX_WIDTH - 2 - 24 )) "" "${C}║${RS}\n"
    fi

    print_line ""
    draw_bot
    echo ""
    echo -ne "${left_pad}${C}  Press Enter to return...${RS}"
    read -r
}

# ═══════════════════════════════════════════════════════════
# FEATURE 4: FIRST-RUN WIZARD
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
    echo -e "${W}  This wizard will guide you through the initial setup.${RS}"
    echo ""

    # Step 1: Choose shell
    echo -e "${C}  ── Step 1/4: Choose Your Shell ──${RS}"
    echo -e "  ${W}[1]${G} Zsh (recommended — better themes & plugins)${RS}"
    echo -e "  ${W}[2]${G} Bash (classic — lightweight & fast)${RS}"
    echo ""
    echo -ne "${C}  Your choice [1-2]: ${RS}"
    read -r shell_choice
    case $shell_choice in
        2) echo -e "\n  ${G}Setting Bash as default...${RS}"; chsh -s bash ;;
        *) echo -e "\n  ${G}Setting Zsh as default...${RS}"
           pkg install zsh -y 2>&1 | tail -1
           chsh -s zsh ;;
    esac

    # Step 2: Choose theme
    echo ""
    echo -e "${C}  ── Step 2/4: Choose Your Theme ──${RS}"
    echo -e "  ${W}[1]${C} Cyber Midnight  ${D}(deep space + neon)${RS}"
    echo -e "  ${W}[2]${G} Matrix Green    ${D}(classic hacker)${RS}"
    echo -e "  ${W}[3]${Y} Solar Flare     ${D}(warm dark + orange)${RS}"
    echo -e "  ${W}[4]${B} Arctic Blue     ${D}(cool blue / ice)${RS}"
    echo -e "  ${W}[5]${M} Purple Haze     ${D}(purple + magenta)${RS}"
    echo -e "  ${W}[6]${M} Dracacula       ${D}(dracula-inspired)${RS}"
    echo -e "  ${W}[7]${B} Nord            ${D}(arctic north-blue)${RS}"
    echo ""
    echo -ne "${C}  Your choice [1-7]: ${RS}"
    read -r theme_choice
    local tname="" tfile=""
    case $theme_choice in
        1) tname="Cyber Midnight"; tfile="cyber-midnight.colors" ;;
        2) tname="Matrix Green"; tfile="matrix-green.colors" ;;
        3) tname="Solar Flare"; tfile="solar-flare.colors" ;;
        4) tname="Arctic Blue"; tfile="arctic-blue.colors" ;;
        5) tname="Purple Haze"; tfile="purple-haze.colors" ;;
        6) tname="Dracacula"; tfile="dracacula.colors" ;;
        7) tname="Nord"; tfile="nord.colors" ;;
        *) tname="Cyber Midnight"; tfile="cyber-midnight.colors" ;;
    esac
    [ -f "$QUINX_THEMES/$tfile" ] && cp "$QUINX_THEMES/$tfile" ~/.termux/colors.properties 2>/dev/null
    echo "$tname" > "$QUINX_HOME/.current-theme"
    echo -e "\n  ${G}Theme set to: $tname${RS}"

    # Step 3: Choose banner
    echo ""
    echo -e "${C}  ── Step 3/4: Choose Your Banner Style ──${RS}"
    echo -e "  ${W}[1]${C} Block Letters   ${D}(bold gradient)${RS}"
    echo -e "  ${W}[2]${M} Box Art         ${D}(framed pixel)${RS}"
    echo -e "  ${W}[3]${G} Clean Box       ${D}(minimal frame)${RS}"
    echo ""
    echo -ne "${C}  Your choice [1-3]: ${RS}"
    read -r banner_choice
    echo "$banner_choice" > "$QUINX_HOME/.banner-style"
    echo -e "\n  ${G}Banner style $banner_choice saved${RS}"

    # Step 4: Custom username
    echo ""
    echo -e "${C}  ── Step 4/4: Your Display Name ──${RS}"
    echo -e "  ${D}(shown in shell prompt & boot banner, max 12 chars)${RS}"
    echo ""
    echo -ne "${C}  Enter name: ${RS}"
    read -r display_name
    [ -z "$display_name" ] && display_name="${USER:-Quinx}"
    echo -e "\n  ${G}Display name set to: $display_name${RS}"

    # Install everything
    echo ""
    echo -e "${C}  ── Installing Components ──${RS}"
    echo -ne "  ${W}Dependencies: ${RS}"
    apt update -y 2>&1 | tail -1 && apt upgrade -y 2>&1 | tail -1
    pkg install zsh git figlet toilet ruby wget curl -y 2>&1 | tail -1
    gem install lolcat 2>&1 | tail -1
    echo -e "${G}✓${RS}"

    echo -ne "  ${W}Oh My Zsh:    ${RS}"
    git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh 2>&1 | tail -1
    echo -e "${G}✓${RS}"

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
    if [ -f "$QUINX_HOME/.object/zshrc-full" ]; then
        sed "s/\PROC/${display_name}/g" "$QUINX_HOME/.object/zshrc-full" > ~/.zshrc
    fi
    if [ -f "$QUINX_HOME/.object/quinx.zsh-theme" ]; then
        mkdir -p ~/.oh-my-zsh/themes
        sed "s/\PROC/${display_name}/g" "$QUINX_HOME/.object/quinx.zsh-theme" > ~/.oh-my-zsh/themes/quinx.zsh-theme 2>/dev/null
    fi
    termux-reload-settings 2>/dev/null
    echo -e "${G}✓${RS}"

    # Mark as installed
    echo "v${QUINX_VERSION}" > "$QUINX_MARKER"

    echo ""
    echo -e "${M}  ╔═══════════════════════════════════════════════════════════╗${RS}"
    echo -e "${M}  ║              ${G}✓ SETUP COMPLETE!${M}                          ║${RS}"
    echo -e "${M}  ║                                                         ║${RS}"
    echo -e "${M}  ║  ${W}Shell: ${G}$(basename "$SHELL")${M}                                       ║${RS}"
    echo -e "${M}  ║  ${W}Theme: ${G}${tname}${M}$(printf '%*s' $(( 29 - ${#tname} )) '')║${RS}"
    echo -e "${M}  ║  ${W}Name:  ${G}${display_name}${M}$(printf '%*s' $(( 29 - ${#display_name} )) '')║${RS}"
    echo -e "${M}  ║                                                         ║${RS}"
    echo -e "${M}  ║  ${W}Restart your terminal to see the changes!${M}               ║${RS}"
    echo -e "${M}  ╚═══════════════════════════════════════════════════════════╝${RS}"
    echo ""
    echo -ne "${C}  Press Enter to continue...${RS}"
    read -r
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
    gem install lolcat
    pkg install toilet figlet exa -y
    mkdir -p "$QUINX_HOME/.object"
    [ -f "$QUINX_HOME/.object/ANSI Shadow.flf" ] && cp -r "$QUINX_HOME/.object/ANSI Shadow.flf" "$PREFIX/share/figlet/ASCII-Shadow.flf" 2>/dev/null
    git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh 2>/dev/null
    rm -rf ~/.termux/colors.properties
    rm -rf /data/data/com.termux/files/usr/etc/motd
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
    draw_sep
    print_line "Resetting .zshrc and installing Oh My Zsh..." "$D"
    draw_bot
    rm -rf ~/.zshrc
    git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh 2>/dev/null
    cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
    clear; show_banner; draw_top
    print_line "ZSH SETUP COMPLETE ✓" "$G"
    draw_bot; sleep 2
}

do_set_zsh() {
    pkg install zsh -y; chsh -s zsh
    clear; show_banner; draw_top
    print_line "DEFAULT SHELL → ZSH ✓" "$G"
    draw_bot; sleep 2
}

do_set_bash() {
    chsh -s bash
    clear; show_banner; draw_top
    print_line "DEFAULT SHELL → BASH ✓" "$G"
    draw_bot; sleep 2
}

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
        1|2|3)
            echo "$style_choice" > "$QUINX_HOME/.banner-style"
            clear; show_banner; draw_top
            print_line "BANNER STYLE $style_choice SET ✓" "$G"
            draw_bot ;;
        0) return ;;
    esac
    sleep 2
}

do_set_theme() {
    clear; show_banner; draw_top
    print_line "SHELL THEME SETUP" "$Y"
    draw_sep
    print_line "Max 12 characters recommended" "$D"
    draw_bot; echo ""
    echo -ne "${left_pad}${C}  Enter Shell Name ❯ ${RS}"
    read -r shell_name
    if [ -f "$QUINX_HOME/.object/quinx.zsh-theme" ]; then
        mkdir -p ~/.oh-my-zsh/themes
        sed "s/\PROC/${shell_name}/g" "$QUINX_HOME/.object/quinx.zsh-theme" > ~/.oh-my-zsh/themes/quinx.zsh-theme 2>/dev/null
    fi
    clear; show_banner; draw_top
    print_line "THEME SET TO: ${shell_name}" "$G"
    draw_bot; sleep 2
}

do_plugins() {
    clear; show_banner; draw_top
    print_line "INSTALLING ZSH PLUGINS" "$Y"
    draw_sep
    print_line "Syntax Highlighting + Autosuggestions" "$D"
    draw_bot; echo ""
    git clone https://github.com/zsh-users/zsh-autosuggestions "$HOME/.oh-my-zsh/plugins/zsh-autosuggestions" 2>/dev/null
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME/.oh-my-zsh/plugins/zsh-syntax-highlighting" 2>/dev/null
    if [ -f "$QUINX_HOME/.object/zshrc-full" ]; then
        sed "s/\PROC/${USER:-Quinx}/g" "$QUINX_HOME/.object/zshrc-full" > ~/.zshrc
    fi
    if [ -f "$QUINX_HOME/.object/quinx.zsh-theme" ]; then
        mkdir -p ~/.oh-my-zsh/themes
        sed "s/\PROC/${USER:-Quinx}/g" "$QUINX_HOME/.object/quinx.zsh-theme" > ~/.oh-my-zsh/themes/quinx.zsh-theme 2>/dev/null
    fi
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
    local arch=$(uname -m 2>/dev/null)
    local kernel=$(uname -r 2>/dev/null)
    local os_name=$(uname -o 2>/dev/null)
    local uptime_info=$(uptime -p 2>/dev/null || echo "N/A")
    local disk=$(df -h / 2>/dev/null | tail -1 | awk '{print $3"/"$2" ("$5" used)"}')
    local mem=$(free -h 2>/dev/null | awk '/Mem:/{print $3"/"$2}')
    local cpu=$(nproc 2>/dev/null || echo "?")
    local pkgs=$(dpkg -l 2>/dev/null | grep -c '^ii' || echo "?")

    printf "${C}${left_pad}║${RS}  ${W}OS:${RS}       ${G}%-30s${RS}" "$os_name"
    printf '%*s' $(( BOX_WIDTH - 2 - 35 )) "" "${C}║${RS}\n"
    printf "${C}${left_pad}║${RS}  ${W}Arch:${RS}     ${G}%-30s${RS}" "$arch"
    printf '%*s' $(( BOX_WIDTH - 2 - 35 )) "" "${C}║${RS}\n"
    printf "${C}${left_pad}║${RS}  ${W}Kernel:${RS}   ${G}%-30s${RS}" "$kernel"
    printf '%*s' $(( BOX_WIDTH - 2 - 35 )) "" "${C}║${RS}\n"
    printf "${C}${left_pad}║${RS}  ${W}Uptime:${RS}   ${G}%-30s${RS}" "$uptime_info"
    printf '%*s' $(( BOX_WIDTH - 2 - 35 )) "" "${C}║${RS}\n"
    printf "${C}${left_pad}║${RS}  ${W}CPU:${RS}      ${G}%-30s${RS}" "${cpu} cores"
    printf '%*s' $(( BOX_WIDTH - 2 - 35 )) "" "${C}║${RS}\n"
    printf "${C}${left_pad}║${RS}  ${W}Memory:${RS}  ${G}%-30s${RS}" "$mem"
    printf '%*s' $(( BOX_WIDTH - 2 - 35 )) "" "${C}║${RS}\n"
    printf "${C}${left_pad}║${RS}  ${W}Disk:${RS}    ${G}%-30s${RS}" "$disk"
    printf '%*s' $(( BOX_WIDTH - 2 - 35 )) "" "${C}║${RS}\n"
    printf "${C}${left_pad}║${RS}  ${W}Packages:${RS} ${G}%-30s${RS}" "${pkgs} installed"
    printf '%*s' $(( BOX_WIDTH - 2 - 35 )) "" "${C}║${RS}\n"
    print_line ""
    draw_bot; echo ""
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
            [ -f ~/.zshrc ] && cp ~/.zshrc "$backup_dir/"
            [ -f ~/.bashrc ] && cp ~/.bashrc "$backup_dir/"
            [ -d ~/.termux ] && cp -r ~/.termux "$backup_dir/"
            [ -d ~/.oh-my-zsh/themes ] && cp -r ~/.oh-my-zsh/themes "$backup_dir/themes" 2>/dev/null
            [ -f "$QUINX_HOME/.current-theme" ] && cp "$QUINX_HOME/.current-theme" "$backup_dir/"
            [ -f "$QUINX_HOME/.banner-style" ] && cp "$QUINX_HOME/.banner-style" "$backup_dir/"
            clear; show_banner; draw_top
            print_line "BACKUP SAVED ✓" "$G"
            print_line "$backup_dir" "$D"
            draw_bot; sleep 2 ;;
        2)
            if [ -d "$QUINX_HOME/backups" ]; then
                local latest=$(ls -t "$QUINX_HOME/backups/" 2>/dev/null | head -1)
                if [ -n "$latest" ]; then
                    local bdir="$QUINX_HOME/backups/$latest"
                    [ -f "$bdir/.zshrc" ] && cp "$bdir/.zshrc" ~/.zshrc
                    [ -f "$bdir/.bashrc" ] && cp "$bdir/.bashrc" ~/.bashrc
                    [ -d "$bdir/.termux" ] && cp -r "$bdir/.termux/"* ~/.termux/ 2>/dev/null
                    [ -f "$bdir/.current-theme" ] && cp "$bdir/.current-theme" "$QUINX_HOME/"
                    [ -f "$bdir/.banner-style" ] && cp "$bdir/.banner-style" "$QUINX_HOME/"
                    clear; show_banner; draw_top
                    print_line "RESTORED FROM: $latest" "$G"
                    draw_bot
                else
                    echo -e "\n${left_pad}${R}  No backups found.${RS}"
                fi
            else
                echo -e "\n${left_pad}${R}  No backups directory.${RS}"
            fi
            sleep 2 ;;
    esac
}

# ─── Quinx Shield (Security) ──────────────────────────────
generate_recovery_key() {
    cat /dev/urandom 2>/dev/null | tr -dc 'A-Za-z0-9' | head -c 16
}

do_cyber_lock() {
    clear; show_banner; draw_top
    print_line "QUINX SHIELD — SECURITY LOCK" "$Y"
    draw_sep
    print_line "Protect your terminal with encrypted access" "$D"
    draw_bot; echo ""
    echo -ne "${left_pad}${C}  Create Access Key ❯ ${RS}"
    read -s new_pass; echo
    echo -ne "${left_pad}${C}  Confirm Access Key ❯ ${RS}"
    read -s confirm_pass; echo

    if [ "$new_pass" != "$confirm_pass" ]; then
        echo -e "\n${left_pad}${R}  ✗ Keys do not match. Aborting.${RS}"
        sleep 2; return
    fi

    local recovery_key=$(generate_recovery_key)
    local recovery_file="$QUINX_HOME/.quinx-recovery"
    echo "$recovery_key" > "$recovery_file"
    chmod 600 "$recovery_file"

    local unlock_script="$QUINX_HOME/quinx-unlock"
    cat > "$unlock_script" << 'UNLOCK_EOF'
#!/bin/bash
R='\033[1;31m'; G='\033[1;32m'; C='\033[1;96m'; W='\033[1;97m'; RS='\033[0m'
echo -e "\n${C}  QUINX SHIELD — EMERGENCY UNLOCK${RS}"
echo -e "${C}  ─────────────────────────────────${RS}\n"
echo -ne "  Enter recovery key or access key: "
read -s input_key; echo
QUINX_HOME="$HOME/QuinxOS"
recovery_file="$QUINX_HOME/.quinx-recovery"
if [ -f "$recovery_file" ]; then
    stored_key=$(cat "$recovery_file")
    if [ "$input_key" = "$stored_key" ]; then
        sed -i '/#QUINX_LOCK_START/,/#QUINX_LOCK_END/d' ~/.bashrc 2>/dev/null
        [ -f ~/.zshrc ] && sed -i '/#QUINX_LOCK_START/,/#QUINX_LOCK_END/d' ~/.zshrc 2>/dev/null
        echo -e "\n  ${G}✓ QUINX SHIELD REMOVED SUCCESSFULLY${RS}"
        rm -f "$recovery_file"
        echo -e "  ${W}Recovery key consumed and deleted.${RS}\n"
        exit 0
    fi
fi
if grep -q "#QUINX_LOCK_START" ~/.bashrc 2>/dev/null || grep -q "#QUINX_LOCK_START" ~/.zshrc 2>/dev/null; then
    stored_pass=$(grep -oP 'pass_input" = "\K[^"]+' ~/.bashrc 2>/dev/null || grep -oP 'pass_input" = "\K[^"]+' ~/.zshrc 2>/dev/null)
    if [ "$input_key" = "$stored_pass" ]; then
        sed -i '/#QUINX_LOCK_START/,/#QUINX_LOCK_END/d' ~/.bashrc 2>/dev/null
        [ -f ~/.zshrc ] && sed -i '/#QUINX_LOCK_START/,/#QUINX_LOCK_END/d' ~/.zshrc 2>/dev/null
        echo -e "\n  ${G}✓ QUINX SHIELD REMOVED SUCCESSFULLY${RS}\n"
        exit 0
    fi
fi
echo -e "\n  ${R}✗ INVALID KEY. UNLOCK FAILED.${RS}\n"
exit 1
UNLOCK_EOF
    chmod +x "$unlock_script"

    local lock_code='#QUINX_LOCK_START
clear
echo -e "\033[1;36m"
echo "  ┌─────────────────────────────────────┐"
echo "  │     QUINX SHIELD — ACCESS GATE      │"
echo "  └─────────────────────────────────────┘"
echo -e "\033[0m"
echo -e "\033[1;33m  Initializing security protocols...\033[0m"
sleep 0.5
attempt=1
while [ $attempt -le 3 ]; do
    echo -e "\n\033[1;36m  ╔══════════════════════════════════════╗"
    echo -e "  ║        \033[1;31mQUINX SHIELD ACCESS           \033[1;36m║"
    echo -e "  ╚══════════════════════════════════════╝\033[0m"
    echo -ne "\033[1;33m  [Attempt $attempt/3] Enter Key: \033[0m"
    read -s pass_input
    echo
    if [ "$pass_input" = "'"$new_pass"'" ]; then
        echo -e "\033[1;32m  ✓ ACCESS GRANTED. Welcome back.\033[0m"
        sleep 1; clear; break
    else
        echo -e "\033[1;31m  ✗ ACCESS DENIED.\033[0m"
        if [ $attempt -eq 3 ]; then
            echo -e "\033[1;31m"
            echo "  ╔══════════════════════════════════════╗"
            echo "  ║   LOCKED OUT — RECOVERY OPTIONS      ║"
            echo "  ╠══════════════════════════════════════╣"
            echo "  ║                                      ║"
            echo "  ║  Option 1: Run from another terminal ║"
            echo "  ║    bash ~/QuinxOS/quinx-unlock       ║"
            echo "  ║                                      ║"
            echo "  ║  Option 2: Use your recovery key     ║"
            echo "  ║    (saved during lock setup)          ║"
            echo "  ║                                      ║"
            echo "  ║  Option 3: Remove lock file directly ║"
            echo "  ║    nano ~/.bashrc (delete lock block) ║"
            echo "  ║                                      ║"
            echo "  ╚══════════════════════════════════════╝"
            echo -e "\033[0m"
            echo -ne "\033[1;33m  Enter recovery key (or Enter to exit): \033[0m"
            read -s recovery_input
            echo
            if [ -n "$recovery_input" ] && [ -f "'"$QUINX_HOME"'/.quinx-recovery" ]; then
                stored_recovery=$(cat "'"$QUINX_HOME"'/.quinx-recovery")
                if [ "$recovery_input" = "$stored_recovery" ]; then
                    sed -i "/#QUINX_LOCK_START/,/#QUINX_LOCK_END/d" ~/.bashrc 2>/dev/null
                    [ -f ~/.zshrc ] && sed -i "/#QUINX_LOCK_START/,/#QUINX_LOCK_END/d" ~/.zshrc 2>/dev/null
                    echo -e "\033[1;32m  ✓ RECOVERY SUCCESSFUL. Lock removed.\033[0m"
                    rm -f "'"$QUINX_HOME"'/.quinx-recovery"
                    sleep 2; clear; break
                fi
            fi
            echo -e "\033[1;31m  ✗ SESSION TERMINATED.\033[0m"
            exit
        fi
        attempt=$((attempt + 1))
    fi
done
#QUINX_LOCK_END'

    add_to_top() {
        local file=$1
        if [ -f "$file" ]; then
            echo "$lock_code" > "$file.tmp"
            cat "$file" >> "$file.tmp"
            mv "$file.tmp" "$file"
        else
            echo "$lock_code" > "$file"
        fi
    }
    add_to_top ~/.bashrc
    [ -f ~/.zshrc ] && add_to_top ~/.zshrc

    clear; show_banner; draw_top
    print_line ""
    print_line "QUINX SHIELD ACTIVATED ✓" "$G"
    print_line "3-attempt lockout enabled" "$Y"
    draw_sep
    print_line "" "$W"
    print_line "⚠ SAVE YOUR RECOVERY KEY NOW ⚠" "$R"
    print_line "" "$W"
    print_line "Key: $recovery_key" "$G"
    print_line "" "$W"
    print_line "File: $recovery_file" "$D"
    print_line "Unlock: bash ~/QuinxOS/quinx-unlock" "$D"
    print_line ""
    draw_bot; echo ""
    echo -ne "${left_pad}${C}  Press Enter after saving your key...${RS}"
    read -r
}

do_remove_lock() {
    sed -i '/#QUINX_LOCK_START/,/#QUINX_LOCK_END/d' ~/.bashrc 2>/dev/null
    [ -f ~/.zshrc ] && sed -i '/#QUINX_LOCK_START/,/#QUINX_LOCK_END/d' ~/.zshrc 2>/dev/null
    rm -f "$QUINX_HOME/.quinx-recovery" 2>/dev/null
    rm -f "$QUINX_HOME/quinx-unlock" 2>/dev/null
    clear; show_banner; draw_top
    print_line ""
    print_line "QUINX SHIELD DEACTIVATED" "$R"
    print_line "Recovery artifacts cleaned" "$D"
    print_line ""
    draw_bot; sleep 2
}

# ─── Motd Editor ──────────────────────────────────────────
do_motd_editor() {
    clear; show_banner; draw_top
    print_line "MOTD EDITOR" "$Y"
    draw_sep
    print_line "Custom Message of the Day" "$D"
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
        1)
            echo ""
            echo -ne "${left_pad}${C}  Enter MOTD text: ${RS}"
            read -r motd_text
            echo -e "\033[1;96m${motd_text}\033[0m" > "$motd_file"
            clear; show_banner; draw_top
            print_line "CUSTOM MOTD SET ✓" "$G"
            draw_bot; sleep 2 ;;
        2)
            cat > "$motd_file" << 'MOTD_EOF'
\033[1;96m
  ╔═══════════════════════════════════════╗
  ║        Welcome to QuinxOS v4.1        ║
  ║       by Shineii86                    ║
  ╚═══════════════════════════════════════╝
\033[0m
MOTD_EOF
            clear; show_banner; draw_top
            print_line "DEFAULT MOTD SET ✓" "$G"
            draw_bot; sleep 2 ;;
        3)
            rm -f "$motd_file"
            clear; show_banner; draw_top
            print_line "MOTD DISABLED ✓" "$G"
            draw_bot; sleep 2 ;;
        0) return ;;
    esac
}

# ─── Update ────────────────────────────────────────────────
do_update() {
    clear; show_banner; draw_top
    print_line "UPDATING QUINXOS" "$Y"
    draw_sep
    print_line "Pulling latest from GitHub..." "$D"
    draw_bot; echo ""
    rm -rf "$QUINX_HOME"
    cd "$HOME"
    git clone https://github.com/Shineii86/QuinxOS.git 2>/dev/null
    cd "$QUINX_HOME"
    clear; show_banner; draw_top
    print_line "UPDATE COMPLETE ✓" "$G"
    draw_bot; sleep 2
}

# ─── Uninstaller ──────────────────────────────────────────
do_uninstall() {
    clear; show_banner; draw_top
    print_line "UNINSTALL QUINXOS" "$R"
    draw_sep
    print_line "This will remove all QuinxOS components" "$D"
    draw_sep
    print_line "" "$W"
    print_line "Removes:" "$W"
    print_line "• QuinxOS directory" "$D"
    print_line "• Quinx Shell theme" "$D"
    print_line "• Quinx Shield lock" "$D"
    print_line "• Recovery artifacts" "$D"
    print_line "• Custom MOTD" "$D"
    print_line "" "$W"
    print_line "Keeps:" "$W"
    print_line "• Oh My Zsh (if installed)" "$D"
    print_line "• Your .zshrc / .bashrc" "$D"
    print_line "• Termux font & colors" "$D"
    print_line ""
    draw_sep
    print_item "1" "Confirm Uninstall" "Remove QuinxOS" "$R"
    print_item "0" "Cancel           " "Keep everything" "$G"
    draw_bot; echo ""
    echo -ne "${left_pad}${C}  Are you sure? ❯ ${RS}"
    read -r confirm
    case $confirm in
        1)
            # Remove Quinx Shield if active
            sed -i '/#QUINX_LOCK_START/,/#QUINX_LOCK_END/d' ~/.bashrc 2>/dev/null
            [ -f ~/.zshrc ] && sed -i '/#QUINX_LOCK_START/,/#QUINX_LOCK_END/d' ~/.zshrc 2>/dev/null
            # Remove theme
            rm -f ~/.oh-my-zsh/themes/quinx.zsh-theme 2>/dev/null
            # Remove MOTD
            rm -f /data/data/com.termux/files/usr/etc/motd 2>/dev/null
            # Remove QuinxOS directory
            rm -rf "$QUINX_HOME"
            # Remove marker
            rm -f "$QUINX_MARKER"
            clear; show_banner; draw_top
            print_line ""
            print_line "QUINXOS UNINSTALLED ✓" "$R"
            print_line "Thank you for using QuinxOS!" "$W"
            print_line ""
            draw_bot; echo ""
            echo -ne "${left_pad}${C}  Press Enter...${RS}"
            read -r
            exit 0 ;;
        *) return ;;
    esac
}

# ═══════════════════════════════════════════════════════════
# MAIN MENU
# ═══════════════════════════════════════════════════════════
main_menu() {
    while true; do
        show_banner
        show_status
        echo ""
        draw_top
        print_line "MAIN MENU" "$Y"
        draw_sep
        print_item "01" "Core Setup       " "Install deps & fonts" "$G"
        print_item "02" "Zsh Config       " "Reset zsh environment" "$G"
        print_item "03" "Switch → Zsh     " "Set Zsh as default" "$G"
        print_item "04" "Switch → Bash    " "Set Bash as default" "$G"
        print_item "05" "Banner Style     " "Choose banner design" "$Y"
        print_item "06" "Custom Theme     " "Set shell prompt name" "$Y"
        print_item "07" "Zsh Plugins      " "Highlight + Autosuggest" "$Y"
        print_item "08" "Theme Presets    " "7 color schemes" "$C"
        print_item "09" "Dev Tools        " "Install Python, Node, Go..." "$C"
        print_item "10" "System Info      " "View system details" "$B"
        print_item "11" "Network Info     " "IP, DNS, connectivity" "$B"
        print_item "12" "MOTD Editor      " "Custom boot message" "$B"
        print_item "13" "Backup/Restore   " "Save or load configs" "$B"
        print_item "14" "Quinx Shield     " "Terminal lock (Security)" "$M"
        print_item "15" "Remove Lock      " "Deactivate Quinx Shield" "$R"
        print_item "16" "Update QuinxOS   " "Pull latest version" "$G"
        print_item "17" "Uninstall        " "Remove QuinxOS completely" "$R"
        draw_sep
        print_item "00" "Exit             " "Close terminal" "$R"
        draw_bot
        echo ""
        echo -ne "${left_pad}${C}  ┌─ Selection ❯ ${RS}"
        read -r opt
        echo ""

        case $opt in
            1|01)  do_necessary_setup ;;
            2|02)  do_zsh_setup ;;
            3|03)  do_set_zsh ;;
            4|04)  do_set_bash ;;
            5|05)  do_set_banner ;;
            6|06)  do_set_theme ;;
            7|07)  do_plugins ;;
            8|08)  do_theme_presets ;;
            9|09)  do_dev_tools ;;
            10)    do_sysinfo ;;
            11)    do_network_info ;;
            12)    do_motd_editor ;;
            13)    do_backup ;;
            14)    do_cyber_lock ;;
            15)    do_remove_lock ;;
            16)    do_update ;;
            17)    do_uninstall ;;
            0|00)  clear; echo -e "${C}  QuinxOS ${W}— Session ended. See you next time.${RS}\n"; exit 0 ;;
            *)     continue ;;
        esac
    done
}

# ═══════════════════════════════════════════════════════════
# ENTRY POINT
# ═══════════════════════════════════════════════════════════
# First-run detection: launch wizard if never installed
if [ ! -f "$QUINX_MARKER" ] && [ "$1" != "--skip-wizard" ]; then
    do_first_run_wizard
fi

# Check for updates (non-blocking, once per day)
check_for_updates

# Launch main menu
main_menu
