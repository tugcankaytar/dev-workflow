#!/bin/bash

# ============================================
# DEV-WORKFLOW INSTALL SCRIPT
# Sıfırdan Vim + Tmux + Git diff layout kurulumu
# ============================================

set -e  # Hata olursa dur

# Renkler
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logo
print_logo() {
    echo -e "${BLUE}"
    echo "╔══════════════════════════════════════════╗"
    echo "║       DEV-WORKFLOW INSTALLER             ║"
    echo "║   Vim + Tmux + Git Diff Layout           ║"
    echo "╚══════════════════════════════════════════╝"
    echo -e "${NC}"
}

# Log fonksiyonları
log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[✓]${NC} $1"; }
log_warning() { echo -e "${YELLOW}[!]${NC} $1"; }
log_error() { echo -e "${RED}[✗]${NC} $1"; }

# Repo klasörü (script'in çalıştığı yer)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ===== ANA KURULUM =====

print_logo

# 1. OS Kontrolü
log_info "Checking OS..."
if ! command -v apt &> /dev/null; then
    log_error "This script requires apt (Debian/Ubuntu)."
    exit 1
fi
log_success "OS check passed"

# 2. Mevcut config'leri yedekle
backup_dir="$HOME/.dev-workflow-backup-$(date +%Y%m%d-%H%M%S)"
log_info "Backing up existing configs to $backup_dir"
mkdir -p "$backup_dir"

[ -f "$HOME/.tmux.conf" ] && cp "$HOME/.tmux.conf" "$backup_dir/" && log_success "Backed up .tmux.conf"
[ -f "$HOME/.vimrc" ] && cp "$HOME/.vimrc" "$backup_dir/" && log_success "Backed up .vimrc"
[ -f "$HOME/.bash_aliases" ] && cp "$HOME/.bash_aliases" "$backup_dir/" && log_success "Backed up .bash_aliases"

# 3. Sistem paketlerini kur
log_info "Installing system packages..."
sudo apt update -qq
sudo apt install -y -qq \
    tmux \
    vim \
    git \
    curl \
    xclip \
    fzf \
    ripgrep \
    fonts-powerline \
    || { log_error "Package installation failed"; exit 1; }
log_success "System packages installed"

# 4. Config dosyalarını yerleştir
log_info "Installing config files..."
cp "$SCRIPT_DIR/config/tmux.conf" "$HOME/.tmux.conf"
log_success "Installed .tmux.conf"

cp "$SCRIPT_DIR/config/vimrc" "$HOME/.vimrc"
log_success "Installed .vimrc"

# bash_aliases — varsa ekle, yoksa oluştur
if [ -f "$HOME/.bash_aliases" ]; then
    if ! grep -q "DEV-WORKFLOW BASH ALIASES" "$HOME/.bash_aliases"; then
        echo "" >> "$HOME/.bash_aliases"
        cat "$SCRIPT_DIR/config/bash_aliases" >> "$HOME/.bash_aliases"
        log_success "Appended aliases to existing .bash_aliases"
    else
        log_warning ".bash_aliases already has dev-workflow content, skipping"
    fi
else
    cp "$SCRIPT_DIR/config/bash_aliases" "$HOME/.bash_aliases"
    log_success "Installed .bash_aliases"
fi

# .bashrc'de .bash_aliases yüklü mü?
if ! grep -q "bash_aliases" "$HOME/.bashrc"; then
    cat >> "$HOME/.bashrc" << 'EOF'

# Load bash aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
EOF
    log_success "Configured .bashrc to load aliases"
fi

# 5. Bin script'lerini yerleştir
log_info "Installing scripts..."
mkdir -p "$HOME/bin"
cp "$SCRIPT_DIR/bin/proj" "$HOME/bin/proj"
cp "$SCRIPT_DIR/bin/projs" "$HOME/bin/projs"
chmod +x "$HOME/bin/proj" "$HOME/bin/projs"
log_success "Installed proj and projs scripts"

# PATH'e ~/bin ekle
if ! echo "$PATH" | grep -q "$HOME/bin"; then
    if ! grep -q 'export PATH="$HOME/bin:$PATH"' "$HOME/.bashrc"; then
        echo 'export PATH="$HOME/bin:$PATH"' >> "$HOME/.bashrc"
        log_success "Added ~/bin to PATH"
    fi
fi

# 6. vim-plug kurulumu
log_info "Installing vim-plug..."
if [ ! -f "$HOME/.vim/autoload/plug.vim" ]; then
    curl -fLo "$HOME/.vim/autoload/plug.vim" --create-dirs --silent \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    log_success "vim-plug installed"
else
    log_warning "vim-plug already installed"
fi

# 7. Vim plugin'lerini kur
log_info "Installing Vim plugins (this may take 1-2 minutes)..."
vim +PlugInstall +qall 2>/dev/null || log_warning "Plugin install completed with warnings"
log_success "Vim plugins installed"

# 8. Projects klasörü oluştur (yoksa)
if [ ! -d "$HOME/projects" ]; then
    mkdir -p "$HOME/projects"
    log_success "Created ~/projects directory"
fi

# ===== KURULUM TAMAM =====
echo ""
echo -e "${GREEN}╔══════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║       INSTALLATION COMPLETE! ✓           ║${NC}"
echo -e "${GREEN}╚══════════════════════════════════════════╝${NC}"
echo ""
echo -e "${YELLOW}Next steps:${NC}"
echo "  1. Restart your terminal (or run: source ~/.bashrc)"
echo "  2. Navigate to a project: cd ~/projects/your-project"
echo "  3. Launch layout: p (or proj)"
echo "  4. Browse projects: projs"
echo ""
echo -e "${BLUE}Documentation:${NC}"
echo "  - Shortcuts: cat $SCRIPT_DIR/docs/shortcuts.md"
echo "  - Customization: cat $SCRIPT_DIR/docs/customization.md"
echo ""
echo -e "${YELLOW}Backup location:${NC} $backup_dir"
echo ""
