-- Base username.

local uname = os.getenv('USER')

local id = {
	-- Uppercase user name.

	username = uname:gsub('^%l', string.upper)
}

-- Get the user full name.

awful.spawn.easy_async_with_shell('getent passwd "' .. uname .. '" | cut -d ":" -f 5 | cut -d "," -f 1', function(stdout)
	id.fullname = stdout
end)

return id