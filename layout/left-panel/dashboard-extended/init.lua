local hw_monitor = require('layout.left-panel.dashboard-extended.hardware-monitor')

return function()
	return wibox.widget {
		{
			hw_monitor,

			widget = wibox.container.margin,
			margins = { top = dpi(20), bottom = dpi(20), right = dpi(20) }
		},

		layout = wibox.layout.fixed.vertical
	}
end