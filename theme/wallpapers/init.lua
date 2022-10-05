screen.connect_signal('request::wallpaper', function(scr)
	awful.wallpaper {
		screen = scr,
		widget = {
			{
				image     = beautiful.wallpaper,
				upscale   = true,
				downscale = true,
				widget    = wibox.widget.imagebox,
			},

			valign                = 'center',
			halign                = 'center',
			tiled                 = false,
			horizontal_fit_policy = 'fit',
			vertical_fit_policy   = 'fit',
			widget                = wibox.container.tile,
		}
	}
end)