<h2>This is my Hyprland Dotfiles first version. You can download and use the dotfiles. But if you want a full installer script, then I have anothe repository for that.</h2>

<hr>

### How to use these files:
- First create a directory named hypr inside your .config directory. You can use this command:
   ```
   mkdir -p ~/.config/hypr
   ```
- Then copy this directory inside the newly created hypr directory. Use this command:
   ```
   git clone --depth=1 https://github.com/me-js-bro/Hyprland-Dots-01.git ~/.config/hypr/
   ```
- There are 3 neofetch folders. for Arch, Fedora and OpenSuse. rename one (according to your distro) to neofetch. Example: <br>
    `mv ~/.config/hypr/arch-neofetch ~/.config/hypr/neofetch`
- Now run this command. It will create symbolic link of all the main dirs:
   ```
   ln -sf ~/.config/hypr/btop ~/.config/btop
        ln -sf ~/.config/hypr/swaync ~/.config/swaync
        ln -sf ~/.config/hypr/kitty ~/.config/kitty
        ln -sf ~/.config/hypr/cava ~/.config/cava
        ln -sf ~/.config/hypr/neofetch ~/.config/neofetch
        ln -sf ~/.config/hypr/rofi ~/.config/rofi
        ln -sf ~/.config/hypr/swaylock ~/.config/swaylock
        ln -sf ~/.config/hypr/waybar ~/.config/waybar
        ln -sf ~/.config/hypr/wlogout ~/.config/wlogout
   ```
- If you need to change anything, you have to change it inside the `~/.config/hypr` directory.

#### But if you want to automate all these things along with installing some important packages and fonts, just follow the links below. <br>

#### To install Hyprland and copy the dotfiles on Arch Linux, please visit [Here](https://github.com/me-js-bro/Arch-Hyprland).

#### To install Hyprland and copy the dotfiles on Fedora Linux, please visit [Here](https://github.com/me-js-bro/Fedora-Hyprland).

#### To install Hyprland and copy the dotfiles on OpenSuse (Tumbleweed), please visit [Here](https://github.com/me-js-bro/OpenSuse-Hyprland).
