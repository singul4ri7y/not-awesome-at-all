ruled.notification.connect_signal('request::rules', function()
	-- All notifications will match this rule.

	ruled.notification.append_rule {
		rule = {},

		properties = {
			screen           = awful.screen.preferred_screen,
			implicit_timeout = 5
		}
	}
end)