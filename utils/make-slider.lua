return function(level, slider, status)
	return wibox.widget {
		{
			{
				level,
	
				margins = { top = dpi(12), bottom = dpi(12) },
				widget  = wibox.container.margin
			},
	
			{
				slider,

				widget  = wibox.container.margin,
				margins = { left = dpi(24), right = dpi(24) }
			},
		
			status,
	
			layout  = wibox.layout.align.horizontal
		},
	
		widget        = wibox.container.margin,
		forced_height = dpi(48),
		margins       = { left = dpi(24), right = dpi(24) }
	}
end