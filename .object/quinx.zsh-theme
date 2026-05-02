autoload -U colors && colors
setopt prompt_subst

function parse_git_status() {
    git rev-parse --is-inside-work-tree &>/dev/null || return
    local branch
    branch=$(git symbolic-ref --short HEAD 2>/dev/null)
    if [[ -n $(git status --porcelain 2>/dev/null) ]]; then
        echo " %{$fg_bold[red]%}[%{$fg[yellow]%}${branch}%{$fg_bold[red]%}]%{$reset_color%}"
    else
        echo " %{$fg_bold[green]%}[%{$fg[cyan]%}${branch}%{$fg_bold[green]%}]%{$reset_color%}"
    fi
}

function check_lock_status() {
    if grep -q "#QUINX_LOCK_START" ~/.zshrc 2>/dev/null || grep -q "#QUINX_LOCK_START" ~/.bashrc 2>/dev/null; then
        echo " %{$fg_bold[green]%}🔒%{$reset_color%}"
    fi
}

local user_info="%{$fg_bold[cyan]%}[%{$fg_bold[white]%}PROC%{$fg_bold[cyan]%}@%{$fg_bold[magenta]%}quinx%{$fg_bold[cyan]%}]"
local current_dir="%{$fg_bold[cyan]%}[%{$fg_bold[green]%}%(5~|%-1~/…/%2~|%4~)%{$fg_bold[cyan]%}]"
local git_info='$(parse_git_status)'
local lock_info='$(check_lock_status)'
local status_arrow="%(?.%{$fg_bold[cyan]%}❯%{$fg_bold[white]%}❯%{$fg_bold[magenta]%}❯.%{$fg_bold[red]%}❯❯❯)"
local timestamp="%{$fg_bold[black]%}[%{$fg[blue]%}%D{%H:%M}%{$fg_bold[black]%}]%{$reset_color%}"

PROMPT="
%{$fg_bold[cyan]%}┌──${user_info}─${current_dir}${git_info}${lock_info} ${timestamp}
%{$fg_bold[cyan]%}└──╼ ${status_arrow} %{$reset_color%}"
