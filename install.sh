#!/usr/bin/env bash

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"

# Color output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
BOLD='\033[1m'
NC='\033[0m'

# Declare all managed mappings: "source_relative_to_repo:target_relative_to_home"
MAPPINGS=(
    # Shell
    "shell/all_sh_aliases:.all_sh_aliases"
    "shell/all_sh_env:.all_sh_env"
    "shell/bash_aliases:.bash_aliases"
    "shell/bash_profile:.bash_profile"
    "shell/zsh_aliases:.zsh_aliases"

    # Terminal & Editors
    "tmux/tmux.conf:.tmux.conf"
    "vim/vimrc:.vimrc"
    "vim/vimrc.bundles:.vimrc.bundles"
    "gdb/gdbinit:.gdbinit"
    "X11/Xresources:.Xresources"

    # Services & Network
    "ssh/config:.ssh/config"
    "aria2/aria2.conf:.aria2/aria2.conf"
    "elinks/elinks.conf:.elinks/elinks.conf"

    # XDG .config
    "config/browsh/config.toml:.config/browsh/config.toml"
    "config/fish/config.fish:.config/fish/config.fish"
    "config/fish/functions/fish_prompt.fish:.config/fish/functions/fish_prompt.fish"
    "config/mpv/mpv.conf:.config/mpv/mpv.conf"
    "config/qutebrowser/config.py:.config/qutebrowser/config.py"
    "config/qutebrowser/user_stylesheets.css:.config/qutebrowser/user_stylesheets.css"
    "config/zathura/zathurarc:.config/zathura/zathurarc"
)

link_file() {
    local src="$1"
    local dst="$2"

    mkdir -p "$(dirname "$dst")"

    if [ -L "$dst" ]; then
        local current_target
        current_target="$(readlink "$dst")"
        if [ "$current_target" = "$src" ]; then
            printf "  ${GREEN}✓${NC} %s -> %s (already linked)\n" "$dst" "$src"
            return 0
        fi
        # Symlink points elsewhere, update it
        rm -f "$dst"
    elif [ -e "$dst" ]; then
        # Real file exists, make a backup
        local backup="${dst}.bak-$(date +%Y%m%d%H%M%S)"
        printf "  ${YELLOW}!${NC} %s already exists as a regular file. Backing up to %s\n" "$dst" "$backup"
        mv "$dst" "$backup"
    fi

    ln -sf "$src" "$dst"
    printf "  ${GREEN}+${NC} Linked %s -> %s\n" "$dst" "$src"
}

unlink_file() {
    local src="$1"
    local dst="$2"

    if [ -L "$dst" ]; then
        local current_target
        current_target="$(readlink "$dst")"
        if [ "$current_target" = "$src" ]; then
            rm -f "$dst"
            printf "  ${RED}-${NC} Unlinked %s\n" "$dst"
            return 0
        fi
    fi
    printf "  ${YELLOW}?${NC} Skipped %s (not linked to this repository)\n" "$dst"
}

check_status() {
    printf "${BOLD}%-42s %-14s %s${NC}\n" "Target File (~/...)" "Status" "Repo Source"
    printf "%-42s %-14s %s\n" "-------------------" "------" "-----------"

    for mapping in "${MAPPINGS[@]}"; do
        local rel_src="${mapping%%:*}"
        local rel_dst="${mapping##*:}"
        local src="$DOTFILES_DIR/$rel_src"
        local dst="$HOME/$rel_dst"

        if [ ! -e "$src" ]; then
            printf "%-42s ${RED}%-14s${NC} %s (repo file missing)\n" "~/$rel_dst" "[ERR:SRC]" "$rel_src"
        elif [ -L "$dst" ]; then
            local current_target
            current_target="$(readlink "$dst")"
            if [ "$current_target" = "$src" ]; then
                printf "%-42s ${GREEN}%-14s${NC} %s\n" "~/$rel_dst" "[OK]" "$rel_src"
            else
                printf "%-42s ${YELLOW}%-14s${NC} points to %s\n" "~/$rel_dst" "[DIFF LINK]" "$current_target"
            fi
        elif [ -e "$dst" ]; then
            printf "%-42s ${YELLOW}%-14s${NC} %s (regular file)\n" "~/$rel_dst" "[NOT LINKED]" "$rel_src"
        else
            printf "%-42s ${RED}%-14s${NC} %s (missing)\n" "~/$rel_dst" "[MISSING]" "$rel_src"
        fi
    done
}

link_all() {
    echo "Linking dotfiles..."
    for mapping in "${MAPPINGS[@]}"; do
        local rel_src="${mapping%%:*}"
        local rel_dst="${mapping##*:}"
        link_file "$DOTFILES_DIR/$rel_src" "$HOME/$rel_dst"
    done

    # Ensure shell configuration files source all_sh_aliases if present
    local files=("$HOME/.bashrc" "$HOME/.zshrc")
    local line='source ~/.all_sh_aliases'
    for f in "${files[@]}"; do
        if [ -f "$f" ]; then
            if ! grep -q "all_sh_aliases" "$f"; then
                echo "$line" >> "$f"
                printf "  ${GREEN}+${NC} Added '%s' to %s\n" "$line" "$f"
            fi
        fi
    done

    echo "All dotfiles successfully linked!"
}

unlink_all() {
    echo "Removing symlinks..."
    for mapping in "${MAPPINGS[@]}"; do
        local rel_src="${mapping%%:*}"
        local rel_dst="${mapping##*:}"
        unlink_file "$DOTFILES_DIR/$rel_src" "$HOME/$rel_dst"
    done
    echo "Unlink complete."
}

case "${1:-link}" in
    link)
        link_all
        ;;
    unlink)
        unlink_all
        ;;
    status)
        check_status
        ;;
    help|--help|-h)
        echo "Usage: $0 [command]"
        echo ""
        echo "Commands:"
        echo "  link      (default) Create/update all symlinks in \$HOME"
        echo "  status    Show status of all managed dotfiles"
        echo "  unlink    Remove symlinks created by this repository"
        echo "  help      Show this help message"
        ;;
    *)
        echo "Unknown command: $1"
        echo "Run '$0 help' for usage."
        exit 1
        ;;
esac
