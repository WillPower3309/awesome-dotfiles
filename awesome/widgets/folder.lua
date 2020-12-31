--      ███████╗ ██████╗ ██╗     ██████╗ ███████╗██████╗
--      ██╔════╝██╔═══██╗██║     ██╔══██╗██╔════╝██╔══██╗
--      █████╗  ██║   ██║██║     ██║  ██║█████╗  ██████╔╝
--      ██╔══╝  ██║   ██║██║     ██║  ██║██╔══╝  ██╔══██╗
--      ██║     ╚██████╔╝███████╗██████╔╝███████╗██║  ██║
--      ╚═╝      ╚═════╝ ╚══════╝╚═════╝ ╚══════╝╚═╝  ╚═╝

-- ===================================================================
-- Initialization
-- ===================================================================


local awful = require("awful")
local wibox = require("wibox")
local clickable_container = require("widgets.clickable-container")
local gears = require("gears")
local dpi = require("beautiful").xresources.apply_dpi

local HOME_DIR = os.getenv("HOME")
local PATH_TO_ICONS = HOME_DIR .. "/.config/awesome/icons/folders/"

-- define module table
local folder = {}


-- ===================================================================
-- Helper Functions
-- ===================================================================


-- split a string into a list based on a deliminator
local function split_string(inputstr, delim)
   if delim == nil then
      delim = "%s"
   end
   local t={}
   for str in string.gmatch(inputstr, "([^"..delim.."]+)") do
      table.insert(t, str)
   end
   return t
end


-- ===================================================================
-- Functionality
-- ===================================================================


function folder.create(directory)
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
               awful.spawn.easy_async_with_shell(apps.filebrowser .. " " .. directory, function(stderr) end, 1)
            end
         )
      )
   )

   -- determine hover name & icon to use
   -- icon name must correspond with name of folder
   local folder_name = ""
   if directory == HOME_DIR then
      folder_name = "Home"
   elseif directory == "trash://" then
      folder_name = "Trash"
   else
      local dir_list = split_string(directory, "/")
      folder_name = dir_list[#dir_list]
   end

   awful.tooltip({
      objects = {docu_button},
      mode = "outside",
      align = "right",
      timer_function = function()
         return folder_name
      end,
      preferred_positions = {"right", "left", "top", "bottom"}
   })

   docu_widget.icon:set_image(PATH_TO_ICONS .. folder_name:lower() .. ".png")
   return docu_button
end

return folder
