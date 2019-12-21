--      ████████╗██╗████████╗██╗     ███████╗██████╗  █████╗ ██████╗ 
--      ╚══██╔══╝██║╚══██╔══╝██║     ██╔════╝██╔══██╗██╔══██╗██╔══██╗
--         ██║   ██║   ██║   ██║     █████╗  ██████╔╝███████║██████╔╝
--         ██║   ██║   ██║   ██║     ██╔══╝  ██╔══██╗██╔══██║██╔══██╗
--         ██║   ██║   ██║   ███████╗███████╗██████╔╝██║  ██║██║  ██║
--         ╚═╝   ╚═╝   ╚═╝   ╚══════╝╚══════╝╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝

-- ===================================================================
-- Imports
-- ===================================================================


local awful = require("awful")
local gears = require("gears")
local wibox = require('wibox')
local beautiful = require("beautiful")
local dpi = require('beautiful').xresources.apply_dpi


-- ===================================================================
-- Add titlebars and rounded corners to clients
-- ===================================================================


-- define shape of non rounded corner windows
rectangle_shape = function(cr, w, h)
  gears.shape.rectangle(cr, w, h)
end

-- define shape of rounded corner windows
rounded_corner_shape = function(cr, width, height)
  gears.shape.rounded_rect(cr, width, height, beautiful.corner_radius)
end

-- Connect signal when client layout is changed
screen.connect_signal("arrange", function(s)
  for _, c in pairs(s.clients) do
    -- if client is maximized or fullscreen hide titlebar, no round corners
    if c.fullscreen or c.maximized or c.first_tag.layout.name == 'max' then
      c.shape = rectangle_shape

    -- otherwise add round corners
    else
      c.shape = rounded_corner_shape
    end
  end
end)