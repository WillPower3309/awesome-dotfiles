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

local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()

local theme = {}


-- ===================================================================
-- Theme Variables
-- ===================================================================


theme.font          = "SF Pro Text 8"
theme.title_font    = "SF Pro Display 10"

theme.bg_normal     = "#000000" .. "66"
theme.bg_focus      = "#5a5a5a"
theme.bg_urgent     = "#3f3f3f"
theme.bg_minimize   = "#444444"
theme.bg_systray    = theme.bg_normal

theme.fg_normal     = "#ffffffde"
theme.fg_focus      = "#e4e4e4"
theme.fg_urgent     = "#cc9393"
theme.fg_minimize   = "#ffffff"

theme.useless_gap           = dpi(7)            -- window gap distance
theme.gap_single_client     = true              -- gaps if only one window is open?
theme.border_width          = dpi(0)            -- window border width
theme.rounded_corner_radius = dpi(6)            -- border radius of rounded theme elements
theme.border_normal         = theme.bg_normal
theme.border_focus          = "#ff8a65"
theme.border_marked         = theme.fg_urgent

-- Generate taglist squares: -- TODO: EDIT ME TO REMOVE TAGLIST SQUARES!
local taglist_square_size = dpi(4)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
    taglist_square_size, theme.fg_normal
)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
    taglist_square_size, theme.fg_normal
)

-- Menu Variables:
theme.menu_submenu_icon = themes_path.."default/submenu.png"
theme.menu_height = dpi(15)
theme.menu_width  = dpi(100)

-- Notification Variables:
theme.notification_max_width = dpi(500)
theme.notification_margin = dpi(5)
theme.notification_padding = dpi(8)


-- ===================================================================
-- Icons
-- ===================================================================


-- You can use your own layout icons like this:
theme.layout_tile = "~/.config/awesome/icons/layouts/view-quilt.png"
theme.layout_floating  = themes_path.."default/layouts/floatingw.png" -- TODO: GET BETTER ICON
theme.layout_max = "~/.config/awesome/icons/layouts/arrow-expand-all.png"

return theme
