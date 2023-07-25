shared_script '@WaveShield/resource/waveshield.lua' --this line was automatically written by WaveShield
fx_version 'adamant'
lua54 "yes"

game 'gta5'

description 'ESX Gang/PVP Garages'

Author '#martinnn8911 | Difamados PVP'

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
