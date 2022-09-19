local profile          = require('layout.left-panel.dashboard.profile')
local session          = require('layout.left-panel.dashboard.session')
local display_control  = require('widget.settings.display-control')
local sound_control    = require('widget.settings.sound-control')
local hardware_monitor = require('layout.left-panel.dashboard.hardware-monitor')

local author = wibox.widget {
	{
		markup        = '<span color= "' .. beautiful.fg_normal .. '">Made with <span color= "#E25822"></span> in heart by SD Asif Hossein</span>',
		font          = default_font .. 'Regular 10',
		forced_height = dpi(30),
		align         = 'center',
		valign        = 'center',
		widget        = wibox.widget.textbox
	},

	bg     = '#000',
	widget = wibox.container.background
}

return function()
	return wibox.widget {
		{
			{
				{
					profile,
					nil,
					session,

					widget = wibox.layout.align.horizontal
				},

				widget  = wibox.container.margin,
				margins = dpi(15),
			},

			{
				display_control,

				widget  = wibox.container.margin,
				margins = dpi(15)
			},

			{
				sound_control,

				widget = wibox.container.margin,
				margins = dpi(15)
			},

			{
				hardware_monitor,

				widget = wibox.container.margin,
				margins = dpi(15)
			},

			layout = wibox.layout.fixed.vertical
		},

		nil,
		author,

		layout = wibox.layout.align.vertical
	}
end