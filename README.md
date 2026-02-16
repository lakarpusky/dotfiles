# dotfiles

Personal configuration for Neovim, Alacritty, and tmux — managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Structure

| Package    | Config path                  |
|------------|------------------------------|
| `nvim`     | `~/.config/nvim`             |
| `alacritty`| `~/.config/alacritty`        |
| `tmux`     | `~/.tmux.conf`               |

## Install

```bash
git clone https://github.com/YOUR_USERNAME/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
stow nvim alacritty tmux
```
