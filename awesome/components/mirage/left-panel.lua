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
local dpi = beautiful.xresources.apply_dpi
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
      height = s.geometry.height,
      width = beautiful.left_panel_width,
      ontop = true,
      bg = "#00000000",
      shape = function(cr, width, height)
         gears.shape.partially_rounded_rect(cr, width, height, false, true, true, false, 36)
      end
   })

   panel:setup {
      expand = "none",
      layout = wibox.layout.align.vertical,
      require("widgets.layout-box"),
      {
         layout = wibox.layout.fixed.vertical,
         tag_list.create(s)
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

  
   -- ===================================================================
   -- Functionality
   -- ===================================================================


   -- hide panel when client is fullscreen
   client.connect_signal("property::fullscreen",
      function(c)
         panel.visible = not c.fullscreen
      end
   )

   -- panel visual change on rofi spawn
   awesome.connect_signal("launcher_spawn",
      function()
         panel_bg.visible = true
      end
   )

   -- hide blurred part of panel when rofi is closed:
   -- hides whenever any client is closed but since its hidden
   -- unless rofi is open it effectively accomplishes the above
   client.connect_signal("unmanage",
      function()
         panel_bg.visible = false
      end
   )
end

return left_panel
