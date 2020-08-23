--      ███╗   ██╗ ██████╗ ████████╗██╗███████╗██╗ ██████╗ █████╗ ████████╗██╗ ██████╗ ███╗   ██╗███████╗
--      ████╗  ██║██╔═══██╗╚══██╔══╝██║██╔════╝██║██╔════╝██╔══██╗╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝
--      ██╔██╗ ██║██║   ██║   ██║   ██║█████╗  ██║██║     ███████║   ██║   ██║██║   ██║██╔██╗ ██║███████╗
--      ██║╚██╗██║██║   ██║   ██║   ██║██╔══╝  ██║██║     ██╔══██║   ██║   ██║██║   ██║██║╚██╗██║╚════██║
--      ██║ ╚████║╚██████╔╝   ██║   ██║██║     ██║╚██████╗██║  ██║   ██║   ██║╚██████╔╝██║ ╚████║███████║
--      ╚═╝  ╚═══╝ ╚═════╝    ╚═╝   ╚═╝╚═╝     ╚═╝ ╚═════╝╚═╝  ╚═╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝

-- ===================================================================
-- Imports
-- ===================================================================


local naughty = require("naughty")
local beautiful = require("beautiful")
local gears = require("gears")
local wibox = require("wibox")
local awful = require("awful")
local dpi = beautiful.xresources.apply_dpi


-- ===================================================================
-- Theme Definitions
-- ===================================================================


naughty.config.defaults.ontop = true
naughty.config.defaults.icon_size = dpi(32)
naughty.config.defaults.screen = awful.screen.focused()
naughty.config.defaults.timeout = 3
naughty.config.defaults.title = "System Notification"
naughty.config.defaults.margin = dpi(16)
naughty.config.defaults.border_width = 0
naughty.config.defaults.position = "top_right"
naughty.config.defaults.shape = function(cr, w, h)
   gears.shape.rounded_rect(cr, w, h, dpi(6))
end

naughty.config.padding = dpi(7)
naughty.config.spacing = dpi(7)
naughty.config.icon_dirs = {
   "/usr/share/icons/Tela-dark",
   "/usr/share/pixmaps/"
}
naughty.config.icon_formats = {"png", "svg"}

-- Timeouts
naughty.config.presets.low.timeout = 3
naughty.config.presets.critical.timeout = 0

naughty.config.presets.normal = {
   font = beautiful.title_font,
   fg = beautiful.fg_normal,
   bg = beautiful.bg_normal,
   position = "top_right"
}

naughty.config.presets.low = {
   font = beautiful.title_font,
   fg = beautiful.fg_normal,
   bg = beautiful.bg_normal,
   position = "top_right"
}

naughty.config.presets.critical = {
   font = "SF Display Bold 10",
   fg = "#ffffff",
   bg = "#ff0000",
   position = "top_right",
   timeout = 0
}

naughty.config.presets.ok = naughty.config.presets.normal
naughty.config.presets.info = naughty.config.presets.normal
naughty.config.presets.warn = naughty.config.presets.critical


-- ===================================================================
-- Error Handling
-- ===================================================================


if awesome.startup_errors then
   naughty.notify({
      preset = naughty.config.presets.critical,
      title = "Oops, there were errors during startup!",
      text = awesome.startup_errors
   })
end

do
   local in_error = false
   awesome.connect_signal(
      "debug::error",
      function(err)
         if in_error then
            return
         end
         in_error = true

         naughty.notify({
            preset = naughty.config.presets.critical,
            title = "Oops, an error happened!",
            text = tostring(err)
         })
         in_error = false
      end
   )
end
