--      ██████╗ ██╗   ██╗██╗     ███████╗███████╗
--      ██╔══██╗██║   ██║██║     ██╔════╝██╔════╝
--      ██████╔╝██║   ██║██║     █████╗  ███████╗
--      ██╔══██╗██║   ██║██║     ██╔══╝  ╚════██║
--      ██║  ██║╚██████╔╝███████╗███████╗███████║
--      ╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚══════╝╚══════╝

-- ===================================================================
-- Imports
-- ===================================================================


local awful = require('awful')
local beautiful = require("beautiful")
local keys = require("keys")

local screen_height = awful.screen.focused().geometry.height
local screen_width = awful.screen.focused().geometry.width


-- ===================================================================
-- Rules
-- ===================================================================


rules = {
    -- All clients will match this rule.
    {
      rule = {},
      properties = {
        border_width = beautiful.border_width,
        border_color = beautiful.border_normal,
        focus = awful.client.focus.filter,
        raise = true,
        keys = keys.clientkeys,
        buttons = keys.clientbuttons,
        screen = awful.screen.preferred,
        placement = awful.placement.centered
      }
    },

    -- Floating clients.
    { 
      rule_any = {
        instance = {
          "DTA",
          "copyq",
        },
        class = {
          "Nm-connection-editor"
        },
        name = {
          "Event Tester",
          "Steam Guard - Computer Authorization Required"
        },
        role = {
          "pop-up",
          "GtkFileChooserDialog"
        },
        type = {
          "dialog"
        }
      }, properties = { floating = true }
    },

    -- Fullscreen clients
    {
      rule_any = {
        class = {
          "Terraria.bin.x86",
        },
      }, properties = { fullscreen = true }
    },

    -- Centered clients
    {
      rule_any = {
        class = {
          "Steam",
          "discord",
          "Nm-connection-editor",
          "Pavucontrol"
        },
        name = {
          "Bluetooth Devices"
        },
        role = {
          "GtkFileChooserDialog"
        },
        type = {
          "dialog",
        }
      },
      properties = {},
      callback = function (c)
        awful.placement.centered(c,{honor_padding = true, honor_workarea=true})
      end
    },

    -- "Switch to tag"
    -- These clients make you switch to their tag when they appear
    {
      rule_any = {
        class = {
          "Firefox"
        },
      }, properties = { switchtotag = true }
    },

    -- Visualizer
    {
      rule_any = { name = { "cava" } },
      properties = {
        floating = true,
        maximized_horizontal = true,
        sticky = true,
        ontop = false,
        skip_taskbar = true,
        below = true,
        focusable = false,
        height = screen_height * 0.40,
        opacity = 0.6
      },
      callback = function (c)
        decorations.hide(c)
        awful.placement.bottom(c)
      end
    },

    -- Rofi
    {
      rule_any = { name = { "rofi" } },
      properties = { maximized = true, ontop = true }
    },

    -- File chooser dialog
    {
      rule_any = { role = { "GtkFileChooserDialog" } },
      properties = { floating = true, width = screen_width * 0.55, height = screen_height * 0.65 }
    },

    -- Pavucontrol & Bluetooth Devices
    {
      rule_any = { class = { "Pavucontrol" }, name = { "Bluetooth Devices" } },
      properties = { floating = true, width = screen_width * 0.55, height = screen_height * 0.45 }
    },
}

return rules
