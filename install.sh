#!/bin/bash
# ╔══════════════════════════════════════════════════════════╗
# ║                    QuinxOS v4.0                          ║
# ║         Termux Optimization & Customization Suite        ║
# ║              by Shineii86                                ║
# ╚══════════════════════════════════════════════════════════╝

# ─── Color Palette ─────────────────────────────────────────
R='\033[1;31m'    # Red
G='\033[1;32m'    # Green
Y='\033[1;93m'    # Yellow
B='\033[1;94m'    # Blue
C='\033[1;96m'    # Cyan
W='\033[1;97m'    # White
M='\033[1;95m'    # Magenta
D='\033[2m'       # Dim
RS='\033[0m'      # Reset
BL='\033[5m'      # Blink
UL='\033[4m'      # Underline

# ─── Layout Engine ─────────────────────────────────────────
QUINX_HOME="$HOME/QuinxOS"
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

# ─── ASCII Art Banner ──────────────────────────────────────
show_banner() {
    clear
    echo ""
    echo -e "${C}    ██████╗ ██╗   ██╗██╗███╗   ██╗██╗  ██╗ ██████╗ ███████╗${RS}"
    echo -e "${C}   ██╔═══██╗██║   ██║██║████╗  ██║╚██╗██╔╝██╔═══██╗██╔════╝${RS}"
    echo -e "${C}   ██║   ██║██║   ██║██║██╔██╗ ██║ ╚███╔╝ ██║   ██║███████╗${RS}"
    echo -e "${C}   ██║▄▄ ██║██║   ██║██║██║╚██╗██║ ██╔██╗ ██║   ██║╚════██║${RS}"
    echo -e "${C}   ╚██████╔╝╚██████╔╝██║██║ ╚████║██╔╝ ██╗╚██████╔╝███████║${RS}"
    echo -e "${C}    ╚══▀▀═╝  ╚═════╝ ╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝${RS}"
    echo ""
    echo -e "${M}         ╔═══════════════════════════════════════╗${RS}"
    echo -e "${M}         ║  ${W}Termux Optimization Suite ${D}v4.0${M}       ║${RS}"
    echo -e "${M}         ╚═══════════════════════════════════════╝${RS}"
    echo ""
}

# ─── Status Bar ────────────────────────────────────────────
show_status() {
    local shell_now=$(basename "$SHELL" 2>/dev/null || echo "unknown")
    local zsh_status="${R}✗${RS}"
    [ -d "$HOME/.oh-my-zsh" ] && zsh_status="${G}✓${RS}"
    local lock_status="${R}✗${RS}"
    grep -q "#LOCK_START" ~/.bashrc 2>/dev/null && lock_status="${G}✓${RS}"
    grep -q "#LOCK_START" ~/.zshrc 2>/dev/null && lock_status="${G}✓${RS}"

    draw_top
    print_line ""
    print_line "SYSTEM STATUS" "$Y"
    draw_sep
    printf "${C}${left_pad}║${RS}  Shell: ${W}%-12s${RS}  Zsh: ${W}%-4b${RS}  Lock: ${W}%-4b${RS}" "$shell_now" "$zsh_status" "$lock_status"
    local used=$(( 28 + 8 + 8 ))
    local remaining=$(( BOX_WIDTH - 2 - used ))
    printf '%*s' $remaining ""
    printf "${C}║${RS}\n"
    print_line ""
}

# ─── Core Functions ────────────────────────────────────────
do_necessary_setup() {
    clear
    show_banner
    draw_top
    print_line "INSTALLING CORE DEPENDENCIES" "$Y"
    draw_sep
    print_line "Please wait..." "$D"
    draw_bot
    echo ""

    apt update -y && apt upgrade -y
    pkg install zsh git figlet toilet ruby wget curl -y
    gem install lolcat
    pkg install toilet figlet exa -y

    mkdir -p "$QUINX_HOME/.object"
    if [ -f "$QUINX_HOME/.object/ANSI Shadow.flf" ]; then
        cp -r "$QUINX_HOME/.object/ANSI Shadow.flf" "$PREFIX/share/figlet/ASCII-Shadow.flf" 2>/dev/null
    fi

    git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh 2>/dev/null

    rm -rf ~/.termux/colors.properties
    rm -rf /data/data/com.termux/files/usr/etc/motd
    [ -f "$QUINX_HOME/.object/colors.properties" ] && cp -r "$QUINX_HOME/.object/colors.properties" ~/.termux/colors.properties
    [ -f "$QUINX_HOME/.object/termux.properties" ] && cp -r "$QUINX_HOME/.object/termux.properties" ~/.termux.properties
    curl -L https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/FiraCode/Regular/FiraCodeNerdFont-Regular.ttf > ~/.termux/font.ttf 2>/dev/null
    termux-reload-settings 2>/dev/null

    clear
    show_banner
    draw_top
    print_line ""
    print_line "SETUP COMPLETE ✓" "$G"
    print_line ""
    draw_bot
    sleep 2
}

do_zsh_setup() {
    clear
    show_banner
    draw_top
    print_line "CONFIGURING ZSH ENVIRONMENT" "$Y"
    draw_sep
    print_line "Resetting .zshrc and installing Oh My Zsh..." "$D"
    draw_bot

    rm -rf ~/.zshrc
    git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh 2>/dev/null
    cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc

    clear
    show_banner
    draw_top
    print_line "ZSH SETUP COMPLETE ✓" "$G"
    draw_bot
    sleep 2
}

do_set_zsh() {
    pkg install zsh -y
    chsh -s zsh
    clear
    show_banner
    draw_top
    print_line "DEFAULT SHELL → ZSH ✓" "$G"
    draw_bot
    sleep 2
}

do_set_bash() {
    chsh -s bash
    clear
    show_banner
    draw_top
    print_line "DEFAULT SHELL → BASH ✓" "$G"
    draw_bot
    sleep 2
}

do_set_banner() {
    clear; show_banner
    draw_top
    print_line "CUSTOM BANNER SETUP" "$Y"
    draw_sep
    print_line "Max 12 characters recommended" "$D"
    draw_bot
    echo ""
    echo -ne "${left_pad}${C}  Enter Banner Name ❯ ${RS}"
    read -r banner_name
    if [ -f "$QUINX_HOME/.object/zshrc-base" ]; then
        sed "s/\PROC/${banner_name}/g" "$QUINX_HOME/.object/zshrc-base" > ~/.zshrc
    fi
    clear
    show_banner
    draw_top
    print_line "BANNER SET TO: ${banner_name}" "$G"
    draw_bot
    sleep 2
}

do_set_theme() {
    clear; show_banner
    draw_top
    print_line "SHELL THEME SETUP" "$Y"
    draw_sep
    print_line "Max 12 characters recommended" "$D"
    draw_bot
    echo ""
    echo -ne "${left_pad}${C}  Enter Shell Name ❯ ${RS}"
    read -r shell_name
    if [ -f "$QUINX_HOME/.object/quinx.zsh-theme" ]; then
        sed "s/\PROC/${shell_name}/g" "$QUINX_HOME/.object/quinx.zsh-theme" > ~/.oh-my-zsh/themes/quinx.zsh-theme 2>/dev/null
    fi
    clear
    show_banner
    draw_top
    print_line "THEME SET TO: ${shell_name}" "$G"
    draw_bot
    sleep 2
}

do_plugins() {
    clear; show_banner
    draw_top
    print_line "INSTALLING ZSH PLUGINS" "$Y"
    draw_sep
    print_line "Syntax Highlighting + Autosuggestions" "$D"
    draw_bot
    echo ""

    git clone https://github.com/zsh-users/zsh-autosuggestions "$HOME/.oh-my-zsh/plugins/zsh-autosuggestions" 2>/dev/null
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME/.oh-my-zsh/plugins/zsh-syntax-highlighting" 2>/dev/null

    if [ -f "$QUINX_HOME/.object/zshrc-full" ]; then
        sed "s/\PROC/${USER:-Quinx}/g" "$QUINX_HOME/.object/zshrc-full" > ~/.zshrc
    fi
    if [ -f "$QUINX_HOME/.object/quinx.zsh-theme" ]; then
        sed "s/\PROC/${USER:-Quinx}/g" "$QUINX_HOME/.object/quinx.zsh-theme" > ~/.oh-my-zsh/themes/quinx.zsh-theme 2>/dev/null
    fi

    clear
    show_banner
    draw_top
    print_line "PLUGINS INSTALLED ✓" "$G"
    print_line "Syntax Highlighting: ACTIVE" "$G"
    print_line "Autosuggestions: ACTIVE" "$G"
    draw_bot
    sleep 2
}

generate_recovery_key() {
    # Generate a 16-char alphanumeric recovery key
    cat /dev/urandom 2>/dev/null | tr -dc 'A-Za-z0-9' | head -c 16
}

do_cyber_lock() {
    clear; show_banner
    draw_top
    print_line "QUINX SHIELD — SECURITY LOCK" "$Y"
    draw_sep
    print_line "Protect your terminal with encrypted access" "$D"
    draw_bot
    echo ""
    echo -ne "${left_pad}${C}  Create Access Key ❯ ${RS}"
    read -s new_pass
    echo
    echo -ne "${left_pad}${C}  Confirm Access Key ❯ ${RS}"
    read -s confirm_pass
    echo

    if [ "$new_pass" != "$confirm_pass" ]; then
        echo -e "\n${left_pad}${R}  ✗ Keys do not match. Aborting.${RS}"
        sleep 2
        return
    fi

    # Generate recovery key
    local recovery_key=$(generate_recovery_key)
    local recovery_file="$QUINX_HOME/.quinx-recovery"
    echo "$recovery_key" > "$recovery_file"
    chmod 600 "$recovery_file"

    # Also create emergency unlock script
    local unlock_script="$QUINX_HOME/quinx-unlock"
    cat > "$unlock_script" << 'UNLOCK_EOF'
#!/bin/bash
# QuinxOS Emergency Unlock — run this to remove Quinx Shield
# Usage: bash quinx-unlock
R='\033[1;31m'; G='\033[1;32m'; C='\033[1;96m'; W='\033[1;97m'; RS='\033[0m'
echo -e "\n${C}  QUINX SHIELD — EMERGENCY UNLOCK${RS}"
echo -e "${C}  ─────────────────────────────────${RS}\n"
echo -ne "  Enter recovery key or access key: "
read -s input_key
echo

# Check against recovery file
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

# Also try as direct access key
if grep -q "#QUINX_LOCK_START" ~/.bashrc 2>/dev/null || grep -q "#QUINX_LOCK_START" ~/.zshrc 2>/dev/null; then
    # Extract the stored password from the lock code
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
        sleep 1
        clear
        break
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
                    sleep 2
                    clear
                    break
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

    clear
    show_banner
    draw_top
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
    draw_bot
    echo ""
    echo -ne "${left_pad}${C}  Press Enter after saving your key...${RS}"
    read -r
}

do_remove_lock() {
    sed -i '/#QUINX_LOCK_START/,/#QUINX_LOCK_END/d' ~/.bashrc 2>/dev/null
    [ -f ~/.zshrc ] && sed -i '/#QUINX_LOCK_START/,/#QUINX_LOCK_END/d' ~/.zshrc 2>/dev/null
    rm -f "$QUINX_HOME/.quinx-recovery" 2>/dev/null
    rm -f "$QUINX_HOME/quinx-unlock" 2>/dev/null
    clear
    show_banner
    draw_top
    print_line ""
    print_line "QUINX SHIELD DEACTIVATED" "$R"
    print_line "Recovery artifacts cleaned" "$D"
    print_line ""
    draw_bot
    sleep 2
}

do_sysinfo() {
    clear; show_banner
    draw_top
    print_line "SYSTEM INFORMATION" "$Y"
    draw_sep

    local arch=$(uname -m 2>/dev/null)
    local kernel=$(uname -r 2>/dev/null)
    local os_name=$(uname -o 2>/dev/null)
    local uptime_info=$(uptime -p 2>/dev/null || echo "N/A")
    local disk=$(df -h / 2>/dev/null | tail -1 | awk '{print $3"/"$2" ("$5" used)"}')
    local mem=$(free -h 2>/dev/null | awk '/Mem:/{print $3"/"$2}')
    local cpu=$(nproc 2>/dev/null || echo "?")

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

    print_line ""
    draw_bot
    echo ""
    echo -ne "${left_pad}${C}  Press Enter to return...${RS}"
    read -r
}

do_backup() {
    clear; show_banner
    draw_top
    print_line "BACKUP & RESTORE" "$Y"
    draw_sep
    print_line "  [1] Backup current config" "$W"
    print_line "  [2] Restore from backup" "$W"
    print_line "  [0] Back" "$R"
    draw_bot
    echo ""
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
            clear; show_banner; draw_top
            print_line "BACKUP SAVED ✓" "$G"
            print_line "$backup_dir" "$D"
            draw_bot
            sleep 2
            ;;
        2)
            if [ -d "$QUINX_HOME/backups" ]; then
                local latest=$(ls -t "$QUINX_HOME/backups/" 2>/dev/null | head -1)
                if [ -n "$latest" ]; then
                    local bdir="$QUINX_HOME/backups/$latest"
                    [ -f "$bdir/.zshrc" ] && cp "$bdir/.zshrc" ~/.zshrc
                    [ -f "$bdir/.bashrc" ] && cp "$bdir/.bashrc" ~/.bashrc
                    [ -d "$bdir/.termux" ] && cp -r "$bdir/.termux/"* ~/.termux/ 2>/dev/null
                    clear; show_banner; draw_top
                    print_line "RESTORED FROM: $latest" "$G"
                    draw_bot
                else
                    echo -e "\n${left_pad}${R}  No backups found.${RS}"
                fi
            else
                echo -e "\n${left_pad}${R}  No backups directory.${RS}"
            fi
            sleep 2
            ;;
    esac
}

do_update() {
    clear; show_banner
    draw_top
    print_line "UPDATING QUINXOS" "$Y"
    draw_sep
    print_line "Pulling latest from GitHub..." "$D"
    draw_bot
    echo ""

    rm -rf "$QUINX_HOME"
    cd "$HOME"
    git clone https://github.com/Shineii86/QuinxOS.git 2>/dev/null
    cd "$QUINX_HOME"

    clear; show_banner; draw_top
    print_line "UPDATE COMPLETE ✓" "$G"
    draw_bot
    sleep 2
}

# ─── Main Menu ─────────────────────────────────────────────
main_menu() {
    while true; do
        show_banner
        show_status
        echo ""
        draw_top
        print_line "MAIN MENU" "$Y"
        draw_sep
        print_item "01" "Core Setup      " "Install deps & fonts" "$G"
        print_item "02" "Zsh Config      " "Reset zsh environment" "$G"
        print_item "03" "Switch → Zsh    " "Set Zsh as default" "$G"
        print_item "04" "Switch → Bash   " "Set Bash as default" "$G"
        print_item "05" "Custom Banner   " "Set boot banner name" "$Y"
        print_item "06" "Custom Theme    " "Set shell prompt name" "$Y"
        print_item "07" "Zsh Plugins     " "Highlight + Autosuggest" "$Y"
        print_item "08" "System Info     " "View system details" "$B"
        print_item "09" "Backup/Restore  " "Save or load configs" "$B"
        print_item "10" "Quinx Shield    " "Terminal lock (Security)" "$M"
        print_item "11" "Remove Lock     " "Deactivate Quinx Shield" "$R"
        print_item "12" "Update QuinxOS  " "Pull latest version" "$C"
        draw_sep
        print_item "00" "Exit            " "Close terminal" "$R"
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
            8|08)  do_sysinfo ;;
            9|09)  do_backup ;;
            10)    do_cyber_lock ;;
            11)    do_remove_lock ;;
            12)    do_update ;;
            0|00)  clear; echo -e "${C}  QuinxOS ${W}— Session ended. See you next time.${RS}\n"; exit 0 ;;
            *)     continue ;;
        esac
    done
}

# ─── Launch ────────────────────────────────────────────────
main_menu
