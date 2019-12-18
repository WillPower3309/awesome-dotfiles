--       █████╗ ██████╗ ██████╗ ███████╗
--      ██╔══██╗██╔══██╗██╔══██╗██╔════╝
--      ███████║██████╔╝██████╔╝███████╗
--      ██╔══██║██╔═══╝ ██╔═══╝ ╚════██║
--      ██║  ██║██║     ██║     ███████║
--      ╚═╝  ╚═╝╚═╝     ╚═╝     ╚══════╝


local awful = require('awful')
local filesystem = require('gears.filesystem')


-- ===================================================================
-- App Declarations
-- ===================================================================


local apps = {
    terminal = "kitty",
    launcher = "rofi -normal-window -show drun",
    lock = "i3lock",
    screenshot = "scrot -e 'mv $f ~/Pictures/ 2>/dev/null'",
    filebrowser = "thunar",
    browser = "firefox",
    editor = "code",
    musicPlayer = "spotify",
    gameLauncher = "steam",
    imageEditor = "gimp",
    virtualMachineLauncher = "virtualbox"
}

-- List of apps to start once on start-up
local run_on_start_up = {
    "compton",
    "unclutter",
    "redshift -l 43.544804:-80.248169",
    "sh ~/Documents/wallblur.sh -i ~/.config/awesome/wallpaper.jpg"
}


-- ===================================================================
-- Functionality
-- ===================================================================


-- Run all the apps listed in run_on_start_up when awesome starts
local function run_once(cmd)
    local findme = cmd
    local firstspace = cmd:find(' ')
    if firstspace then
      findme = cmd:sub(0, firstspace - 1)
    end
    awful.spawn.with_shell(string.format('pgrep -u $USER -x %s > /dev/null || (%s)', findme, cmd), false)
end
  
for _, app in ipairs(run_on_start_up) do
    run_once(app)
end

-- return apps list
return apps
