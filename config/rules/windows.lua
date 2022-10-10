-- Rules specific to window types.

ruled.client.connect_signal('request::rules', function()
	-- Titlebar rules.

	ruled.client.append_rule {
		id 		= 'titlebars',

		rule_any = {
			type = { 'normal', 'dialog', 'modal', 'utility' }
		},

		properties = {
			titlebars_enabled = false
		}
	}

	-- Dialogs.

	ruled.client.append_rule {
		id = 'dialog',

		rule_any = {
			type  = { 'dialog' },
			class = { 'Wicd-client.py', 'calendar.google.com' }
		},

		properties = {
			floating        = true,
			above           = true,
			skip_decoration = true,
			placement       = awful.placement.centered
		}
	}

	-- Modals.

	ruled.client.append_rule {
		id = 'modal',

		rule_any = {
			type = { 'modal' }
		},

		properties = {
			floating        = true,
			above           = true,
			skip_decoration = true,
			placement       = awful.placement.centered
		}
	}

	-- Utilities.

	ruled.client.append_rule {
		id = 'utility',

		rule_any = {
			type = { 'utility' }
		},

		properties = {
			floating          = true,
			skip_decoration   = true,
			titlebars_enabled = false,
			border_width      = beautiful.no_gap,
			placement         = awful.placement.no_overlap + awful.placement.no_offscreen
		}
	}

	-- Splash.

	ruled.client.append_rule {
		id = 'splash',

		rule_any = {
			type = { 'splash' },
			name = {'Discord Updater'}
		},

		properties = {
			round_corners   = false,
			floating        = true,
			above           = true,
			skip_decoration = true,
			placement       = awful.placement.centered
		}
	}

	-- Browsers and chats.

	ruled.client.append_rule {
		id       = 'internet',

		rule_any = {
			class = {
				'firefox',
				'Tor Browser',
				'discord',
				'Brave',
				'Chromium',
				'Google-chrome',
				'TelegramDesktop'
			}
		},

		properties = {
			tag = '1'
		}
	}

	-- Text editors and word processing.

	ruled.client.append_rule {
		id       = 'text',

		rule_any = {
			class = { 'discord' },
			name  = {
				'LibreOffice',
				'libreoffice'
			}
		},

		properties = {
			tag = '3'
		}
	}

	-- File managers.

	ruled.client.append_rule {
		id       = 'files',

		rule_any = {
			class = { 'dolphin', 'ark', 'Thunar', 'Nemo', 'File-roller' }
		},

		properties = {
			tag = '5'
		}
	}

	-- Multimedia.

	ruled.client.append_rule {
		id = 'multimedia',

		rule_any = {
			class = {
				'vlc',
				'Spotify'
			}
		},

		properties = {
			tag = '7'
		}
	}

	-- Gaming.

	ruled.client.append_rule {
		id = 'gaming',

		rule_any = {
			class = {
				'dolphin-emu',
				'Steam',
				'Lutris',
				'Citra',
				'supertuxkart'
			},

			name = { 'Steam' }
		},

		properties = {
			tag             = '4',
			skip_decoration = true,
		}
	}

	-- Multimedia Editing.

	ruled.client.append_rule {
		id = 'graphics',

		rule_any = {
			class = { 'Gimp', 'Inkscape', 'Flowblade' }
		},

		properties = {
			tag = '2'
		}
	}

	-- Sandboxes and VMs.

	ruled.client.append_rule {
		id       = 'sandbox',

		rule_any = {
			class = { 'VirtualBox Manage', 'VirtualBox Machine', 'Gnome-boxes', 'Virt-manager' }
		},

		properties = {
			tag = '5'
		}
	}

	-- IDEs and Tools.

	ruled.client.append_rule {
		id = 'development',

		rule_any = {
			class = { 'Oomox', 'Unity', 'UnityHub', 'jetbrains-studio', 'Ettercap', 'scrcpy', 'Code' }
		},

		properties = {
			tag             = '2',
			skip_decoration = true
		}
	}

	-- Image viewers.

	ruled.client.append_rule {
		id        = 'image_viewers',
		rule_any  = {
			class    = { 'feh', 'Pqiv', 'Sxiv', 'nomacs' },
		},
		properties = {
			skip_decoration = true,
			floating        = true,
			ontop           = true,
			placement       = awful.placement.centered
		}
	}
end)