-- Init the top-panel.

local top_panel = require('layout.top-panel')

screen.connect_signal('request::desktop_decoration', top_panel)