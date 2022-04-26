ESX = nil
Items = {}
local DataStoresIndex = {}
local DataStores = {}
local SharedDataStores = {}
local arrayWeight = Config.localWeight
local VehicleList = {}
local VehicleInventory = {}

local listPlate = Config.VehiclePlate

TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)

--AddEventHandler("onMySQLReady", function()
MySQL.ready(function()
	local result = MySQL.Sync.fetchAll("SELECT * FROM glovebox_inventory")
	local data = nil
	if #result ~= 0 then
		for i = 1, #result, 1 do
			local plate = result[i].plate
			local owned = result[i].owned
			local data = (result[i].data == nil and {} or json.decode(result[i].data))
			local dataStore = CreateDataStoreGlovebox(plate, owned, data)
			SharedDataStores[plate] = dataStore
		end
	end
	MySQL.Async.execute("DELETE FROM `glovebox_inventory` WHERE `owned` = 0", {})
end)

function loadInventGloveboxGlovebox(plate)
	local result =
	MySQL.Sync.fetchAll("SELECT * FROM glovebox_inventory WHERE plate = @plate", {
		["@plate"] = plate
	})
	local data = nil
	if #result ~= 0 then
		for i = 1, #result, 1 do
			local plate = result[i].plate
			local owned = result[i].owned
			local data = (result[i].data == nil and {} or json.decode(result[i].data))
			local dataStore = CreateDataStoreGlovebox(plate, owned, data)
			SharedDataStores[plate] = dataStore
		end
	end
end

function getOwnedVehicle(plate)
	local found = false
	if listPlate then
		for k, v in pairs(listPlate) do
			if string.find(plate, v) ~= nil then
			found = true
			break
			end
		end
	end
	if not found then
		local result = MySQL.Sync.fetchAll("SELECT * FROM owned_vehicles")
		while result == nil do
			Wait(5)
		end
		if result ~= nil and #result > 0 then
			for _, v in pairs(result) do
			local vehicle = json.decode(v.vehicle)
				if vehicle.plate == plate then
					found = true
					break
				end
			end
		end
	end
	return found
end

function MakeDataStoreGlovebox(plate)
	local data = {}
	local owned = getOwnedVehicle(plate)
	local dataStore = CreateDataStoreGlovebox(plate, owned, data)
	SharedDataStores[plate] = dataStore
	MySQL.Async.execute("INSERT INTO glovebox_inventory(plate,data,owned) VALUES (@plate,'{}',@owned)", {
		["@plate"] = plate,
		["@owned"] = owned
	})
	loadInventGloveboxGlovebox(plate)
end

function GetSharedDataStoreGlovebox(plate)
	if SharedDataStores[plate] == nil then
		MakeDataStoreGlovebox(plate)
	end
	return SharedDataStores[plate]
end

AddEventHandler("ex-inventory_glovebox:GetSharedDataStoreGlovebox", function(plate, cb)
	cb(GetSharedDataStoreGlovebox(plate))
end)

--[[RegisterServerEvent("ex-inventory_glovebox:getOwnedVehicle")
AddEventHandler("ex-inventory_glovebox:getOwnedVehicle", function()
	local vehicules = {}
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	MySQL.Async.fetchAll("SELECT * FROM owned_vehicles WHERE owner = @owner", {
		["@owner"] = xPlayer.identifier
	},
	function(result)
		if result ~= nil and #result > 0 then
			for _, v in pairs(result) do
				local vehicle = json.decode(v.vehicle)
				table.insert(vehicules, {plate = vehicle.plate})
			end
		end
		TriggerClientEvent("ex-inventory_glovebox:setOwnedVehicle", _source, vehicules)
	end)
end)]]

RegisterServerEvent("ex-inventory_glovebox:getOwnedVehicle")
AddEventHandler("ex-inventory_glovebox:getOwnedVehicle", function()
	local vehicules = {}
	local _source = source
	local result = MySQL.Sync.fetchAll("SELECT * FROM owned_vehicles")
	
	if #result ~= 0 then
		for i = 1, #result, 1 do
			local plate1 = result[i].plate
			table.insert(vehicules, {plate = plate1})
		end
	end
	TriggerClientEvent("ex-inventory_glovebox:setOwnedVehicule", _source, vehicules)
end)

function getItemWeight(item)
	local weight = 0
	local itemWeight = 0
	if item ~= nil then
		itemWeight = Config.DefaultWeight
		if arrayWeight[item] ~= nil then
			itemWeight = arrayWeight[item]
		end
	end
	return itemWeight
end

function getInventoryWeightGlovebox(inventory)
	local weight = 0
	local itemWeight = 0
	if inventory ~= nil then
		for i = 1, #inventory, 1 do
			if inventory[i] ~= nil then
				itemWeight = Config.DefaultWeight
				if arrayWeight[inventory[i].name] ~= nil then
					itemWeight = arrayWeight[inventory[i].name]
				end
				weight = weight + (itemWeight * (inventory[i].count or 1))
			end
		end
	end
	return weight
end

function getTotalInventoryWeightGlovebox(plate)
	local total
	TriggerEvent("ex-inventory_glovebox:GetSharedDataStoreGlovebox", plate, function(store)
		local W_weapons = getInventoryWeightGlovebox(store.get("weapons") or {})
		local W_coffres = getInventoryWeightGlovebox(store.get("coffres") or {})
		local W_blackMoney = 0
		local blackAccount = (store.get("black_money")) or 0
		if blackAccount ~= 0 then
			W_blackMoney = blackAccount[1].amount / 10
		end
		local W_cashMoney = 0
		local cashAccount = (store.get("money")) or 0
		if cashAccount ~= 0 then
			W_cashMoney = cashAccount[1].amount / 10
		end
		total = W_weapons + W_coffres + W_blackMoney + W_cashMoney
		end)
	return total
end

ESX.RegisterServerCallback("ex-inventory_glovebox:getInventoryV", function(source, cb, plate)
	TriggerEvent("ex-inventory_glovebox:GetSharedDataStoreGlovebox", plate, function(store)
		local blackMoney = 0
		local cashMoney = 0
		local items = {}
		local weapons = {}
		weapons = (store.get("weapons") or {})

		local blackAccount = (store.get("black_money")) or 0
		if blackAccount ~= 0 then
			blackMoney = blackAccount[1].amount
		end

		local cashAccount = (store.get("money")) or 0
		if cashAccount ~= 0 then
			cashMoney = cashAccount[1].amount
		end

		local coffres = (store.get("coffres") or {})
		for i = 1, #coffres, 1 do
			table.insert(items, {name = coffres[i].name, count = coffres[i].count, label = ESX.GetItemLabel(coffres[i].name)})
		end

		local weight = getTotalInventoryWeightGlovebox(plate)
		cb({
			blackMoney = blackMoney,
			cashMoney = cashMoney,
			items = items,
			weapons = weapons,
			weight = weight
		})
	end)
end)

RegisterServerEvent("ex-inventory_glovebox:getItem")
AddEventHandler("ex-inventory_glovebox:getItem", function(plate, type, item, count, max, owned)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	if type == "item_standard" then
		local targetItem = xPlayer.getInventoryItem(item)
		if xPlayer.canCarryItem(item, count) then
			TriggerEvent("ex-inventory_glovebox:GetSharedDataStoreGlovebox", plate, function(store)
				local coffres = (store.get("coffres") or {})
				for i = 1, #coffres, 1 do
					if coffres[i].name == item then
						if (coffres[i].count >= count and count > 0) then
							if item == 'WEAPON_PISTOL' or item == 'WEAPON_FLASHLIGHT' or item == 'WEAPON_STUNGUN' or item == 'WEAPON_KNIFE' 
							or item == 'WEAPON_BAT' or item == 'WEAPON_ADVANCEDRIFLE' or item == 'WEAPON_APPISTOL' or item == 'WEAPON_ASSAULTRIFLE'
							or item == 'WEAPON_ASSAULTSHOTGUN' or item == 'WEAPON_ASSAULTSMG' or item == 'WEAPON_AUTOSHOTGUN' or item == 'WEAPON_CARBINERIFLE'
							or item == 'WEAPON_COMBATPISTOL' or item == 'WEAPON_PUMPSHOTGUN' or item == 'WEAPON_SMG' then
								TriggerEvent('ex-inventory:changeWeaponOwner',plate, xPlayer.identifier, item)
							end
							xPlayer.addInventoryItem(item, count)
						if (coffres[i].count - count) == 0 then
							table.remove(coffres, i)
						else
							coffres[i].count = coffres[i].count - count
						end
						break
						else
							TriggerClientEvent("DoLongHudText", _source, _U("nacho_veh"), 1)
						end
					end
				end

				store.set("coffres", coffres)

				local blackMoney = 0
				local cashMoney = 0
				local items = {}
				local weapons = {}
				weapons = (store.get("weapons") or {})

				local blackAccount = (store.get("black_money")) or 0
				if blackAccount ~= 0 then
					blackMoney = blackAccount[1].amount
				end

				local cashAccount = (store.get("money")) or 0
				if cashAccount ~= 0 then
					cashMoney = cashAccount[1].amount
				end

				local coffres = (store.get("coffres") or {})
				for i = 1, #coffres, 1 do
					table.insert(items, {name = coffres[i].name, count = coffres[i].count, label = ESX.GetItemLabel(coffres[i].name)})
				end

				local weight = getTotalInventoryWeightGlovebox(plate)

				text = _U("glovebox_info", plate, (weight / 100), (max / 100))
				data = {plate = plate, max = max, myVeh = owned, text = text}
				TriggerClientEvent("ex-inventory:refreshGloveboxInventory", _source, data, blackMoney, cashMoney, items, weapons)
			end)
		else
			TriggerClientEvent("DoLongHudText", _source, _U("player_inv_no_space"), 1)
		end
	end

	if type == "item_account" then
		TriggerEvent("ex-inventory_glovebox:GetSharedDataStoreGlovebox", plate, function(store)
			local blackMoney = store.get("black_money")
			if (blackMoney[1].amount >= count and count > 0) then
				blackMoney[1].amount = blackMoney[1].amount - count
				store.set("black_money", blackMoney)
				xPlayer.addAccountMoney(item, count)

				local blackMoney = 0
				local cashMoney = 0
				local items = {}
				local weapons = {}
				weapons = (store.get("weapons") or {})

				local blackAccount = (store.get("black_money")) or 0
				if blackAccount ~= 0 then
					blackMoney = blackAccount[1].amount
				end
				local cashAccount = (store.get("money")) or 0
				if cashAccount ~= 0 then
					cashMoney = cashAccount[1].amount
				end
				local coffres = (store.get("coffres") or {})
				for i = 1, #coffres, 1 do
					table.insert(items, {name = coffres[i].name, count = coffres[i].count, label = ESX.GetItemLabel(coffres[i].name)})
				end

				local weight = getTotalInventoryWeightGlovebox(plate)

				text = _U("glovebox_info", plate, (weight / 100), (max / 100))
				data = {plate = plate, max = max, myVeh = owned, text = text}
				TriggerClientEvent("ex-inventory:refreshGloveboxInventory", _source, data, blackMoney, items, weapons)
			else
				TriggerClientEvent("DoLongHudText", _source, _U("invalid_amount"), 2)
			end
		end)
	end

	if type == "item_money" then
		TriggerEvent("ex-inventory_glovebox:GetSharedDataStoreGlovebox", plate, function(store)
			local cashMoney = store.get("money")
			if (cashMoney[1].amount >= count and count > 0) then
				cashMoney[1].amount = cashMoney[1].amount - count
				store.set("money", cashMoney)
				xPlayer.addMoney(count)

				local blackMoney = 0
				local cashMoney = 0
				local items = {}
				local weapons = {}
				weapons = (store.get("weapons") or {})

				local blackAccount = (store.get("black_money")) or 0
				if blackAccount ~= 0 then
					blackMoney = blackAccount[1].amount
				end

				local cashAccount = (store.get("money")) or 0
				if cashAccount ~= 0 then
					cashMoney = cashAccount[1].amount
				end

				local coffres = (store.get("coffres") or {})
				for i = 1, #coffres, 1 do
					table.insert(items, {name = coffres[i].name, count = coffres[i].count, label = ESX.GetItemLabel(coffres[i].name)})
				end

				local weight = getTotalInventoryWeightGlovebox(plate)

				text = _U("glovebox_info", plate, (weight / 100), (max / 100))
				data = {plate = plate, max = max, myVeh = owned, text = text}
				TriggerClientEvent("ex-inventory:refreshGloveboxInventory", _source, data, blackMoney, cashMoney, items, weapons)
			else
				TriggerClientEvent("DoLongHudText", _source, _U("invalid_amount"), 2)
			end
		end)
	end
end)

RegisterServerEvent("ex-inventory_glovebox:putItem")
AddEventHandler("ex-inventory_glovebox:putItem", function(plate, type, item, count, max, owned, label)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	-- local xPlayerOwner = ESX.GetPlayerFromIdentifier(owner)
	local xPlayerOwner = ESX.GetPlayerFromId(owner)

	if type == "item_standard" then
		local playerItemCount = xPlayer.getInventoryItem(item).count
		if (playerItemCount >= count and count > 0) then
			TriggerEvent("ex-inventory_glovebox:GetSharedDataStoreGlovebox", plate, function(store)
				local found = false
				local coffres = (store.get("coffres") or {})

				for i = 1, #coffres, 1 do
					if coffres[i].name == item then
						coffres[i].count = coffres[i].count + count
						found = true
					end
				end
				if not found then
					table.insert(coffres, {
						name = item,
						count = count
					})
				end
				if (getTotalInventoryWeightGlovebox(plate) + (count / 10)) > max then
					TriggerClientEvent("DoLongHudText", _source, _U("insufficient_space"), 1)
				else
					store.set("coffres", coffres)
					if item == 'WEAPON_PISTOL' or item == 'WEAPON_FLASHLIGHT' or item == 'WEAPON_STUNGUN' or item == 'WEAPON_KNIFE' 
					or item == 'WEAPON_BAT' or item == 'WEAPON_ADVANCEDRIFLE' or item == 'WEAPON_APPISTOL' or item == 'WEAPON_ASSAULTRIFLE'
					or item == 'WEAPON_ASSAULTSHOTGUN' or item == 'WEAPON_ASSAULTSMG' or item == 'WEAPON_AUTOSHOTGUN' or item == 'WEAPON_CARBINERIFLE'
					or item == 'WEAPON_COMBATPISTOL' or item == 'WEAPON_PUMPSHOTGUN' or item == 'WEAPON_SMG' then
						TriggerEvent('ex-inventory:changeWeaponOwner',xPlayer.identifier, plate, item)
					end
					xPlayer.removeInventoryItem(item, count)
					MySQL.Async.execute("UPDATE glovebox_inventory SET owned = @owned WHERE plate = @plate", {
						["@plate"] = plate,
						["@owned"] = owned
					})
				end
			end)
		else
			TriggerClientEvent("DoLongHudText", _source, _U("invalid_quantity"), 1)
		end
	end

	if type == "item_account" then
		local playerAccountMoney = xPlayer.getAccount(item).money
		if (playerAccountMoney >= count and count > 0) then
			TriggerEvent("ex-inventory_glovebox:GetSharedDataStoreGlovebox", plate, function(store)
				local blackMoney = (store.get("black_money") or nil)
				if blackMoney ~= nil then
					blackMoney[1].amount = blackMoney[1].amount + count
				else
					blackMoney = {}
					table.insert(blackMoney, {amount = count})
				end

				if (getTotalInventoryWeightGlovebox(plate) + blackMoney[1].amount / 10) > max then
					TriggerClientEvent("DoLongHudText", _source, _U("insufficient_space"), 2)
				else
					xPlayer.removeAccountMoney(item, count)
					store.set("black_money", blackMoney)
					MySQL.Async.execute("UPDATE glovebox_inventory SET owned = @owned WHERE plate = @plate", {
						["@plate"] = plate,
						["@owned"] = owned
					})
				end
			end)
		else
			TriggerClientEvent("DoLongHudText", _source, _U("invalid_amount"), 1)
		end
	end

	if type == "item_money" then
		local playerAccountMoney = xPlayer.getMoney()
		if (playerAccountMoney >= count and count > 0) then
			TriggerEvent("ex-inventory_glovebox:GetSharedDataStoreGlovebox", plate, function(store)
				local cashMoney = (store.get("money") or nil)
				if cashMoney ~= nil then
					cashMoney[1].amount = cashMoney[1].amount + count
				else
					cashMoney = {}
					table.insert(cashMoney, {amount = count})
				end
				if (getTotalInventoryWeightGlovebox(plate) + (count / 10)) > max then
					TriggerClientEvent("DoLongHudText", _source, _U("insufficient_space"), 1)
				else
					xPlayer.removeMoney(count)
					store.set("money", cashMoney)
					MySQL.Async.execute("UPDATE inventory_glovebox SET owned = @owned WHERE plate = @plate", {
						["@plate"] = plate,
						["@owned"] = owned
					})
				end
			end)
		else
			TriggerClientEvent("DoLongHudText", _source, _U("invalid_amount"), 1)
		end
	end

	TriggerEvent("ex-inventory_glovebox:GetSharedDataStoreGlovebox", plate, function(store)
		local blackMoney = 0
		local cashMoney = 0
		local items = {}
		local weapons = {}
		weapons = (store.get("weapons") or {})

		local blackAccount = (store.get("black_money")) or 0
		if blackAccount ~= 0 then
		blackMoney = blackAccount[1].amount
		end

		local cashAccount = (store.get("money")) or 0
		if cashAccount ~= 0 then
		cashMoney = cashAccount[1].amount
		end

		local coffres = (store.get("coffres") or {})
		for i = 1, #coffres, 1 do
		table.insert(items, {name = coffres[i].name, count = coffres[i].count, label = ESX.GetItemLabel(coffres[i].name)})
		end

		local weight = getTotalInventoryWeightGlovebox(plate)

		text = _U("glovebox_info", plate, (weight / 100), (max / 100))
		data = {plate = plate, max = max, myVeh = owned, text = text}
		TriggerClientEvent("ex-inventory:refreshGloveboxInventory", _source, data, blackMoney, cashMoney, items, weapons)
	end)
end)

ESX.RegisterServerCallback("ex-inventory_glovebox:getPlayerInventory", function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local blackMoney = xPlayer.getAccount("black_money").money
	local cashMoney = xPlayer.getMoney()
	local items = xPlayer.inventory
	cb({
		blackMoney = blackMoney,
		cashMoney = cashMoney,
		items = items
	})
end)

function all_trim(s)
	if s then
		return s:match "^%s*(.*)":match "(.-)%s*$"
	else
		return "noTagProvided"
	end
end

