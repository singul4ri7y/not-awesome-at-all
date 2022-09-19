---------------------------
-- Default awesome theme --
---------------------------

local theme_assets = require('beautiful.theme_assets')
local xresources = require('beautiful.xresources')
local rnotification = require('ruled.notification')
local dpi = xresources.apply_dpi

local gfs = require('gears.filesystem')
local themes_path = gfs.get_themes_dir()
local theme_dir = gears.filesystem.get_configuration_dir() .. 'theme/'

local theme = {}

theme.font          = 'Ubuntu NF Medium 10'

theme.bg_normal   = '#222222'
theme.bg_focus    = '#535d6c'
theme.bg_urgent   = '#ff0000'
theme.bg_minimize = '#444444'
theme.bg_systray  = theme.bg_normal

theme.groups_bg       = '#FFFFFF' .. '10'
theme.groups_title_bg = '#ffffff' .. '15'

theme.color_white = '#FFFFFF' .. 'FF'

theme.transparent = theme.bg_normal .. '00'

theme.fg_normal   = '#FFFFFFCD'
theme.fg_focus    = '#E4E4E4'
theme.fg_urgent   = '#CC9393'

theme.useless_gap         = dpi(4)
theme.no_gap              = dpi(0)
theme.border_width        = dpi(1)
theme.border_color_normal = '#000000'
theme.border_color_active = '#535d6c'
theme.border_color_marked = '#91231c'

theme.widget_enter   = '#FFFFFF' .. '15'
theme.widget_press   = '#FFFFFF' .. '25'
theme.widget_leave   = theme.transparent
theme.widget_release = '#FFFFFF' .. '15'

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
-- Example:
--theme.taglist_bg_focus = '#ff0000'

-- Generate taglist squares:
local taglist_square_size = dpi(4)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
    taglist_square_size, theme.fg_normal
)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
    taglist_square_size, theme.fg_normal
)

-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = themes_path..'default/submenu.png'
theme.menu_height = dpi(15)
theme.menu_width  = dpi(100)

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = '#cc0000'

theme.wallpaper = theme_dir .. 'wallpapers/assets/silhouette-of-trees.jpg'

-- You can use your own layout icons like this:
theme.layout_floating  = theme_dir .. 'icons/assets/layouts/floating.png'
theme.layout_max = themes_path..'default/layouts/maxw.png'
theme.layout_fullscreen = themes_path..'default/layouts/fullscreenw.png'
theme.layout_spiral  = theme_dir .. 'icons/assets/layouts/spiral.png'

theme.tasklist_plain_task_name = true

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
    theme.menu_height, theme.bg_focus, theme.fg_focus
)

-- Systray.

theme.systray_icon_spacing = dpi(2)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = 'Tela-blue-dark'

-- Set different colors for urgent notifications.
rnotification.connect_signal('request::rules', function()
    rnotification.append_rule {
        rule       = { urgency = 'critical' },
        properties = { bg = '#ff0000', fg = '#ffffff' }
    }
end)

return theme