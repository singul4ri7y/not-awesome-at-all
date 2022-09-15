local top_panel  = require('layout.top-panel')
local left_panel = require('layout.left-panel')

screen.connect_signal('request::desktop_decoration', function(scr)
	if scr.index == 1 then
		scr.top_panel  = top_panel(scr, true)
		scr.left_panel = left_panel(scr)
	else
		scr.top_panel = top_panel(scr, false)
	end
end)

-- Response to hide/show signals.
-- Those signals are emitted when 
-- fullscreen layout is enabled.

screen.connect_signal('panel::hide', function(scr)
	scr.top_panel.visible = false

	if scr.left_panel then
		scr.left_panel.visible = false
	end
end)

screen.connect_signal('panel::show', function(scr)
	scr.top_panel.visible = true

	if scr.left_panel then
		scr.left_panel.visible = true
	end
end)

-- Hide bars when app go fullscreen.

function update_bars_visibility()
	for s in screen do
		if s.selected_tag then
			local fullscreen = s.selected_tag.fullscreen_mode

			-- Order matter here for shadow

			s.top_panel.visible = not fullscreen

			if s.left_panel then
				s.left_panel.visible = not fullscreen
			end

			if s.right_panel then
				if fullscreen and s.right_panel.visible then
					s.right_panel:toggle()
					s.right_panel_show_again = true
				elseif not fullscreen and not s.right_panel.visible and s.right_panel_show_again then
					s.right_panel:toggle()
					s.right_panel_show_again = false
				end
			end
		end
	end
end

tag.connect_signal('property::selected', function(t)
	update_bars_visibility()
end)

client.connect_signal('property::fullscreen', function(c)
	if c.first_tag then
		c.first_tag.fullscreen_mode = c.fullscreen
	end
	
	update_bars_visibility()
end)

client.connect_signal('unmanage', function(c)
	if c.fullscreen then
		c.screen.selected_tag.fullscreen_mode = false

		update_bars_visibility()
	end
end)