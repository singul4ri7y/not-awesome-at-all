local startup = require('config.user.startup')

for _, app in ipairs(startup) do
	local findme     = app
	local firstspace = app:find(' ')

	if firstspace then
		findme       = app:sub(0, firstspace - 1)
	end

	awful.spawn.easy_async_with_shell(
	string.format('(pgrep -u $USER -x %s || %s) > /dev/null', findme, app),
	function(stdout, stderr) 
		-- Debug.

		if not stderr or stderr == '' then
			return 
		end

		naughty.notification {
			app_name = 'Start-up Applications',
			title = '<b>Fuck! Error detected while starting an application!</b>',
			message = stderr:gsub('%\n', '') .. ' : while starting application "' .. app .. '"',
			timeout = 20,
			icon = beautiful.awesome_icon
		}
	end)
end