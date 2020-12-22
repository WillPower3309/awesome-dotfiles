--      ███╗   ███╗██╗██████╗  █████╗  ██████╗ ███████╗
--      ████╗ ████║██║██╔══██╗██╔══██╗██╔════╝ ██╔════╝
--      ██╔████╔██║██║██████╔╝███████║██║  ███╗█████╗
--      ██║╚██╔╝██║██║██╔══██╗██╔══██║██║   ██║██╔══╝
--      ██║ ╚═╝ ██║██║██║  ██║██║  ██║╚██████╔╝███████╗
--      ╚═╝     ╚═╝╚═╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝

-- ===================================================================
-- Initialization
-- ===================================================================


local awful = require("awful")
local gears = require("gears")

local mirage = {}


-- ===================================================================
-- Mirage setup
-- ===================================================================


mirage.initialize = function()
   -- Set Wallpaper
   gears.wallpaper.maximized(gears.filesystem.get_configuration_dir() .. "/wallpaper/mirage.png")

   -- Import components
   require("components.exit-screen")
   require("components.volume-adjust")
   require("components.mirage.titlebar")

   -- Import panels
   local left_panel = require("components.mirage.left-panel")
   local top_panel = require("components.mirage.top-panel")

   local icon_dir = gears.filesystem.get_configuration_dir() .. "/icons/tags/mirage/"
   -- Set up each screen (add tags & panels)
   awful.screen.connect_for_each_screen(function(s)
      for i = 1, 7, 1
      do
         awful.tag.add(i, {
            icon = icon_dir .. i .. ".png",
            icon_only = true,
            layout = awful.layout.suit.tile,
            screen = s,
            selected = i == 1
         })
      end

      -- Only add the left panel on the primary screen
      if s.index == 1 then
         left_panel.create(s)
      end

      -- Add the top panel to every screen
      top_panel.create(s)
   end)

   -- set initally selected tag to be active
   local initial_tag = awful.screen.focused().selected_tag
   awful.tag.seticon(icon_dir .. initial_tag.name .. ".png", initial_tag)

   -- updates tag icons
   local function update_tag_icons()
      -- get a list of all tags
      local atags = awful.screen.focused().tags

      -- update each tag icon
      for i, t in ipairs(atags) do
         -- don't update active tag icon
         if t == awful.screen.focused().selected_tag then
            goto continue
         end
         -- if the tag has clients use busy icon
         for _ in pairs(t:clients()) do
            awful.tag.seticon(icon_dir .. t.name .. "-busy.png", t)
            goto continue
         end
         -- if the tag has no clients use regular inactive icon
         awful.tag.seticon(icon_dir .. t.name .. "-inactive.png", t)

         ::continue::
      end
   end

   -- Update tag icons when tag is switched
   tag.connect_signal("property::selected", function(t)
      -- set newly selected tag icon as active
      awful.tag.seticon(icon_dir .. t.name .. ".png", t)
      update_tag_icons()
   end)
   -- Update tag icons when a client is moved to a new tag
   tag.connect_signal("tagged", function(c)
      update_tag_icons()
   end)
end

return mirage
