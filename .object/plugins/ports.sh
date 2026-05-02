#!/bin/bash
# QuinxOS Plugin: Port Scanner
# Usage: quinx-ports [host]

quinx-ports() {
    local host="${1:-localhost}"
    echo -e "\033[1;36m  Scanning ports on ${host}...\033[0m"
    (echo > /dev/tcp/${host}/22) 2>/dev/null && echo -e "  \033[1;32m22  (SSH)    — OPEN\033[0m" || echo -e "  \033[1;31m22  (SSH)    — closed\033[0m"
    (echo > /dev/tcp/${host}/80) 2>/dev/null && echo -e "  \033[1;32m80  (HTTP)   — OPEN\033[0m" || echo -e "  \033[1;31m80  (HTTP)   — closed\033[0m"
    (echo > /dev/tcp/${host}/443) 2>/dev/null && echo -e "  \033[1;32m443 (HTTPS)  — OPEN\033[0m" || echo -e "  \033[1;31m443 (HTTPS)  — closed\033[0m"
    (echo > /dev/tcp/${host}/8080) 2>/dev/null && echo -e "  \033[1;32m8080 (ALT)   — OPEN\033[0m" || echo -e "  \033[1;31m8080 (ALT)   — closed\033[0m"
    (echo > /dev/tcp/${host}/3306) 2>/dev/null && echo -e "  \033[1;32m3306 (MySQL) — OPEN\033[0m" || echo -e "  \033[1;31m3306 (MySQL) — closed\033[0m"
    (echo > /dev/tcp/${host}/5432) 2>/dev/null && echo -e "  \033[1;32m5432 (PgSQL) — OPEN\033[0m" || echo -e "  \033[1;31m5432 (PgSQL) — closed\033[0m"
    echo -e "\033[1;36m  Done.\033[0m"
}
