# Troubleshooting

## `proj` command not found

`~/bin` not in PATH. Run:

```bash
echo 'export PATH="$HOME/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

## Vim plugins not loading

Run `:PlugInstall` inside Vim. If error persists:

```bash
rm -rf ~/.vim/plugged
vim +PlugInstall +qall
```

## Colors look wrong in tmux

Ensure `screen-256color` terminal:

```bash
echo $TERM
# Should output: screen-256color (inside tmux)
```

If not, add to `~/.bashrc`:

```bash
[[ -n "$TMUX" ]] && export TERM=screen-256color
```

## Git diff not showing in Vim

GitGutter requires:
1. Inside a git repo (`git status` should work)
2. `set signcolumn=yes` (already in our config)
3. Force update: `:GitGutter`

## Claude Code not starting in pane

Install it:

```bash
npm install -g @anthropic-ai/claude-code
```

If npm not installed:

```bash
curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash -
sudo apt install -y nodejs
```

## tmux session won't close

```bash
tmux kill-session -t session-name
# or kill all
tmux kill-server
```

## Mouse scroll not working

Already enabled in our config. If still not working:

```bash
# In ~/.tmux.conf
set -g mouse on

# Reload
tmux source-file ~/.tmux.conf
```

## NERDTree shows weird icons

Install Nerd Fonts:

```bash
sudo apt install fonts-firacode fonts-powerline
```

Then set your terminal font to "FiraCode Nerd Font" or similar.

## Reset everything

```bash
./uninstall.sh
rm -rf ~/.vim ~/.dev-workflow-backup-*
./install.sh
```
