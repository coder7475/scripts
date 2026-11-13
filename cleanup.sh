#!/usr/bin/env bash
#
# System Cleanup Utility
# Safely inspects and clears unused caches, package archives, Docker resources, and logs.
#

set -uo pipefail

# ANSI Color Codes
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BOLD='\033[1m'
NC='\033[0m' # No Color

echo -e "${BLUE}${BOLD}=========================================${NC}"
echo -e "${BLUE}${BOLD}        System Cleanup Utility           ${NC}"
echo -e "${BLUE}${BOLD}=========================================${NC}"

show_disk() {
    echo -e "${YELLOW}Current Disk Usage on /:${NC}"
    df -h / | awk 'NR==1 || NR==2 {print "  " $0}'
    echo ""
}

show_disk

# Helper function to prompt user [Y/n]
confirm() {
    local prompt="$1"
    local default="${2:-y}"
    local reply
    if [[ "$default" == "y" ]]; then
        read -rp "$(echo -e "${BOLD}${prompt} [Y/n]: ${NC}")" reply
        reply="${reply:-y}"
        [[ "$reply" =~ ^[Yy]$ ]]
    else
        read -rp "$(echo -e "${BOLD}${prompt} [y/N]: ${NC}")" reply
        reply="${reply:-n}"
        [[ "$reply" =~ ^[Yy]$ ]]
    fi
}

# ----------------------------------------------------
# 1. System & APT Packages (Requires sudo)
# ----------------------------------------------------
echo -e "${BLUE}${BOLD}[1/4] System & APT Package Cleanup${NC}"
if confirm "Clean APT cache, remove orphaned packages, and vacuum system logs?"; then
    echo -e "${GREEN}Running APT & log cleanup...${NC}"
    sudo apt-get clean
    sudo apt-get autoclean
    sudo apt-get autoremove -y --purge

    # Purge residual config files (rc status)
    RC_PACKAGES=$(dpkg -l 2>/dev/null | awk '/^rc/ {print $2}')
    if [[ -n "$RC_PACKAGES" ]]; then
        echo -e "${YELLOW}Purging residual config files for uninstalled packages...${NC}"
        echo "$RC_PACKAGES" | xargs -r sudo dpkg --purge
    fi

    # Vacuum systemd logs down to 200MB
    if command -v journalctl >/dev/null 2>&1; then
        echo -e "${YELLOW}Vacuuming system logs to 200M...${NC}"
        sudo journalctl --vacuum-size=200M
    fi
else
    echo -e "Skipping system package cleanup."
fi
echo ""

# ----------------------------------------------------
# 2. Developer Tool Caches (NPM, PNPM, etc.)
# ----------------------------------------------------
echo -e "${BLUE}${BOLD}[2/4] Developer Caches (NPM, PNPM, tool caches)${NC}"
if confirm "Clean npm, pnpm, and security database caches?"; then
    # npm cache
    if [ -d "$HOME/.npm" ]; then
        echo -e "${GREEN}Cleaning npm & npx cache...${NC}"
        rm -rf "$HOME/.npm/_cacache" "$HOME/.npm/_npx"
    fi

    # pnpm store prune & cache
    if command -v pnpm >/dev/null 2>&1; then
        echo -e "${GREEN}Pruning unreferenced pnpm packages...${NC}"
        pnpm store prune 2>/dev/null || true
    fi
    if [ -d "$HOME/.cache/pnpm" ]; then
        rm -rf "$HOME/.cache/pnpm"
    fi

    # Dotslash cache
    if [ -d "$HOME/.cache/dotslash" ]; then
        echo -e "${GREEN}Cleaning dotslash binary cache...${NC}"
        rm -rf "$HOME/.cache/dotslash"
    fi

    # Grype vulnerability DB
    if [ -d "$HOME/.cache/grype" ]; then
        echo -e "${GREEN}Cleaning Grype vulnerability database cache...${NC}"
        rm -rf "$HOME/.cache/grype"
    fi

    # pip cache
    if [ -d "$HOME/.cache/pip" ]; then
        echo -e "${GREEN}Cleaning pip cache...${NC}"
        rm -rf "$HOME/.cache/pip"
    fi
else
    echo -e "Skipping developer cache cleanup."
fi
echo ""

# ----------------------------------------------------
# 3. Docker Maintenance
# ----------------------------------------------------
echo -e "${BLUE}${BOLD}[3/4] Docker System Cleanup${NC}"
if command -v docker >/dev/null 2>&1 && docker info >/dev/null 2>&1; then
    if confirm "Prune unused Docker images, containers, and build cache?"; then
        echo -e "${GREEN}Pruning unused Docker images and build cache...${NC}"
        docker image prune -a -f
        docker builder prune -a -f
        docker volume prune -f
    else
        echo -e "Skipping Docker standard prune."
    fi

    if confirm "Remove ALL unused named Docker volumes (Caution: deletes offline DB data)?" "n"; then
        echo -e "${RED}Pruning all unattached volumes...${NC}"
        docker volume prune -a -f
    fi
else
    echo -e "Docker is not running or not installed. Skipping."
fi
echo ""

# ----------------------------------------------------
# 4. Desktop, Trash & Browser Caches
# ----------------------------------------------------
echo -e "${BLUE}${BOLD}[4/4] Desktop & Browser Caches${NC}"
if confirm "Clean file thumbnails and empty Trash?"; then
    if [ -d "$HOME/.cache/thumbnails" ]; then
        echo -e "${GREEN}Cleaning thumbnail cache...${NC}"
        rm -rf "$HOME/.cache/thumbnails"/*
    fi
    if [ -d "$HOME/.local/share/Trash" ]; then
        echo -e "${GREEN}Emptying Trash...${NC}"
        rm -rf "$HOME/.local/share/Trash"/*
    fi
fi

if confirm "Clean web browser caches (Chromium, Brave, Firefox)?" "n"; then
    echo -e "${YELLOW}Clearing browser caches...${NC}"
    rm -rf "$HOME/.cache/chromium"
    rm -rf "$HOME/.cache/BraveSoftware"
    rm -rf "$HOME/.cache/mozilla"
fi
echo ""

echo -e "${GREEN}${BOLD}=========================================${NC}"
echo -e "${GREEN}${BOLD}           Cleanup Completed!            ${NC}"
echo -e "${GREEN}${BOLD}=========================================${NC}"
show_disk
