screen.connect_signal('request::wallpaper', function(scr)
	gears.wallpaper.maximized(beautiful.wallpaper, scr)
end)