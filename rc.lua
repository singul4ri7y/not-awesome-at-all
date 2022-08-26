-- If LuaRocks is is installed, make sure all the packages
-- installed through it are found.

pcall(require, 'luarocks.loader')

require('awful.autofocus')

awful      = require('awful')           -- GLOBAL
beautiful  = require('beautiful')       -- GLOBAL
gears      = require('gears')           -- GLOBAL
naughty    = require('naughty')         -- GLOBAL
wibox      = require('wibox')           -- GLOBAL

-- Set the defualt shell to be used in awful.spawn.with_shell 
-- and it's derivatives.

awful.util.shell = 'zsh'

-- The configuration directory.

config_dir = gears.filesystem.get_configuration_dir()        -- GLOBAL

-- Alias.

dpi = beautiful.xresources.apply_dpi    -- GLOBAL

-- Init main theme.

require('theme')

-- Init modules.

require('module')

-- Init configuration.

require('config')

-- Init layout.

require('layout')