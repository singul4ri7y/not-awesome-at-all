local profile         = require('layout.left-panel.dashboard.profile')
local session         = require('layout.left-panel.dashboard.session')
local display_control = require('widget.settings.display-control')
local sound_control   = require('widget.settings.sound-control')

return function()
	return wibox.widget {
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

		layout = wibox.layout.fixed.vertical
	}
end