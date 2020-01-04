--      ██████╗ ██████╗ ██╗ ██████╗ ██╗  ██╗████████╗███╗   ██╗███████╗███████╗███████╗
--      ██╔══██╗██╔══██╗██║██╔════╝ ██║  ██║╚══██╔══╝████╗  ██║██╔════╝██╔════╝██╔════╝
--      ██████╔╝██████╔╝██║██║  ███╗███████║   ██║   ██╔██╗ ██║█████╗  ███████╗███████╗
--      ██╔══██╗██╔══██╗██║██║   ██║██╔══██║   ██║   ██║╚██╗██║██╔══╝  ╚════██║╚════██║
--      ██████╔╝██║  ██║██║╚██████╔╝██║  ██║   ██║   ██║ ╚████║███████╗███████║███████║
--      ╚═════╝ ╚═╝  ╚═╝╚═╝ ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═══╝╚══════╝╚══════╝╚══════╝


-- ===================================================================
-- Imports
-- ===================================================================


local gears = require("gears")
local wibox = require("wibox")
local beautiful = require('beautiful')
local dpi = require('beautiful').xresources.apply_dpi
local bri_osd = require('widgets.brightness-slider-osd')


-- ===================================================================
-- Add Brightness Overlay to Each Screen
-- ===================================================================


screen.connect_signal("request::desktop_decoration", function(s)
  -- Create the box
  local offsetx = dpi(56)
  local offsety = dpi(300)
  brightnessOverlay = wibox
  {
    visible = nil,
    ontop = true,
    screen = s,
    type = "normal",
    height = offsety,
    width = dpi(48),
    bg = "#00000000",
    x = s.geometry.width - offsetx,
    y = (s.geometry.height / 2) - (offsety / 2),
  }

  -- Put its items in a shaped container
  brightnessOverlay:setup {
    -- Container
    {
      wibox.container.rotate(bri_osd,'east'),
      layout = wibox.layout.fixed.vertical
    },
    -- The real background color & shape
    bg = beautiful.bg_normal,
    shape = gears.shape.rounded_rect,
    widget = wibox.container.background()
  }

  local hideOSD = gears.timer {
    timeout = 5,
    autostart = true,
    callback  = function()
      brightnessOverlay.visible = false
    end
  }

  function toggleBriOSD(bool)
    brightnessOverlay.visible = bool
    if bool then
      hideOSD:again()
      if toggleVolOSD ~= nil then
        toggleVolOSD(false)
      end
    else
      hideOSD:stop()
    end
  end
end)