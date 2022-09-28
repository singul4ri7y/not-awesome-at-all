local hw_monitor   = require('layout.left-panel.dashboard-extended.hardware-monitor')
local media_player = require('layout.left-panel.dashboard-extended.media-player')

return function()
	return wibox.widget {
		{
			hw_monitor,
			media_player,

			layout  = wibox.layout.fixed.vertical,
			spacing = dpi(20)
		},

		widget  = wibox.container.margin,
		margins = { top = dpi(20), bottom = dpi(20), left = dpi(10), right = dpi(20) }
	}
end