--      ████████╗ ██████╗ ██████╗     ██████╗  █████╗ ███╗   ██╗███████╗██╗
--      ╚══██╔══╝██╔═══██╗██╔══██╗    ██╔══██╗██╔══██╗████╗  ██║██╔════╝██║
--         ██║   ██║   ██║██████╔╝    ██████╔╝███████║██╔██╗ ██║█████╗  ██║
--         ██║   ██║   ██║██╔═══╝     ██╔═══╝ ██╔══██║██║╚██╗██║██╔══╝  ██║
--         ██║   ╚██████╔╝██║         ██║     ██║  ██║██║ ╚████║███████╗███████╗
--         ╚═╝    ╚═════╝ ╚═╝         ╚═╝     ╚═╝  ╚═╝╚═╝  ╚═══╝╚══════╝╚══════╝

-- ===================================================================
-- Initialization
-- ===================================================================


local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")
local gears = require("gears")
local dpi = require("beautiful").xresources.apply_dpi

-- import widgets
local task_list = require("widgets.task-list")

-- define module table
local top_panel = {}


-- ===================================================================
-- Bar Widget Creation
-- ===================================================================


-- Clock / Calendar 12h format
-- Get Time/Date format using `man strftime`
local textclock = wibox.widget.textclock('<span font="' .. beautiful.title_font ..'">%l:%M %p</span>', 1)

-- Clock / Calendar 12AM/PM fornatan font="Roboto Mono bold 11">%I\n%M</span>\n<span font="Roboto Mono bold 9">%p</span>")
local clock_widget = wibox.container.margin(textclock, dpi(0), dpi(0))

-- Alternative to naughty.notify - tooltip. You can compare both and choose the preferred one
awful.tooltip({
   objects = {clock_widget},
   mode = "outside",
   align = "right",
   timer_function = function()
      return os.date("The date today is %B %d, %Y. And it's fucking %A!")
   end,
   preferred_positions = {"right", "left", "top", "bottom"},
   margin_leftright = dpi(8),
   margin_topbottom = dpi(8)
})

local cal_shape = function(cr, width, height)
   gears.shape.partially_rounded_rect(
      cr, width, height, false, false, true, true, 12)
end

-- Calendar Widget
local month_calendar = awful.widget.calendar_popup.month({
   start_sunday = true,
   spacing = 10,
   font = beautiful.title_font,
   long_weekdays = true,
   margin = 0, -- 10
   style_month = {border_width = 0, padding = 12, shape = cal_shape, padding = 25},
   style_header = {border_width = 0, bg_color = "#00000000"},
   style_weekday = {border_width = 0, bg_color = "#00000000"},
   style_normal = {border_width = 0, bg_color = "#00000000"},
   style_focus = {border_width = 0, bg_color = "#8AB4F8"},
})

-- Attach calentar to clock_widget
month_calendar:attach(clock_widget, "tc" , { on_pressed = true, on_hover = false })


-- ===================================================================
-- Bar Creation
-- ===================================================================


top_panel.create = function(s)
   local panel = awful.wibar({
      screen = s,
      position = "top",
      height = dpi(26),
      width = s.geometry.width,
   })

   panel:setup {
      expand = "none",
      layout = wibox.layout.align.horizontal,
      {
         layout = wibox.layout.fixed.horizontal,
         task_list.create(s),
      },
         clock_widget,
      {
         layout = wibox.layout.fixed.horizontal,
         wibox.layout.margin(wibox.widget.systray(), 0, 0, 3, 3),
         require("widgets.bluetooth"),
         require("widgets.wifi"),
         require("widgets.battery"),
         require("widgets.layout-box")
      }
   }

   return panel
end

return top_panel
