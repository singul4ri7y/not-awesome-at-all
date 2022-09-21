return function(control_title, widget, tooltip) 
	local widget_r = wibox.widget {
		layout  = wibox.layout.fixed.vertical,
		spacing = dpi(7),
	
		{
			layout = wibox.layout.fixed.vertical,
	
			{
				{
					control_title,
					left   = dpi(24),
					right  = dpi(24),
					widget = wibox.container.margin
				},
	
				forced_height = dpi(35),
				bg            = beautiful.groups_title_bg,
				widget        = wibox.container.background,
				shape         = function(cr, width, height)
					gears.shape.partially_rounded_rect(cr, width, height, true, true, false, false, beautiful.groups_radius) 
				end
			},
			
			{
				layout  = wibox.layout.fixed.vertical,
				spacing = dpi(7),
	
				{
					{
						layout = wibox.layout.fixed.vertical,
	
						widget
					},
	
					bg     = beautiful.groups_bg,
					widget = wibox.container.background,
					shape  = function(cr, width, height)
						gears.shape.partially_rounded_rect(cr, width, height, false, false, true, true, beautiful.groups_radius) 
					end
				}
			}
		},
	}

	if tooltip then
		tooltip:add_to_object(widget_r)
	end

	return widget_r
end