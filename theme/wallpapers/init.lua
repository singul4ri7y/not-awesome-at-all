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

			valign = 'center',
			halign = 'center',
			tiled  = false,
			widget = wibox.container.tile,
		}
	}
end)