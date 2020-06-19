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
   panel = awful.wibar({
      screen = s,
      position = "left",
      height = s.geometry.height * 7/10,
      width = beautiful.left_panel_width,
      ontop = true,
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

   -- panel background that becomes visible when client is maximized
   panel_bg = wibox({
      screen = s,
      position = "left",
      height = s.geometry.height,
      width = beautiful.left_panel_width,
      visible = false
   })

   -- hide panel when client is fullscreen
   client.connect_signal('property::fullscreen',
      function(c)
         panel.visible = not c.fullscreen
      end
   )

   -- maximize panel if client is maximized
   local function toggle_maximize_left_panel(is_maximized)
      panel_bg.visible = is_maximized

      if is_maximized then
         panel.shape = function(cr, width, height)
            gears.shape.rectangle(cr, width, height)
         end
      else
         panel.shape = function(cr, width, height)
            gears.shape.partially_rounded_rect(cr, width, height, false, true, true, false, 12)
         end
      end
   end

   client.connect_signal('property::maximized',
      function(c)
         if c.first_tag then
            toggle_maximize_left_panel(c.maximized)
         end
      end
   )

   client.connect_signal('unmanage',
      function(c)
         if c.maximized then
            toggle_maximize_left_panel(false)
         end
      end
   )

   tag.connect_signal('property::layout',
      function(t)
         local current_layout = awful.tag.getproperty(t, 'layout')
         if (current_layout == awful.layout.suit.max) then
            toggle_maximize_left_panel(true)
         else
            toggle_maximize_left_panel(false)
         end
      end
   )
end

return left_panel
