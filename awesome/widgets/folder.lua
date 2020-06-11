local awful = require("awful")
local wibox = require("wibox")
local clickable_container = require("widgets.clickable-container")
local gears = require("gears")
local dpi = require("beautiful").xresources.apply_dpi

local filebrowser = require("apps").default.filebrowser

local PATH_TO_ICONS = os.getenv("HOME") .. "/.config/awesome/icons/folders/"

-- define module table
local folder = {}


function folder.create(location)
   local docu_widget = wibox.widget {
      {
         id = "icon",
         widget = wibox.widget.imagebox,
         resize = true
      },
      layout = wibox.layout.align.horizontal
   }

   local docu_button = clickable_container(wibox.container.margin(docu_widget, dpi(8), dpi(8), dpi(8), dpi(8)))
   docu_button:buttons(
      gears.table.join(
         awful.button({}, 1, nil,
            function()
               if location ~= 'Home' and location ~='Trash' then
                  awful.spawn.easy_async_with_shell(filebrowser .. " $HOME/" .. location, function(stderr) end, 1)
               elseif location == 'Home' then
                  awful.spawn.easy_async_with_shell(filebrowser .. " $HOME", function(stderr) end, 1)
               else
                  awful.spawn.easy_async_with_shell(filebrowser .. " trash://", function(stderr) end, 1)
               end
            end
         )
      )
   )

   awful.tooltip(
      {
         objects = {docu_button},
         mode = "outside",
         align = "right",
         timer_function = function()
            return location
         end,
         preferred_positions = {"right", "left", "top", "bottom"}
      }
   )

   docu_widget.icon:set_image(PATH_TO_ICONS .. location:lower() .. ".png")
   return docu_button
end

return folder
