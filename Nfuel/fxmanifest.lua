game 'gta5'
version '1.0'
fx_version 'adamant'
description 'Nfuel By NoxZi-Dev#0001'


client_scripts {
    'config.lua',
	'client/client.lua'
}

server_scripts {
    'server/server.lua',
    'config.lua',
}

ui_page('html/index.html')

files{
    'html/*.png',
    'html/*.css',
    'html/*.html',
    'html/*.js',
}