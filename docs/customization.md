# Customization Guide

## Change pane sizes

Edit `~/bin/proj` and modify the `-p` values:

```bash
# Right side: 30% (default)
tmux split-window -h -p 30 ...

# Bottom-right: 50% of right side
tmux split-window -v -p 50 ...
```

## Change colors / theme

### Tmux

Edit `~/.tmux.conf`:

```bash
set -g status-bg colour235  # Status bar background
set -g status-fg white      # Status bar text
```

[Color reference](https://i.imgur.com/PvQs2dF.png)

### Vim

Edit `~/.vimrc`:

```vim
silent! colorscheme gruvbox  " Change to: dracula, nord, solarized, etc.
```

Other themes (add to `call plug#begin()` block):

```vim
Plug 'dracula/vim'
Plug 'arcticicestudio/nord-vim'
Plug 'altercation/vim-colors-solarized'
```

After adding, run `:PlugInstall` in Vim.

## Add new aliases

Edit `~/.bash_aliases` and add:

```bash
alias myalias='your-command'
```

Then `source ~/.bashrc`.

## Add Vim plugins

Edit `~/.vimrc`, find the `call plug#begin()` block, add:

```vim
Plug 'github-user/plugin-name'
```

Then in Vim: `:PlugInstall`

## Change default project directory

By default, `projs` looks in `~/projects`. To change:

```bash
echo 'export PROJECTS_DIR="$HOME/work"' >> ~/.bashrc
source ~/.bashrc
```

## Remove Claude Code from layout

Edit `~/bin/proj` and change:

```bash
tmux send-keys -t "$SESSION_NAME":0.1 "claude" C-m
```

To:

```bash
tmux send-keys -t "$SESSION_NAME":0.1 "echo 'Custom command here'" C-m
```

## Change tmux prefix

Edit `~/.tmux.conf`:

```bash
unbind C-a              # Unbind current prefix
set-option -g prefix C-x  # Change to Ctrl+x
bind-key C-x send-prefix
```
