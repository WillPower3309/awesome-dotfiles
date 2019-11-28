# awesome-dotfiles

## Details ##
- **OS**: Arch Linux
- **Shell**: ZSH
- **WM**: awesome
- **Theme**: Adwaita-dark
- **Icons**: McMojave-Circle-Blue-Dark
- **Terminal**: Alacritty

## Current To-Do ##
- fix spinning cursor bug on adjust volume / brightness (due to components or widgets)
- make adjust volume / brightness more smooth
- finish adding keybinds
- populate side panel
- lock screen

## Dependencies ##
|Dependency|Description|Why|
|:----------|:-------------:|:------:|
|`awesome-git`|Window manager - **must use git version**|The WM these dotfiles are built around|
|`compton-tryone`|Window compositor|Screen tearing sucks and transparenct blurry windows are cool|
|`rofi`|Application launcher|used to launch applications|
|`feh`|Image viewer, used to set background|Sets background|

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
- `components`: FOlder that contains all of the components of the WM, such as panels, volume and brightness widgets, notification widget etc
- `widgets`: stores scripts used in the functionality of the components
