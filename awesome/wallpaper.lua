--      ██╗    ██╗ █████╗ ██╗     ██╗     ██████╗  █████╗ ██████╗ ███████╗██████╗
--      ██║    ██║██╔══██╗██║     ██║     ██╔══██╗██╔══██╗██╔══██╗██╔════╝██╔══██╗
--      ██║ █╗ ██║███████║██║     ██║     ██████╔╝███████║██████╔╝█████╗  ██████╔╝
--      ██║███╗██║██╔══██║██║     ██║     ██╔═══╝ ██╔══██║██╔═══╝ ██╔══╝  ██╔══██╗
--      ╚███╔███╔╝██║  ██║███████╗███████╗██║     ██║  ██║██║     ███████╗██║  ██║
--       ╚══╝╚══╝ ╚═╝  ╚═╝╚══════╝╚══════╝╚═╝     ╚═╝  ╚═╝╚═╝     ╚══════╝╚═╝  ╚═╝

-- ===================================================================
-- Imports
-- ===================================================================


local gears = require('gears')
local awful = require('awful')


-- ===================================================================
-- Variables
-- ===================================================================

-- day / noon / evening time must be a number between 0-23, representing the hour
local dayTime = 6
local noonTime = 12
local eveningTime = 18
local checkTimePer = 600 -- seconds

local wall_dir = gears.filesystem.get_configuration_dir() .. '/wallpapers/'


-- ===================================================================
-- Set Wallpaper Function
-- ===================================================================


function timeChecker()
  time = os.date("*t")
  time = time.hour
  -- Morning
  if tonumber(time) >= dayTime and tonumber(time) < noonTime then
    gears.wallpaper.maximized(wall_dir .. "noon-wallpaper.png", nil, false)
  -- Noon
  elseif tonumber(time) >= noonTime and tonumber(time) < eveningTime then
    gears.wallpaper.maximized(wall_dir .. "noon-wallpaper.png", nil, false)
  -- Evening
  elseif tonumber(time) >= eveningTime then
    gears.wallpaper.maximized(wall_dir .. "noon-wallpaper.png", nil, false)
  -- Night
  else
    gears.wallpaper.maximized(wall_dir .. "noon-wallpaper.png", nil, false)
  end
end

-- Check time every 10 mins
local runCheck = gears.timer {
  timeout   = checkTimePer,
  autostart = true,
  call_now = true,
  callback  = function()
    timeChecker()
  end
}

-- Run Once On Start-up
local runOnce = gears.timer {
  timeout   = 0,
  call_now  = true,
  autostart = true,
  callback  = function()
    timeChecker()
  end,
  single_shot = true
}

timeChecker()

--local f = io.popen("sh -c \"find ~/.wallpaper -name '*.png' | shuf -n 1 | xargs echo -n\"")
--local wallpaper = f:read("*all")
--f:close()
--for s = 1, screen.count() do
--  gears.wallpaper.maximized(wallpaper, nil, true, nil)
--end
