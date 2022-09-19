local clickable_widget = require('widget.style.clickable-widget')
local apps             = require('config.user.apps')
local helpers          = require('layout.helpers')

-- Lockscreen.

local lock_button = wibox.widget {
	{
		{
			widget = wibox.widget.textbox,
			markup = helpers.colorize_text('', '#777777'),
			font   = default_font .. '14',
			align  = 'center',
			valign = 'center'
		},

		widget        = clickable_widget,
		forced_width  = dpi(35),
		forced_height = dpi(35)
	},
	
	bg     = '#fff',
	shape  = gears.shape.circle,
	widget = wibox.container.background
}

local lock_button_tool_tip = awful.tooltip {
	mode       = 'inside',
	align      = 'right',
	text       = 'Lock the screen',
	delay_show = 0.5
}

lock_button_tool_tip:add_to_object(lock_button)

-- Exitscreen.

local power_button = wibox.widget {
	{
		{
			widget = wibox.widget.textbox,
			markup = helpers.colorize_text('襤', '#777777'),
			font   = default_font .. '14',
			align  = 'center',
			valign = 'center',
		},

		widget        = clickable_widget,
		forced_width  = dpi(35),
		forced_height = dpi(35)
	},
	
	bg     = '#fff',
	shape  = gears.shape.circle,
	widget = wibox.container.background
}

local power_button_tool_tip = awful.tooltip {
	mode       = 'inside',
	align      = 'right',
	text       = 'Show exit screen',
	delay_show = 0.5
}

power_button_tool_tip:add_to_object(power_button)

-- Button functionality.

power_button:buttons(gears.table.join(
    awful.button({}, 1, function()
        naughty.notification { message = 'not implemented' }
    end)
))

lock_button:buttons(gears.table.join(
    awful.button({}, 1, function()
        awful.spawn(apps.lock, true)
    end)
))

return wibox.widget {
    nil,

    {
        {
            lock_button,
			power_button,

            layout = wibox.layout.fixed.horizontal,
            spacing = dpi(10)
        },

        layout = wibox.layout.fixed.vertical
    },

    layout = wibox.layout.align.vertical,
    expand = 'none'
}
