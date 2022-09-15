local id      = require('config.user.id')
local helpers = require('layout.helpers')

-- The profile picture.

local profile_image = wibox.widget {
    {
        image      = config_dir .. 'layout/left-panel/dashboard/profile/assets/' .. 'profile.jpg',
        clip_shape = gears.shape.circle,
        widget     = wibox.widget.imagebox
    },

    widget        = wibox.container.background,
    border_width  = dpi(1),
    forced_width  = dpi(75),
    forced_height = dpi(75),
    shape         = gears.shape.circle,
    border_color  = beautiful.fg_normal
}

-- User fullname widget.

local fullname = wibox.widget {
    widget = wibox.widget.textbox,
    markup = helpers.colorize_text(id.fullname, beautiful.fg_normal),
    font   = default_font .. 'Medium 13',
    align  = 'left',
    valign = 'center'
}

-- Username.

local username = wibox.widget {
    widget = wibox.widget.textbox,
    markup = helpers.colorize_text('@' .. id.username, beautiful.fg_normal),
    font   = default_font .. 'Light 11',
    align  = 'left',
    valign = 'center'
}

return wibox.widget{
    profile_image,

    {
        nil,

        {
            fullname,
            username,

            layout  = wibox.layout.fixed.vertical,
            spacing = dpi(2)
        },

        layout = wibox.layout.align.vertical,
        expand = 'none'
    },

    layout  = wibox.layout.fixed.horizontal,
    spacing = dpi(15)
}