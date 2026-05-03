# Keyboard Shortcuts Cheatsheet

## Tmux (prefix: `Ctrl+a`)

### Sessions
- `Ctrl+a d` — Detach (background)
- `tmux ls` — List sessions
- `tmux attach -t name` — Attach to session
- `Ctrl+a $` — Rename session

### Windows (tabs)
- `Ctrl+a c` — New window
- `Ctrl+a 1-9` — Switch to window N
- `Ctrl+a ,` — Rename window
- `Ctrl+a &` — Close window

### Panes
- `Ctrl+a |` — Split vertical
- `Ctrl+a -` — Split horizontal
- `Ctrl+a h/j/k/l` — Navigate (Vim-style)
- `Ctrl+a H/J/K/L` — Resize (Shift+direction)
- `Ctrl+a z` — Toggle zoom
- `Ctrl+a x` — Close pane
- `Ctrl+a {` / `}` — Swap pane left/right

### Copy mode
- `Ctrl+a [` — Enter copy mode
- `v` — Start selection (in copy mode)
- `y` — Copy to system clipboard
- `q` — Exit copy mode

## Vim Essentials

### Movement
- `h j k l` — Left, down, up, right
- `w` / `b` — Next/prev word
- `0` / `$` — Line start/end
- `gg` / `G` — File start/end
- `Ctrl+d` / `Ctrl+u` — Half page down/up

### Editing
- `i` / `a` — Insert before/after cursor
- `o` / `O` — New line below/above
- `x` — Delete char
- `dd` — Delete line
- `yy` — Copy line
- `p` / `P` — Paste after/before
- `u` — Undo
- `Ctrl+r` — Redo

### Text Objects
- `ciw` — Change inner word
- `ci"` — Change inside quotes
- `ci(` — Change inside parens
- `vip` — Visual select paragraph

### Search
- `/text` — Search forward
- `?text` — Search backward
- `n` / `N` — Next/prev match
- `*` — Search word under cursor

### Files
- `:e file` — Open file
- `:w` — Save
- `:q` — Quit
- `:wq` / `ZZ` — Save and quit
- `:q!` — Force quit

## Vim + Git (with our config)

- `<Space>gg` — Git status
- `<Space>gd` — Git diff split
- `<Space>gb` — Git blame
- `<Space>gh` — Preview hunk
- `]c` / `[c` — Next/prev hunk
- `<Space>gs` — Stage hunk
- `<Space>gu` — Undo hunk

## Vim + FZF (with our config)

- `<Space>p` — Find file
- `<Space>b` — Switch buffer
- `<Space>r` — Search in files
- `<Space>/` — Search in current buffer
