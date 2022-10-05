local top_panel   = require('layout.top-panel')
local left_panel  = require('layout.left-panel')
local right_panel = require('layout.right-panel')

screen.connect_signal('request::desktop_decoration', function(scr)
	-- If the layout is already fullscreen, then override
	-- 'update_bars_visibility' fullscreen functionality.

	scr.fullscreen_override = false

	-- If the client is in fullscreen mode and in the mean
	-- time the layout changes to any other layout than
	-- fullscreen layout, then let the 'update_bars_visibility'
	-- to handle the visibility of the bars.

	scr.client_fullscreen = false

	-- Init the layout bars.

	if scr.index == 1 then
		scr.top_panel  = top_panel(scr, true)
		scr.left_panel = left_panel(scr)
	else
		scr.top_panel = top_panel(scr, false)
	end

	scr.right_panel = right_panel(scr)

	scr.dashboard_was_opened    = false
	scr.dashboard_ex_was_opened = false
	scr.right_panel_was_opened  = false
end)

-- Response to hide/show signals.
-- Those signals are emitted when 
-- fullscreen layout is enabled.

screen.connect_signal('panel::hide', function(scr)
	scr.fullscreen_override = true

	if not scr.client_fullscreen then
		scr.top_panel.visible = false

		if scr.right_panel.visible then
			scr.right_panel_was_opened = true

			scr.right_panel:close()
		end

		if scr.left_panel then
			scr.left_panel.visible = false
			
			if scr.left_panel.opened_ex then
				scr.dashboard_ex_was_opened = true
			end

			if scr.left_panel.opened then
				scr.dashboard_was_opened = true

				scr.left_panel:close()
			end
		end
	end
end)

screen.connect_signal('panel::show', function(scr)
	scr.fullscreen_override = false

	if not scr.client_fullscreen then
		scr.top_panel.visible = true

		if scr.right_panel_was_opened then
			scr.right_panel:open()
		end

		if scr.left_panel then
			scr.left_panel.visible = true

			if scr.dashboard_was_opened then
				scr.left_panel:open()

				scr.dashboard_was_opened = false
			end

			if scr.dashboard_ex_was_opened then
				scr.left_panel:open_extended()

				scr.dashboard_ex_was_opened = false
			end
		end
	end
end)

-- Hide bars when app go fullscreen.

function update_bars_visibility()
	for scr in screen do
		if scr.selected_tag then
			scr.client_fullscreen = scr.selected_tag.fullscreen_mode

			if not scr.fullscreen_override then
				-- Order matter here for shadow

				scr.top_panel.visible = not scr.client_fullscreen
				
				if not scr.client_fullscreen then
					if scr.right_panel_was_opened then
						scr.right_panel:open()

						scr.right_panel_was_opened = false
					end
				elseif scr.right_panel.visible then
					scr.right_panel_was_opened = true
					
					scr.right_panel:close()
				end

				if scr.left_panel then
					scr.left_panel.visible = not scr.client_fullscreen

					if not scr.client_fullscreen then
						if scr.dashboard_was_opened then
							scr.left_panel:open()
		
							scr.dashboard_was_opened = false
						end

						if scr.dashboard_ex_was_opened then
							scr.left_panel:open_extended()

							scr.dashboard_ex_was_opened = false
						end
					elseif scr.left_panel.opened then
						scr.dashboard_was_opened = true

						if scr.left_panel.opened_ex then
							scr.dashboard_ex_was_opened = true
						end
						
						scr.left_panel:close()
					end
				end
			end
		end
	end
end

tag.connect_signal('property::selected', function(_)
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