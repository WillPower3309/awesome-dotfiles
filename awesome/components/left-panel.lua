--      ██╗     ███████╗███████╗████████╗    ██████╗  █████╗ ███╗   ██╗███████╗██╗
--      ██║     ██╔════╝██╔════╝╚══██╔══╝    ██╔══██╗██╔══██╗████╗  ██║██╔════╝██║
--      ██║     █████╗  █████╗     ██║       ██████╔╝███████║██╔██╗ ██║█████╗  ██║
--      ██║     ██╔══╝  ██╔══╝     ██║       ██╔═══╝ ██╔══██║██║╚██╗██║██╔══╝  ██║
--      ███████╗███████╗██║        ██║       ██║     ██║  ██║██║ ╚████║███████╗███████╗
--      ╚══════╝╚══════╝╚═╝        ╚═╝       ╚═╝     ╚═╝  ╚═╝╚═╝  ╚═══╝╚══════╝╚══════╝

-- ===================================================================
-- Initialization
-- ===================================================================


local beautiful = require("beautiful")
local wibox = require("wibox")
local dpi = require("beautiful").xresources.apply_dpi
local awful = require("awful")
local gears = require("gears")

local tag_list = require("widgets.tag-list")
local separator = require("widgets.horizontal-separator")
local folder = require("widgets.folder")

local home_dir = os.getenv("HOME")

-- define module table
local left_panel = {}


-- ===================================================================
-- Bar Creation
-- ===================================================================


left_panel.create = function(s)
   local panel = awful.wibar({
      screen = s,
      position = "left",
      height = s.geometry.height * 7/10,
      width = dpi(55),
      shape = function(cr, width, height)
         gears.shape.partially_rounded_rect(cr, width, height, false, true, true, false, 12)
      end
   })

   panel:setup {
      expand = "none",
      layout = wibox.layout.align.vertical,
      nil,
      {
         layout = wibox.layout.fixed.vertical,
         -- add taglist widget
         tag_list.create(s),
         -- add folders widgets
         {
            separator,
            folder.create(home_dir),
            folder.create(home_dir .. "/Documents"),
            folder.create(home_dir .. "/Downloads"),
            separator,
            folder.create(home_dir .. "/.local/share/Trash/files"),
            layout = wibox.layout.fixed.vertical,
         }
      },
      nil
   }

   return panel
end

return left_panel
