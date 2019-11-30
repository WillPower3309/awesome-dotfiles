--      ████████╗██╗  ██╗███████╗███╗   ███╗███████╗    
--       ══██╔══╝██║  ██║██╔════╝████╗ ████║██╔════╝    
--         ██║   ███████║█████╗  ██╔████╔██║█████╗      
--         ██║   ██╔══██║██╔══╝  ██║╚██╔╝██║██╔══╝      
--         ██║   ██║  ██║███████╗██║ ╚═╝ ██║███████╗    
--         ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝     ╚═╝╚══════╝    

-- ===================================================================
-- Imports
-- ===================================================================


local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local theme = {}


-- ===================================================================
-- Theme Variables
-- ===================================================================


-- Font
theme.font          = "SF Pro Text 9"
theme.title_font    = "SF Pro Display 10"

-- Background
theme.bg_normal     = "#00000066"
theme.bg_dark       = "000000099"
theme.bg_focus      = "#5a5a5a"
theme.bg_urgent     = "#3f3f3f"
theme.bg_minimize   = "#444444"
theme.bg_systray    = theme.bg_normal

-- Foreground
theme.fg_normal     = "#ffffffde"
theme.fg_focus      = "#e4e4e4"
theme.fg_urgent     = "#cc9393"
theme.fg_minimize   = "#ffffff"

-- Sizing
theme.useless_gap           = dpi(7)            -- window gap distance
theme.gap_single_client     = true              -- gaps if only one window is open?
theme.border_width          = dpi(0)            -- window border width
theme.rounded_corner_radius = dpi(6)            -- border radius of rounded theme elements
theme.border_normal         = theme.bg_normal
theme.border_focus          = "#ff8a65"
theme.border_marked         = theme.fg_urgent

-- Taglist
theme.taglist_bg_empty = theme.bg_dark
theme.taglist_bg_occupied = '#ffffff1A'
theme.taglist_bg_urgent = '#E91E6399'
theme.taglist_bg_focus = theme.bg_normal

-- Tasklist
theme.tasklist_font = theme.font
theme.tasklist_bg_normal = theme.bg_dark
theme.tasklist_bg_focus =
  'linear:0,0:0,' ..
  dpi(48) ..
    ':0,' ..
      theme.bg_normal ..
        ':0.95,' .. theme.bg_normal .. ':0.95,' .. theme.fg_normal .. ':1,' .. theme.fg_normal
theme.tasklist_bg_urgent = theme.bg_normal
theme.tasklist_fg_focus = '#DDDDDD'
theme.tasklist_fg_urgent = theme.fg_normal
theme.tasklist_fg_normal = '#AAAAAA'

-- Notifications
theme.notification_max_width = dpi(500)
theme.notification_margin = dpi(20)
theme.notification_padding = dpi(8)


-- ===================================================================
-- Icons
-- ===================================================================


-- You can use your own layout icons like this:
theme.layout_tile = "~/.config/awesome/icons/layouts/view-quilt.png"
theme.layout_floating = "~/.config/awesome/icons/layouts/" -- TODO: ADD FLOATING ICON
theme.layout_max = "~/.config/awesome/icons/layouts/arrow-expand-all.png"

theme.icon_theme = "McMojave-circle-blue-dark"


-- return theme
return theme
