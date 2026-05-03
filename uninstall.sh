#!/bin/bash

# ============================================
# DEV-WORKFLOW UNINSTALLER
# ============================================

set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${YELLOW}This will remove dev-workflow configs from your system.${NC}"
echo "Files to be removed:"
echo "  - ~/.tmux.conf"
echo "  - ~/.vimrc"
echo "  - ~/bin/proj"
echo "  - ~/bin/projs"
echo "  - dev-workflow section from ~/.bash_aliases"
echo ""
read -p "Continue? (y/N): " confirm

if [ "$confirm" != "y" ] && [ "$confirm" != "Y" ]; then
    echo "Aborted."
    exit 0
fi

# Yedekle
backup_dir="$HOME/.dev-workflow-uninstall-backup-$(date +%Y%m%d-%H%M%S)"
mkdir -p "$backup_dir"

[ -f "$HOME/.tmux.conf" ] && mv "$HOME/.tmux.conf" "$backup_dir/"
[ -f "$HOME/.vimrc" ] && mv "$HOME/.vimrc" "$backup_dir/"
[ -f "$HOME/bin/proj" ] && rm "$HOME/bin/proj"
[ -f "$HOME/bin/projs" ] && rm "$HOME/bin/projs"

echo -e "${GREEN}Uninstall complete.${NC}"
echo "Old configs backed up to: $backup_dir"
echo "Note: Vim plugins (~/.vim) are preserved. Remove manually if needed: rm -rf ~/.vim"
