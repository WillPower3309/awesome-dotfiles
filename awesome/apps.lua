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


local apps = {}

apps.terminal = "kitty"
apps.launcher = "rofi -show drun"
apps.filebrowser = "thunar"
apps.browser = "firefox"
apps.editor = "code"
apps.musicPlayer = "spotify"
apps.gameLauncher = "steam"
apps.imageEditor = "gimp"
apps.virtualMachineLauncher = "virtualbox"
apps.lock = "i3lock"

-- List of apps to start once on start-up
local run_on_start_up = {
    "compton",
    "unclutter",
    "redshift -l 43.544804:-80.248169",
    "xinput set-prop 10 305 1" -- set touchpad to tap to click
}


-- ===================================================================
-- Functionality
-- ===================================================================


-- Run all the apps listed in run_on_start_up only once when awesome starts
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
