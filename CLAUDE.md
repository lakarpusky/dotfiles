# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/). Each top-level directory is a stow "package" whose internal path mirrors its destination under `$HOME`.

| Package     | Source path                          | Symlinked to           |
|-------------|---------------------------------------|-------------------------|
| `nvim`      | `nvim/.config/nvim/`                  | `~/.config/nvim`        |
| `alacritty` | `alacritty/.config/alacritty/`        | `~/.config/alacritty`   |
| `tmux`      | `tmux/.tmux.conf`                     | `~/.tmux.conf`          |

## Commands

```bash
stow nvim alacritty tmux   # symlink all packages into $HOME
stow -n -v nvim            # dry run for one package (preview what would be linked)
stow -D nvim                # remove (unlink) a package
stow -R nvim                 # restow (unlink + relink) after adding/removing files in a package
```

`.stow-local-ignore` excludes `.DS_Store` from being linked.

Because files are symlinked (not copied), edits made directly under `~/.config/nvim`, `~/.config/alacritty`, or `~/.tmux.conf` on the live machine are edits to this repo — there is no separate build/deploy step.

## Architecture notes

- **nvim** is the largest package by far and has its own `nvim/.config/nvim/CLAUDE.md` with plugin architecture, LSP setup, and keymap details — read that file when working inside `nvim/`.
- **tmux** (`tmux/.tmux.conf`) uses TPM (Tmux Plugin Manager) for plugins (`vim-tmux-navigator`, `tmux-themepack`, `tmux-resurrect`/`tmux-continuum` for session persistence, `tmux-yank`). Plugins are declared with `set -g @plugin` and installed/loaded via `run '~/.tmux/plugins/tpm/tpm'` at the bottom of the file — that line must stay last.
- **alacritty** (`alacritty/.config/alacritty/alacritty.toml`) auto-attaches/creates a tmux session on shell startup (`tmux attach || tmux new-session -s main`), so tmux and alacritty configs are coupled: changing the tmux session name convention here affects the alacritty shell args too. Theme lives in `alacritty/.config/alacritty/themes/tokyo-night.toml`.

When adding a new tool's config, create a new top-level package directory whose internal structure mirrors the target path under `$HOME` (following the existing `<package>/.config/<tool>/...` convention), then add it to the `stow` command in the README install instructions.
