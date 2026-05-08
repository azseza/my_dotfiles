# dotfiles

Personal Hyprland setup on Garuda Linux (Arch).

## What's in here

| Path | What |
|------|------|
| `.config/hypr/` | Hyprland — keybinds, animations, blur, hyprexpo overview, hyprlock, hypridle, scratchpad, swallowing |
| `.config/waybar/` | Waybar — config, custom CSS (translucent + soft hover), clipboard module |
| `.config/foot/` | foot terminal — JetBrainsMono, alpha 0.35, current `[colors-dark]` syntax |
| `.config/fish/` | fish 4.6 — starship prompt, eza/bat aliases, zoxide & fzf integration |
| `.config/wlogout/` | wlogout — power menu (lock / logout / suspend / reboot / shutdown) |
| `.vimrc` + `.vim/coc-settings.json` | vim — coc.nvim with rust-analyzer, format-on-save |
| `.local/bin/rust-analyzer` | wrapper that delegates to `rustup which rust-analyzer` for per-project toolchains |

## Required packages

```fish
sudo pacman -S --needed hyprland waybar foot fish starship \
    hyprlock hypridle wlogout wofi mako cliphist wl-clipboard \
    grimblast slurp swappy hyprpicker \
    eza bat fzf ripgrep fd zoxide lazygit github-cli \
    pamixer brightnessctl playerctl \
    nm-applet nwg-drawer thunar \
    rustup gamescope meson vim
```

Then install Hyprland plugins:
```fish
hyprpm update
hyprpm add https://github.com/hyprwm/hyprland-plugins
sudo hyprpm enable hyprexpo hyprfocus hyprbars
hyprpm reload
```

## Install

```fish
git clone https://github.com/<yourname>/dotfiles ~/dotfiles
cp -r ~/dotfiles/.config/* ~/.config/
cp ~/dotfiles/.vimrc ~/
mkdir -p ~/.vim ~/.local/bin
cp ~/dotfiles/.vim/coc-settings.json ~/.vim/
cp ~/dotfiles/.local/bin/rust-analyzer ~/.local/bin/ && chmod +x ~/.local/bin/rust-analyzer
```

For vim plugins: open vim → `:PlugInstall` → restart → coc auto-installs `coc-rust-analyzer`.

## Things to update for your machine

- `.config/hypr/cycle_wallpapers.sh` — `WALLPAPER_DIR` is hardcoded to `/home/azsesa/custom_wallpapers/photos`
- `.config/hypr/settings/monitor.conf` — outputs are named `HDMI-A-1` and `DP-3`; check `hyprctl monitors`
- `.config/waybar/config` — `"backlight"` device is `intel_backlight`; adjust if different

## Keybinds quick ref

| Bind | Action |
|------|--------|
| `Super + Return` / `Super + T` | terminal |
| `Super + Q` | close window |
| `Super + Tab` | workspace overview (hyprexpo) |
| `Super + \`` | drop-down scratchpad terminal |
| `Super + V` | clipboard history picker |
| `Super + Ctrl + L` | lock |
| `Super + Shift + E` | wlogout menu |
| `Super + Shift + C` | color picker → clipboard |
| `Super + R` | resize submap (h/j/k/l, Esc to exit) |
| `Super + Shift + arrows` | move window |
| `Print` | screenshot (full / area / window via Shift / Alt) |
