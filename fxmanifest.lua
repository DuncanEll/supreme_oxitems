fx_version 'cerulean'
game 'gta5'
lua54 'yes'
author 'DuncanEll'

client_scripts {
    "client.lua"
}

server_scripts {
    "server.lua",
}

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}

ui_page 'html/index.html'

files {
	'html/index.html',
    'html/script.js',
    'html/uiscript.js',
    'html/style.css',
    'html/reset.css',
    'html/main.css'
}