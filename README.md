# Dotfiles (Arch Linux · Hyprland · Omarchy 4.5)

## Packages

- `shell`: `.bashrc`, `.bash_profile`, `.zshrc`, `.profile`, `.XCompose`, `starship.toml`
- `hypr`: `hypr/`, `uwsm/`, `fontconfig/`, `gtk-3.0/`, `gtk-4.0/`, `mimeapps.list`, `xdg-terminals.list`, `user-dirs.dirs`
- `omarchy`: `shell.json`, `shell.toml`, `hooks/`, `lock-designs/`, `themes/`, and custom/cloned plugins (`callmeilyas.*`)
- `terminal`: `alacritty/`, `foot/`, `ghostty/`, `kitty/`, `tmux/`
- `editor`: `git/`, `lazydocker/`, `lazygit/`, `mise/`, `nvim/`, `zed/`
- `tools`: `btop/`, `fastfetch/`, `fcitx5/`, `focusd/`, `hyfetch.json`, `mpv/`
- `local-bin`: custom `~/.local/bin/omarchy-*` scripts

## Setup

```bash
sudo pacman -S --needed stow git
git clone <your-repo-url> ~/dotfiles
cd ~/dotfiles
stow shell hypr omarchy terminal editor tools local-bin
./install-plugins.sh
omarchy restart shell
```
