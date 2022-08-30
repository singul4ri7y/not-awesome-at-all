local topp = require('layout.topp')

screen.connect_signal('request::desktop_decoration', function(scr)
	scr.top_panel = topp(scr, false)
end)