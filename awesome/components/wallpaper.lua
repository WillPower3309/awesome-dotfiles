--      ██╗    ██╗ █████╗ ██╗     ██╗     ██████╗  █████╗ ██████╗ ███████╗██████╗ 
--      ██║    ██║██╔══██╗██║     ██║     ██╔══██╗██╔══██╗██╔══██╗██╔════╝██╔══██╗
--      ██║ █╗ ██║███████║██║     ██║     ██████╔╝███████║██████╔╝█████╗  ██████╔╝
--      ██║███╗██║██╔══██║██║     ██║     ██╔═══╝ ██╔══██║██╔═══╝ ██╔══╝  ██╔══██╗
--      ╚███╔███╔╝██║  ██║███████╗███████╗██║     ██║  ██║██║     ███████╗██║  ██║
--       ╚══╝╚══╝ ╚═╝  ╚═╝╚══════╝╚══════╝╚═╝     ╚═╝  ╚═╝╚═╝     ╚══════╝╚═╝  ╚═╝

-- ===================================================================
-- Imports
-- ===================================================================


local awful = require("awful")
local gears = require("gears")
local naughty = require("naughty")
local config_dir = gears.filesystem.get_configuration_dir()


-- ===================================================================
-- Functionality
-- ===================================================================


local wallpaper = config_dir .. "/wallpaper.png"
local blurredWallpaper = config_dir .. "/blurredWallpaper.png"

-- Set Wallpaper
gears.wallpaper.maximized(wallpaper)

--- Check if a file or directory exists in this path
local function exists(file)
   local ok, err, code = os.rename(file, file)
   if not ok then
      if code == 13 then
         -- Permission denied, but it exists
         return true
      end
   end
   return ok, err
end

-- check if blurred wallpaper needs to be created
if not exists(blurredWallpaper) then
   -- uses image magick to create a blurred version of the wallpaper
   awful.spawn.with_shell("convert -blur 0x5 " .. wallpaper .. " " .. blurredWallpaper)
end

-- show blurred wallpaper when client is focuses
client.connect_signal("focus", function(c)
   gears.wallpaper.maximized(blurredWallpaper)
end)

-- show non blurred wallpaper when client is unfocused
client.connect_signal("unfocus", function(c)
   gears.wallpaper.maximized(wallpaper)
end)
