RegisterServerEvent("ex-inventory:sendShopItems")
AddEventHandler("ex-inventory:sendShopItems", function(source, itemList)
	itemShopList = itemList
end)

ESX.RegisterServerCallback('ex-inventory:getShopItems', function(source, cb, shoptype)
	itemShopList = {}
	local itemResult = MySQL.Sync.fetchAll('SELECT * FROM items')
	local itemInformation = {}
	for i=1, #itemResult, 1 do
		if itemInformation[itemResult[i].name] == nil then
			itemInformation[itemResult[i].name] = {}
		end
		itemInformation[itemResult[i].name].name = itemResult[i].name
		itemInformation[itemResult[i].name].label = itemResult[i].label
		itemInformation[itemResult[i].name].weight = itemResult[i].weight
		itemInformation[itemResult[i].name].rare = itemResult[i].rare
		itemInformation[itemResult[i].name].can_remove = itemResult[i].can_remove
		if shoptype == 'groothandel_supermarkt' then
			for _, v in pairs(Config.Shops.GroothandelSupermarkt.Items) do
				if v.name == itemResult[i].name then
					table.insert(itemShopList, {
						type = 'item_standard',
						name = itemInformation[itemResult[i].name].name,
						label = itemInformation[itemResult[i].name].label,
						weight = itemInformation[itemResult[i].name].weight,
						rare = itemInformation[itemResult[i].name].rare,
						can_remove = itemInformation[itemResult[i].name].can_remove,
						price = v.price,
						count = 99999999
					})
				end
			end
		end
		if shoptype == 'regular' then
			for _, v in pairs(Config.Shops.RegularShop.Items) do
				if v.name == itemResult[i].name then
					table.insert(itemShopList, {
						type = 'item_standard',
						name = itemInformation[itemResult[i].name].name,
						label = itemInformation[itemResult[i].name].label,
						weight = itemInformation[itemResult[i].name].weight,
						rare = itemInformation[itemResult[i].name].rare,
						can_remove = itemInformation[itemResult[i].name].can_remove,
						price = v.price,
						count = 99999999
					})
				end
			end
		end
		if shoptype == 'cafe' then
			for _, v in pairs(Config.Shops.Cafe.Items) do
				if v.name == itemResult[i].name then
					table.insert(itemShopList, {
						type = 'item_standard',
						name = itemInformation[itemResult[i].name].name,
						label = itemInformation[itemResult[i].name].label,
						weight = itemInformation[itemResult[i].name].weight,
						rare = itemInformation[itemResult[i].name].rare,
						can_remove = itemInformation[itemResult[i].name].can_remove,
						price = v.price,
						count = 99999999
					})
				end
			end
		end
		
			if shoptype == 'sandvichi' then
			for _, v in pairs(Config.Shops.Sandvichi.Items) do
				if v.name == itemResult[i].name then
					table.insert(itemShopList, {
						type = 'item_standard',
						name = itemInformation[itemResult[i].name].name,
						label = itemInformation[itemResult[i].name].label,
						weight = itemInformation[itemResult[i].name].weight,
						rare = itemInformation[itemResult[i].name].rare,
						can_remove = itemInformation[itemResult[i].name].can_remove,
						price = v.price,
						count = 99999999
					})
				end
			end
		end

			if shoptype == 'napitki' then
			for _, v in pairs(Config.Shops.Napitki.Items) do
				if v.name == itemResult[i].name then
					table.insert(itemShopList, {
						type = 'item_standard',
						name = itemInformation[itemResult[i].name].name,
						label = itemInformation[itemResult[i].name].label,
						weight = itemInformation[itemResult[i].name].weight,
						rare = itemInformation[itemResult[i].name].rare,
						can_remove = itemInformation[itemResult[i].name].can_remove,
						price = v.price,
						count = 99999999
					})
				end
			end
		end

		if shoptype == 'Showroom' then
			for _, v in pairs(Config.Shops.Showroom.Items) do
				if v.name == itemResult[i].name then
					table.insert(itemShopList, {
						type = 'item_standard',
						name = itemInformation[itemResult[i].name].name,
						label = itemInformation[itemResult[i].name].label,
						weight = itemInformation[itemResult[i].name].weight,
						rare = itemInformation[itemResult[i].name].rare,
						can_remove = itemInformation[itemResult[i].name].can_remove,
						price = v.price,
						count = 99999999
					})
				end
			end
		end
		if shoptype == 'robsliquor' then
			for _, v in pairs(Config.Shops.RobsLiquor.Items) do
				if v.name == itemResult[i].name then
					table.insert(itemShopList, {
						type = 'item_standard',
						name = itemInformation[itemResult[i].name].name,
						label = itemInformation[itemResult[i].name].label,
						weight = itemInformation[itemResult[i].name].weight,
						rare = itemInformation[itemResult[i].name].rare,
						can_remove = itemInformation[itemResult[i].name].can_remove,
						price = v.price,
						count = 99999999
					})
				end
			end
		end
		if shoptype == 'youtool' then
			for _, v in pairs(Config.Shops.YouTool.Items) do
				if v.name == itemResult[i].name then
					table.insert(itemShopList, {
						type = 'item_standard',
						name = itemInformation[itemResult[i].name].name,
						label = itemInformation[itemResult[i].name].label,
						weight = itemInformation[itemResult[i].name].weight,
						rare = itemInformation[itemResult[i].name].rare,
						can_remove = itemInformation[itemResult[i].name].can_remove,
						price = v.price,
						count = 99999999
					})
				end
			end
		end
		if shoptype == 'policeshop' then
			for _, v in pairs(Config.Shops.PoliceShop.Items) do
				if v.name == itemResult[i].name then
					table.insert(itemShopList, {
						type = 'item_standard',
						name = itemInformation[itemResult[i].name].name,
						label = itemInformation[itemResult[i].name].label,
						weight = itemInformation[itemResult[i].name].weight,
						rare = itemInformation[itemResult[i].name].rare,
						can_remove = itemInformation[itemResult[i].name].can_remove,
						price = v.price,
						count = 99999999
					})
				end
			end
		end
		if shoptype == 'prison' then
			for _, v in pairs(Config.Shops.PrisonShop.Items) do
				if v.name == itemResult[i].name then
					table.insert(itemShopList, {
						type = 'item_standard',
						name = itemInformation[itemResult[i].name].name,
						label = itemInformation[itemResult[i].name].label,
						weight = itemInformation[itemResult[i].name].weight,
						rare = itemInformation[itemResult[i].name].rare,
						can_remove = itemInformation[itemResult[i].name].can_remove,
						price = v.price,
						count = 99999999
					})
				end
			end
		end
		if shoptype == 'weaponshop' then
			for _, v in pairs(Config.Shops.WeaponShop.Items) do
				if v.name == itemResult[i].name then
					table.insert(itemShopList, {
						type = 'item_standard',
						name = itemInformation[itemResult[i].name].name,
						label = itemInformation[itemResult[i].name].label,
						weight = itemInformation[itemResult[i].name].weight,
						rare = itemInformation[itemResult[i].name].rare,
						can_remove = itemInformation[itemResult[i].name].can_remove,
						price = v.price,
						count = 99999999
					})
				end
			end
		end
		if shoptype == 'MechanicShop' then
			for _, v in pairs(Config.Shops.MechanicShop.Items) do
				if v.name == itemResult[i].name then
					table.insert(itemShopList, {
						type = 'item_standard',
						name = itemInformation[itemResult[i].name].name,
						label = itemInformation[itemResult[i].name].label,
						weight = itemInformation[itemResult[i].name].weight,
						rare = itemInformation[itemResult[i].name].rare,
						can_remove = itemInformation[itemResult[i].name].can_remove,
						price = v.price,
						count = 99999999
					})
				end
			end
		end
		if shoptype == 'nightclubshop' then
			for _, v in pairs(Config.Shops.ShopNightclub.Items) do
				if v.name == itemResult[i].name then
					table.insert(itemShopList, {
						type = 'item_standard',
						name = itemInformation[itemResult[i].name].name,
						label = itemInformation[itemResult[i].name].label,
						weight = itemInformation[itemResult[i].name].weight,
						rare = itemInformation[itemResult[i].name].rare,
						can_remove = itemInformation[itemResult[i].name].can_remove,
						price = v.price,
						count = 99999999
					})
				end
			end
		end
		if shoptype == 'blackmarket' then
			for _, v in pairs(Config.Shops.BlackMarket.Items) do
				if v.name == itemResult[i].name then
					table.insert(itemShopList, {
						type = 'item_standard',
						name = itemInformation[itemResult[i].name].name,
						label = itemInformation[itemResult[i].name].label,
						weight = itemInformation[itemResult[i].name].weight,
						rare = itemInformation[itemResult[i].name].rare,
						can_remove = itemInformation[itemResult[i].name].can_remove,
						price = v.price,
						count = 99999999
					})
				end
			end
		end
	end
	cb(itemShopList)
end)

ESX.RegisterServerCallback("ex-inventory:getCustomShopItems", function(source, cb, shoptype, customInventory)
	itemShopList = {}
	local itemResult = MySQL.Sync.fetchAll('SELECT * FROM items')
	local itemInformation = {}
	for i=1, #itemResult, 1 do
		if itemInformation[itemResult[i].name] == nil then
			itemInformation[itemResult[i].name] = {}
		end
		itemInformation[itemResult[i].name].name = itemResult[i].name
		itemInformation[itemResult[i].name].label = itemResult[i].label
		itemInformation[itemResult[i].name].weight = itemResult[i].weight
		itemInformation[itemResult[i].name].rare = itemResult[i].rare
		itemInformation[itemResult[i].name].can_remove = itemResult[i].can_remove
		if shoptype == "normal" then
			for _, v in pairs(customInventory.Items) do
				if v.name == itemResult[i].name then
					table.insert(itemShopList, {
						type = "item_standard",
						name = itemInformation[itemResult[i].name].name,
						label = itemInformation[itemResult[i].name].label,
						weight = itemInformation[itemResult[i].name].weight,
						rare = itemInformation[itemResult[i].name].rare,
						can_remove = itemInformation[itemResult[i].name].can_remove,
						price = itemInformation[itemResult[i].name].price,
						count = 99999999
					})
				end
			end
		end

		if shoptype == "weapon" then
			local weapons = customInventory.Weapons
			for _, v in pairs(customInventory.Weapons) do
				if v.name == itemResult[i].name then
					table.insert(itemShopList, {
						type = "item_weapon",
						name = itemInformation[itemResult[i].name].name,
						label = itemInformation[itemResult[i].name].label,
						weight = 0,
						ammo = v.ammo,
						rare = itemInformation[itemResult[i].name].rare,
						can_remove = itemInformation[itemResult[i].name].can_remove,
						price = itemInformation[itemResult[i].name].price,
						count = 99999999
					})
				end
			end
			local ammo = customInventory.Ammo
			for _,v in pairs(customInventory.Ammo) do
				if v.name == itemResult[i].name then
					table.insert(itemShopList, {
						type = "item_ammo",
						name = itemInformation[itemResult[i].name].name,
						label = itemInformation[itemResult[i].name].label,
						weight = 0,
						weaponhash = v.weaponhash,
						ammo = v.ammo,
						rare = itemInformation[itemResult[i].name].rare,
						can_remove = itemInformation[itemResult[i].name].can_remove,
						price = itemInformation[itemResult[i].name].price,
						count = 99999999
					})
				end
			end

			for _, v in pairs(customInventory.Items) do
				if v.name == itemResult[i].name then
					table.insert(itemShopList, {
						type = "item_standard",
						name = itemInformation[itemResult[i].name].name,
						label = itemInformation[itemResult[i].name].label,
						weight = itemInformation[itemResult[i].name].weight,
						rare = itemInformation[itemResult[i].name].rare,
						can_remove = itemInformation[itemResult[i].name].can_remove,
						price = itemInformation[itemResult[i].name].price,
						count = 99999999
					})
				end
			end
		end
	end
	cb(itemShopList)
end)

RegisterNetEvent("ex-inventory:SellItemToPlayer")
AddEventHandler("ex-inventory:SellItemToPlayer",function(source, type, item, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if type == "item_standard" then
		local targetItem = xPlayer.getInventoryItem(item)
		if xPlayer.canCarryItem(item, count) then
			local list = itemShopList
			for i = 1, #list, 1 do
				if list[i].name == item then
					local totalPrice = count * list[i].price
					if xPlayer.getMoney() >= totalPrice then
						xPlayer.removeMoney(totalPrice)
						xPlayer.addInventoryItem(item, count)
						TriggerClientEvent("DoLongHudText", _source, _U('item_added')..count.." "..list[i].label, 1)
					else
						TriggerClientEvent("DoLongHudText", _source, _U('no_money'), 1)
					end
				end
			end
			else
			TriggerClientEvent("DoLongHudText", _source, _U('insufficient_space'), 2)
		end
	end
	if type == "item_weapon" then
		if xPlayer.canCarryItem(item, count) then
			local list = itemShopList
			for i = 1, #list, 1 do
				if list[i].name == item then
					local totalPrice = count * list[i].price
					if xPlayer.getMoney() >= totalPrice then
						xPlayer.removeMoney(totalPrice)
						xPlayer.addInventoryItem(item, count)
						TriggerClientEvent("DoLongHudText", _source, _U('item_added')..count.." "..list[i].label, 1)
					else
						TriggerClientEvent("DoLongHudText", _source, _U('no_money'), 2)
					end
				end
			end
		else
			TriggerClientEvent("DoLongHudText", _source, _U('insufficient_space'), 2)
		end
	end

	if type == "item_ammo" then
		local targetItem = xPlayer.getInventoryItem(item)
		local list = itemShopList
		for i = 1, #list, 1 do
			if list[i].name == item then
				local targetWeapon = xPlayer.hasWeapon(list[i].weaponhash)
				if targetWeapon then
					local totalPrice = count * list[i].price
					local ammo = count * list[i].ammo
					if xPlayer.getMoney() >= totalPrice then
						xPlayer.removeMoney(totalPrice)
						TriggerClientEvent("ex-inventory:AddAmmoToWeapon", source, list[i].weaponhash, ammo)
						TriggerClientEvent("DoLongHudText", _source, _U('item_added')..count.." "..list[i].label, 1)
					else
						TriggerClientEvent("DoLongHudText", _source, _U('no_money'), 2)
					end
				else
					TriggerClientEvent("DoLongHudText", _source, _U('insufficient_space'), 2)
				end
			end
		end
	end
end)

-- ESX.RegisterServerCallback('ex-inventory:heeftSupermarkt', function(source, cb)
-- 	local _source = source
-- 	local xPlayer = ESX.GetPlayerFromId(source)
-- 	MySQL.Async.fetchAll('SELECT * FROM eigen_supermarkten WHERE identifier = @owner', {
-- 		['@owner'] =  xPlayer.identifier,
-- 		['@slot'] = 5
-- 	},function(results5)
-- 		if #results5 == 0 then
-- 			cb(true)
-- 		else
-- 			cb(false)
-- 		end
-- 	end)
-- end)

-- ESX.RegisterServerCallback('ex-inventory:buyLicense', function(source, cb)
-- 	local _source = source
-- 	local xPlayer = ESX.GetPlayerFromId(source)
-- 	if xPlayer.getMoney() >= Config.LicensePrice then
-- 		xPlayer.removeMoney(Config.LicensePrice)
-- 		TriggerEvent('esx_license:addLicense', source, 'weapon', function()
-- 			cb(true)
-- 		end)
-- 	else
-- 		TriggerClientEvent("DoLongHudText", _source, _U("no_money"), 2)
-- 		cb(false)
-- 	end
-- end)