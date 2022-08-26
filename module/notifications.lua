-- Display all the requested notifications.

naughty.connect_signal('request::display', function(n)
	naughty.layout.box { notification = n }
end)

-- Error handling.
-- Check if user defined AwesomeWM configuration
-- had any erros on runtime or during starup and
-- fell back to original AwesomeWM configuration.

naughty.connect_signal('request::display_error', function(message, startup)
	naughty.notification {
		urgency  = 'critical',
		title    = 'Oops, you my friend, had an error' .. (startup and ' during startup!' or '!'),
		message  = message,
		icon     = beautiful.awesome_icon,
		app_name = 'System Notification'
	}
end)