local profile         = require('layout.left-panel.dashboard.profile')
local session         = require('layout.left-panel.dashboard.session')
local display_control = require('widget.settings.display-control')
local sound_control   = require('widget.settings.sound-control')
local misc_control    = require('widget.settings.misc-control')

local author = wibox.widget {
	markup        = '<span color= "' .. beautiful.fg_normal .. '">Made with <span color= "#E25822"></span> in heart by SD Asif Hossein</span>',
	font          = default_font .. 'Regular 10',
	forced_height = dpi(30),
	align         = 'center',
	valign        = 'center',
	widget        = wibox.widget.textbox
}

return function(scr)
	return {
		{
			id = 'dashboard_margin',
			
			{
				{
					{
						{
							profile,
							nil,
							session,

							widget = wibox.layout.align.horizontal
						},

						widget  = wibox.container.margin,
						margins = dpi(12)
					},

					widget = wibox.container.background,
					shape  = gears.shape.rounded_rect,
					bg     = beautiful.groups_bg
				},

				display_control,
				sound_control,
				misc_control,

				layout  = wibox.layout.fixed.vertical,
				spacing = dpi(20)
			},

			layout = wibox.container.margin,
			margins = dpi(20),
			right   = dpi(20)
		},

		nil,
		author,

		screen = scr,
		layout = wibox.layout.align.vertical
	}
end