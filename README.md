# awesome-dotfiles

![](/screenshot.png)

## Contents ##
1. [Details](#details)
2. [Dependencies](#dependencies)
3. [Installation](#installation)
4. [Folder Structure](#folderStructure)

<a name="details"></a>
## Details ##
- **OS**: Arch Linux
- **Shell**: ZSH
- **WM**: awesome
- **Theme**: Adwaita-dark
- **Icons**: McMojave-Circle-Blue-Dark
- **Terminal**: Alacritty

<a name="dependencies"></a>
## Dependencies ##
|Dependency|Description|Why|
|:----------|:-------------:|:------:|
|`awesome-git`|Window manager - **must use git version**|The WM these dotfiles are built around|
|`compton-tryone`|Window compositor|Screen tearing sucks and transparenct blurry windows are cool|
|`rofi`|Application launcher|used to launch applications|
|`feh`|Image viewer, used to set background|Sets background|

<a name="installation"></a>
## Installation ##
1. Ensure all [dependencies](#dependencies) are met
2. Clone this repository and place its contents into your `.config` folder
3. navigate to the `awesome` folder and place your desired wallpapers into the `wallpaper` folder, ensuring that you follow the naming conventions
4. edit the `apps.lua` file to define your desired default and startup applications
5. optional: edit the `keys.lua` file to change / add keybinds. Please refer to the [Folder Structure](#folderStructure) section of the readme to learn about how the file structure is laid out

<a name="folderStructure"></a>
## Awesome Folder File Structure ##
In order to avoid a poorly organized rc.lua spanning thousands of lines, it has been split into multiple files / folders.
- `rc.lua`: Contains the script that runs when awesome starts (essentially links all the other files together)
- `apps.lua`: Contains the default and startup applications
- `keys.lua`: Contains keybinds
- `rules.lua`: Contains window rules
- `theme.lua`: Contains theme variables
- `wallpaper.lua`: Contains wallpaper time changing functionality
- `icons`: stores icons used in WM
- `wallpaper`: stores wallpaper
- `components`: Folder that contains all of the components of the WM, such as panels, volume and brightness widgets, notification widget etc
- `widgets`: stores scripts used in the functionality of the components

## Current To-Do ##
- fix spinning cursor bug on adjust volume / brightness (due to components or widgets)
- make adjust volume / brightness more smooth
- finish adding keybinds
- populate side panel
- lock screen
