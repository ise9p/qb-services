fx_version 'cerulean'
game 'gta5'

description 'Se9p Script | Stop Services'
author 'Se9p Script'
version '1.0.0'

shared_scripts {
    'config/config.lua',
	'@ox_lib/init.lua'
}


client_scripts {
	'client/*.lua',
}

server_scripts {
	'server/*.lua'
}

lua54 'yes'