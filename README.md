<h2>This is my Hyprland Dotfiles first version. You can download and use the dotfiles. But if you want a full installer script, then I have anothe repository for that.</h2>

## Screenshots
<p align="center">
   <img align="center" width="49%" src="https://github.com/me-js-bro/Screen-Shots/blob/main/arch/1.png?raw=true" /> <img align="center" width="49%" src="https://github.com/me-js-bro/Screen-Shots/blob/main/fedora/3.png?raw=true" />

   <img align="center" width="49%" src="https://github.com/me-js-bro/Screen-Shots/blob/main/fedora/5.png?raw=true" /> <img align="center" width="49%" src="https://github.com/me-js-bro/Screen-Shots/blob/main/fedora/4.png?raw=true" />
</p>

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
- Now make all the necessary script executable. Run this command:
   ```
   chmod +x ~/.config/hypr/scripts/*
   ```
<hr>

## If you need to change anything, you have to change it inside the `~/.config/hypr` directory.

#### But if you want to automate all these things along with installing some important packages and fonts, just follow the links below. <br>

#### To install Hyprland and copy the dotfiles on Arch Linux, please visit [Here](https://github.com/me-js-bro/Arch-Hyprland).

#### To install Hyprland and copy the dotfiles on Fedora Linux, please visit [Here](https://github.com/me-js-bro/Fedora-Hyprland).

#### To install Hyprland and copy the dotfiles on OpenSuse (Tumbleweed), please visit [Here](https://github.com/me-js-bro/OpenSuse-Hyprland).


<br>


 <h1 align="center">Contributing on this project...</h1>
<h4>Well I could not add so many features on this project that are usefull for laptops <b><i>(Because I do not have any laptop)</i></b>. I would like you to contribute on this project and make the scripts and dotfiles better, if you are interested.</h4>

 ### What to do:

1) Fork this repository.
2) Make sure to uncheck the Copy the `main` branch only, under the Description option. This will copy the development branch also
3) After forking, Clone the development branch of the forked repository in your PC. example: <br>
    `git clone --depth=1 -b development https://github.com/your_github_user_name/Fedora-Hyprland.git`
5) Create a branch with your name on the forked repository ( GitHub Name )
6) Commit the changes with some description. For example:<br>
    `git commit -m "added this feature in the _directory"`
7) Push changes to your created branch, For example: <br>
    `git push origin your_created_branch_name`
8) And then, create a pull request with the changes you have made.
    - Make sure to add the <i> pull request </i> on the `development` branch of the main repository ( With descriptions )

<br>
<br>

### Pull Request
1) Add a short description of what you have changed.
2) A list of the dependencies of packages required for the changes. ( if need any )


<hr>
