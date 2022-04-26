fx_version 'cerulean'
game 'gta5'

ui_page 'html/ui.html'

client_scripts {
	'handsup.lua',
	'@pmc-keybinds/import.lua',
	'@es_extended/locale.lua',
	'config.lua',
	'locales/*.lua',
	'client/main.lua',
	 'client/glovebox.lua',
	'client/ammunition.lua',
	'client/trunk.lua',
	 'client/robplayer.lua',
	'client/weapons.lua',
	'client/camera.lua',
	'client/addons/player.lua',
	'client/addons/shop.lua',
	'client/addons/trunk.lua',
	'client/vending.lua',
	 'client/addons/glovebox.lua',
	-- 'client/addons/motels.lua',
	'client/addons/vault.lua',
	 'client/addons/property.lua'
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'config.lua',
	'locales/*.lua',
	'server/main.lua',
	'server/weapons.lua',
	'server/trunk.lua',
	 'server/glovebox.lua',
	'server/ammunition.lua',
	 'server/robanim.lua',
	'server/shop.lua',
	'server/hotbar.lua',
	'server/vending.lua',
	'server/classes/c_trunk.lua',
	 'server/classes/c_glovebox.lua',	
}

files {
	'html/ui.html',
	'html/css/ui.css',
	'html/css/jquery-ui.css',
	'html/js/inventory.js',
	'html/js/config.js',
	'html/locales/*.js',
	'html/img/*.png',
	'html/img/*.jpg',
	'html/img/*.svg',
	'html/img/items/*.png',
	'html/img/items/*.jpg',
	'html/img/items/*.svg'
}

exports {
	'GenerateWeapon',
	'openInventory'
}


