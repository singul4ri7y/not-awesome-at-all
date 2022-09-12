local top_panel = require('layout.top-panel')

screen.connect_signal('request::desktop_decoration', function(scr)
	scr.top_panel = top_panel(scr, false)
end)