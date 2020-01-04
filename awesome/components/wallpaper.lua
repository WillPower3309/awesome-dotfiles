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
-- Initialization
-- ===================================================================

--os.getenv('HOME')

local blurred = false;

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
   awful.spawn.with_shell("convert -filter Gaussian -blur 0x9 " .. wallpaper .. " " .. blurredWallpaper)
end


-- ===================================================================
-- Functionality
-- ===================================================================


-- changes to blurred wallpaper
local function blur()
   if not blurred then
      gears.wallpaper.maximized(blurredWallpaper)
      blurred = true
   end
end

-- changes to normal wallpaper
local function unblur()
   if blurred then
      gears.wallpaper.maximized(wallpaper)
      blurred = false
   end
end

-- blur / unblur on tag change
tag.connect_signal('property::selected', function(t)
   -- if tag has clients
   for _ in pairs(t:clients()) do
      blur()
      return
   end

   -- if tag has no clients
   unblur()
end)

-- check if wallpaper should be blurred on client open
client.connect_signal("manage", function(c)
   blur()
end)

-- check if wallpaper should be unblurred on client close
client.connect_signal("unmanage", function(c)
   local t = awful.screen.focused().selected_tag
   -- check if any open clients
   for _ in pairs(t:clients()) do
      return
   end
   -- unblur if no open clients
   unblur()
end)
