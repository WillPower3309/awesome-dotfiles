--      ██╗     ███████╗███████╗████████╗    ██████╗  █████╗ ███╗   ██╗███████╗██╗
--      ██║     ██╔════╝██╔════╝╚══██╔══╝    ██╔══██╗██╔══██╗████╗  ██║██╔════╝██║
--      ██║     █████╗  █████╗     ██║       ██████╔╝███████║██╔██╗ ██║█████╗  ██║
--      ██║     ██╔══╝  ██╔══╝     ██║       ██╔═══╝ ██╔══██║██║╚██╗██║██╔══╝  ██║
--      ███████╗███████╗██║        ██║       ██║     ██║  ██║██║ ╚████║███████╗███████╗
--      ╚══════╝╚══════╝╚═╝        ╚═╝       ╚═╝     ╚═╝  ╚═╝╚═╝  ╚═══╝╚══════╝╚══════╝

-- ===================================================================
-- Imports
-- ===================================================================


local beautiful = require('beautiful')
local wibox = require('wibox')
local dpi = require('beautiful').xresources.apply_dpi
local awful = require('awful')
local gears = require('gears')

local TagList = require('widgets.tag-list')


-- ===================================================================
-- Bar Creation
-- ===================================================================


local LeftPanel = function(s)
  local left_panel = awful.wibar({
    position = "left",
    screen = s,
    width = dpi(55),
    height = s.geometry.height * 7/10,
    shape = function(cr, width, height)
      gears.shape.partially_rounded_rect(cr, width, height, false, true, true, false, 12)
    end
  })

  left_panel:setup {
    expand = "none",
    layout = wibox.layout.align.vertical,
    nil,
    {
      layout = wibox.layout.fixed.vertical,
      -- add taglist widget
      TagList(s),
      -- add folders widget
      require("widgets.xdg-folders"),
    },
    nil
  }

  local function maximizeLeftPanel(bool)
    if bool then
      left_panel.height = s.geometry.height - dpi(26)
      left_panel.y = dpi(26)
      left_panel.shape = function(cr, width, height)
        gears.shape.rectangle(cr, width, height)
      end
    else
      left_panel.height = s.geometry.height * 7/10
      left_panel.shape = function(cr, width, height)
        gears.shape.partially_rounded_rect(cr, width, height, false, true, true, false, 12)
      end
    end
  end
  return left_panel
end

return LeftPanel
