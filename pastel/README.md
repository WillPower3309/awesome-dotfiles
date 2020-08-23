<div align="center">
    <h1>Awesome Dotfiles</h1>
</div>

![](https://raw.githubusercontent.com/WillPower3309/awesome-dotfiles/mirage_theme/screenshots/screenshot.png)

## Contents ##
1. [Details](#details)
2. [Features](#features)
3. [Dependencies](#dependencies)
4. [Installation](#installation)
5. [Folder Structure](#folderStructure)
6. [My Preferred Applications](#applications)
7. [Application Theming](#appTheming)
8. [Keybinds](#keybinds)
9. [Notes](#notes)

<a name="details"></a>
## Details ##
+ **OS**: Arch Linux
+ **Shell**: ZSH
+ **WM**: awesome
+ **Theme**: Qogir Dark
+ **Icons**: Tela Dark
+ **Cursor**: xCursor Breeze Light
+ **Terminal**: Alacritty

<a name="features"></a>
## Features ##
+ Super lightweight
+ Easy installation / configuration
+ Very few dependencies
+ Wallpaper auto-blur functionality
+ Exit screen
+ Locking (via `i3lock`)
+ Touch screen friendly (I primarily run this on a microsoft surface pro 6)
+ Automatic dpi / resolution scaling
  + Note that xft.dpi must be properly assigned in the .Xresources file if you are using a high DPI screen
+ Supports multi monitor setups!
  + The top bar appears on every monitor, and the side bar only appears on the main monitor
+ i3-like keybinds
+ Very stable: Built off of the awesome 4.3 release, no bleeding edge git versions required here!

<a name="dependencies"></a>
## Dependencies ##
I have made my best effort to reduce the number of dependencies by using the awesome API to its fullest extent, and allowing users to edit the `apps.lua` file (see [installation section](#installation)) to define their own preferred applications. That being said, here are the dependencies.

|Dependency|Description|
|:----------:|:-------------:|
|`awesome`|Window manager|
|`feh`|Fast image viewer used as wallpaper setting utility|
|`picom`|Window compositor, eliminates screen tearing and allows for cool fade effects|
|`rofi`|Application launcher|
|`i3lock`|Used to lock the screen|
|`imagemagick`|**OPTIONAL BUT NEEDED IF USING A DIFFERENT BACKGROUND**, used in config to generate blurred wallpaper|

### Optional Dependencies ###
These will improve the user experience but aren't required:
**Bear in mind that most of these dependencies come preinstalled on non arch systems. I would recommend reading their descriptions below to determine which ones you need to install. Alternatively, set up my config and install the packages based on what isn't appearing in the top panel.**
+ `i3lock`: Will be opened when the lock icon is selected in the exit window
+ `acpi`: Battery managing cli application, used by top bar widget to determine battery status
+ `xfce4-power-manager`: Lightweight power manager spawned when the top panel battery icon is clicked
+ `bluez`, `bluez-utils`: Bluetooth cli application, used by top bar widget to determine if bluetooth is on
+ `blueman`: Bluetooth managing application, spawns when the bluetooth top panel icon is clicked
+ `pamac-aur`: Lightweight GUI package manager, spawned when the top panel package icon is clicked
+ `nm-connection-editor`: GUI wifi connection editor, spawned when the top panel wifi icon is clicked
+ `scrot`: Screenshot tool, which is mapped to the Print Screen key in keys.lua. **If you want to meet this dependency, ensure that the `~/Pictures` folder exists**, otherwise the program will save your screenshots to your home directory
+ `alsa-utils`: Provides kernel driven sound drivers, which the control of has been mapped to volume keys in keys.lua
+ `xbacklight`: Controls display brightness, which the control of has been mapped to brightness keys in keys.lua

### Fonts You Should Install ###
+ `SF Text`: System font used by macOS, iOS, and watchOS. Used in this config as the WM font. Also used as font for firefox
+ [`MesloLGS`](https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf): Terminal font, customized to work flawlessly with the zsh theme used, mentioned in the [application theming](#appTheming) section of the readme.

<a name="installation"></a>
## Installation ##
1. Ensure all [dependencies](#dependencies) are met
2. Clone this repository and place its contents into your `.config` folder
3. navigate to the `awesome/wallpaper` folder and place your desired wallpaper there, ensuring that it is named `wallpaper`. One  awesome (pun intended) feature of my config is that the filetype of the wallpaper can be any image filetype and it will automatically recognize it. Remember to delete the `blurredWallpaper` file in order to make the blurring script recognize a new wallpaper has been added and needs to be blurred 
4. edit the `apps.lua` file to define your desired default and startup applications.
5. If the wifi top bar widget is not working, edit the `widgets/wifi.lua` file and ensure that the `local interface` variable matches your wifi interface name (if you are unsure how to find your interface name, check out [this discussion](https://bbs.archlinux.org/viewtopic.php?id=166171)).
6. optional: edit the `keys.lua` file to change / add keybinds

<a name="folderStructure"></a>
## Awesome Folder File Structure ##
In order to avoid a poorly organized `rc.lua` spanning thousands of lines, it has been split into multiple files / folders. I have taken extra care to create a logical directory structure that will hopefully allow those new to awesomewm to have an easy time navigating it.
+ `rc.lua`: Contains the script that runs when awesome starts (essentially links all the other files together)
+ `apps.lua`: Contains the default and startup applications
+ `keys.lua`: Contains keybinds
+ `rules.lua`: Contains window rules
+ `theme.lua`: Contains theme variables
+ `tags.lua`: Contains tag (aka workspace) information, edit this to change the tag's icon and behaviour
+ `icons`: stores icons used in WM
+ `components`: Folder that contains all of the components of the WM, such as panels, volume and brightness sliders, notification pop-ups, etc
+ `widgets`: Stores widgets used in the functionality of the components
+ `wallpaper`: Where wallpaper and its blurred varient is generated / stored

<a name="applications"></a>
## My Preferred Applications ##
+ **Display Manager - SDDM (with sddm-sugar-dark theme)**: Beautiful display manager. Matches the window manager theme very well and looks amazing
+ **Text Editor - doom emacs and nvim**: I'm an alpha chad
+ **File Manager - Nautilus**: Lightweight file browser, few dependencies, and can be configured to work with a preferred terminal. Also has extensions for easy right click extraction / compression of archive files (ie zip / rar etc)
+ **Web Browser - Firefox**: Super configurable and isn't made by Google
+ **Terminal - Alacritty**: A FREAKIN GPU ACCELERATED TERMINAL. So OP I love it
+ **Theme / Look & Feel Manager - lxappearance**: makes managing icon / cursor / application themes easy, only theme manager with no DE dependencies, and works very well

### Other cool applications you should install ###
+ `redshift`: Changed screen warmth based on the time of day
+ `neofetch`: Displays system information in the terminal
+ `cmatrix`: Terminal base matrix text effect
+ `cava`: Terminal audio visualizer!

<a name="appTheming"></a>
## Application Theming ##
### Firefox ###
1. Set up [my custom Firefox theme](https://github.com/willpower3309/MinimalistMaterialFox)
2. Use [this](https://github.com/Jaredk3nt/homepage) homepage
3. Use `SF Text` font

### Spotify ###
1. [Install `Spicetify`](https://github.com/khanhas/spicetify-cli)
2. chown spotify directory: `sudo chown $USER -R /opt/spotify`
3. run `spicetify` once to generate config
4. `spicetify backup apply enable-devtool` to enable devtools
5. Copy my spicetify folder to `~/.config`
6. run `spicetify update restart`

### Neovim ###
1. Ensure the nvim folder from the repo has been copied into the `~/.config` directory
2. Install VimPlug with
```
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```
3. Open neovim and run `:PlugInstall`
4. Exit and reopen neovim

### Zsh ###
1. Install oh-my-zsh
```
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```
2. Change the zsh theme to powerlevel10k
  + Download [this font](https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf), and move it into your `/usr/share/fonts` directory
  + Install powerlevel10k with the command below:
  ```
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
  ```
  + Open `~/.zshrc` with your fave text editor
  + Set `ZSH_THEME="powerlevel10k/powerlevel10k"` and save the file
3. Install Plugins (Note that the ~/.zshrc edits are already done in this repo)
  + Syntax highlighting (copy and paste the below command to install)
    ```
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    ```
    + Edit `~/.zshrc`, add `zsh-syntax-highlighting` to the plugins section
  + Autosuggestions (copy and paste the below command to install)
    ```
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    ```
    + Edit `~/.zshrc`, add `zsh-autosuggestions` to the plugins section
4. Fini! Reopen the terminal to view the fruit of your labor

<a name="keybinds"></a>
## Keybinds ##
**Note that the modkey is set to be the windows / command key. If you would like to use a different modkey check out the `keys.lua` file.**
If you are new to awesomewm, note that tag refers to workspace, and client refers to window.

### Keyboard ###
+ `mod + enter`: Spawn terminal
+ `mod + d`: Spawn rofi (an application menu)
+ `mod + f`: Make client fullscreen
+ `mod + m`: Maximize client
+ `mod + n`: Minimize client
+ `mod + shift + n`: Unminimize client
+ `mod + [1-9]`: Switch to tag [1-9]
+ `mod + shift + [1-9]`: Move client to tag [1-9]
+ `mod + space`: Change the tag layout, alternating between tiled, floating, and maximized
+ `mod + [up / down / left / right / h / j / k / l]`: Change client by direction
+ `mod + Shift + [up / down / left / right / h / j / k / l]`: Move client by direction
+ `mod + Control + [up / down / left / right / h / j / k / l]`: Resize client by direction
+ `mod + Escape`: Show exit screen

### Mouse ###
+ `mod + drag with left click`: Move client
+ `mod + drag with right click`: Resize client

<a name="notes"></a>
## Notes ##
+ [Awesome API Documentation](https://awesomewm.org/apidoc/index.html)
+ If you encounter any problems please open an issue in this repo and I will gladly investigate it
+ If you would like to change the wallpaper, ensure that the wallpaper is named "wallpaper" and is located in the `~/.config/awesome` folder. Also ensure that you delete the blurred wallpaper file in order for the blurring script to recognize it needs to generate a new blurred wallpaper
