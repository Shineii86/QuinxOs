#!/bin/bash
# QuinxOS Plugin: GitHub Integration
# Commands: quinx-ghstats, quinx-ghnotifs, quinx-ghstreak, quinx-ghrepo

quinx-ghstats() {
    local user="${1:-}"
    if [ -z "$user" ]; then
        echo -e "\033[1;36m  Usage: quinx-ghstats <username>\033[0m"
        return
    fi
    echo -e "\033[1;36m  ── GitHub Profile: $user ──\033[0m"
    local data=$(curl -s "https://api.github.com/users/$user" 2>/dev/null)
    if echo "$data" | grep -q '"message".*"Not Found"'; then
        echo -e "\033[1;31m  User not found: $user\033[0m"
        return
    fi
    local name=$(echo "$data" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('name','N/A'))" 2>/dev/null)
    local repos=$(echo "$data" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('public_repos',0))" 2>/dev/null)
    local followers=$(echo "$data" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('followers',0))" 2>/dev/null)
    local following=$(echo "$data" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('following',0))" 2>/dev/null)
    local bio=$(echo "$data" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('bio','') or 'N/A')" 2>/dev/null)
    local created=$(echo "$data" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('created_at','')[:10])" 2>/dev/null)
    echo ""
    echo -e "  \033[1;97m$name\033[0m"
    echo -e "  \033[2m$bio\033[0m"
    echo ""
    echo -e "  \033[1;32m📦 Repos:\033[0m      $repos"
    echo -e "  \033[1;32m👥 Followers:\033[0m   $followers"
    echo -e "  \033[1;32m👤 Following:\033[0m   $following"
    echo -e "  \033[1;32m📅 Joined:\033[0m      $created"
    echo ""
}

quinx-ghnotifs() {
    echo -e "\033[1;36m  ── GitHub Notifications ──\033[0m"
    local token=$(cat "$HOME/.config/gh/hosts.yml" 2>/dev/null | grep -A1 'oauth_token' | tail -1 | awk '{print $2}')
    if [ -z "$token" ]; then
        echo -e "\033[1;33m  Tip: Install gh CLI and run 'gh auth login'\033[0m"
        echo -e "\033[2m  Or: quinx-ghnotifs uses gh if available\033[0m"
        if command -v gh &>/dev/null; then
            gh notify --limit 10 2>/dev/null || echo -e "\033[2m  No notifications or gh notify not installed\033[0m"
        fi
        return
    fi
    local notifs=$(curl -s -H "Authorization: token $token" "https://api.github.com/notifications?per_page=10" 2>/dev/null)
    echo "$notifs" | python3 -c "
import sys, json
try:
    data = json.load(sys.stdin)
    if not data:
        print('  No new notifications')
    for n in data[:10]:
        reason = n.get('reason','')
        repo = n.get('repository',{}).get('full_name','')
        subject = n.get('subject',{}).get('title','')
        ntype = n.get('subject',{}).get('type','')
        icon = {'PullRequest':'🔀','Issue':'📋','Commit':'📝','Release':'🏷️'}.get(ntype,'📌')
        print(f'  {icon} {repo}: {subject[:50]}')
except:
    print('  Failed to fetch notifications')
" 2>/dev/null
    echo ""
}

quinx-ghstreak() {
    local user="${1:-}"
    if [ -z "$user" ]; then
        echo -e "\033[1;36m  Usage: quinx-ghstreak <username>\033[0m"
        return
    fi
    echo -e "\033[1;36m  ── GitHub Contribution Streak: $user ──\033[0m"
    local data=$(curl -s "https://github-contributions-api.jogruber.de/v4/$user" 2>/dev/null)
    local total=$(echo "$data" | python3 -c "
import sys, json
try:
    d = json.load(sys.stdin)
    total = d.get('total',{})
    years = sorted(total.keys(), reverse=True)
    current_year = years[0] if years else '?'
    count = total.get(current_year, 0)
    contributions = d.get('contributions',[])
    streak = 0
    for c in reversed(contributions):
        if c.get('count',0) > 0:
            streak += 1
        else:
            break
    print(f'This year: {count} contributions')
    print(f'Current streak: {streak} days')
except:
    print('Failed to fetch streak data')
" 2>/dev/null)
    echo ""
    echo -e "  $total"
    echo ""
}

quinx-ghrepo() {
    local repo="${1:-}"
    if [ -z "$repo" ]; then
        echo -e "\033[1;36m  Usage: quinx-ghrepo owner/repo\033[0m"
        return
    fi
    echo -e "\033[1;36m  ── Repository: $repo ──\033[0m"
    local data=$(curl -s "https://api.github.com/repos/$repo" 2>/dev/null)
    if echo "$data" | grep -q '"message".*"Not Found"'; then
        echo -e "\033[1;31m  Repository not found: $repo\033[0m"
        return
    fi
    echo "$data" | python3 -c "
import sys, json
d = json.load(sys.stdin)
print(f'  Name:        {d.get(\"name\",\"\")}')
print(f'  Description: {d.get(\"description\",\"N/A\")}')
print(f'  Stars:       ⭐ {d.get(\"stargazers_count\",0)}')
print(f'  Forks:       🍴 {d.get(\"forks_count\",0)}')
print(f'  Watchers:    👀 {d.get(\"watchers_count\",0)}')
print(f'  Language:    {d.get(\"language\",\"N/A\")}')
print(f'  License:     {d.get(\"license\",{}).get(\"spdx_id\",\"N/A\") if d.get(\"license\") else \"N/A\"}')
print(f'  Open Issues: {d.get(\"open_issues_count\",0)}')
print(f'  Created:     {d.get(\"created_at\",\"\")[:10]}')
print(f'  Updated:     {d.get(\"updated_at\",\"\")[:10]}')
print(f'  URL:         {d.get(\"html_url\",\"\")}')
" 2>/dev/null
    echo ""
}
