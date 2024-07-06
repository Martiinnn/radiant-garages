--shared_script '@WaveShield/resource/waveshield.lua' --My anticheat
fx_version 'adamant'
lua54 "yes"

game 'gta5'

description 'ESX Gang/PVP Garages'

Author '#martinnn8911 | Radiant PVP'

version '1.0.0'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'config.lua',
	'server/main.lua'
}

shared_scripts {
	'@ox_lib/init.lua',
	'@es_extended/imports.lua',
	'@ox_lib/init.lua'
}

client_scripts {
	"@PolyZone/client.lua",
	'config.lua',
	'client/main.lua',
	'client/functions.lua',
}
