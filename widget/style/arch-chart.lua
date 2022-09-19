return function()
	return wibox.widget {
		max_value    = 100,
		value        = 1,
		start_angle  = -math.pi / 2,
		thickness    = dpi(2),
		rounded_edge = true,
		bg           = '#FFFFFF15',
		paddings     = dpi(10),
		color        = { '#FF0000AA' },
		widget       = wibox.container.arcchart
	}
end