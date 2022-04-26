local shopData = nil
--[[
RegisterKey('keyboard', 'E', 
	function()
	end,
	-- on release
	function()
		player = PlayerPedId()
		coords = GetEntityCoords(player)
		if not IsPlayerDead(player) then
			if IsInDrugShopZone(coords) or IsInIlegalShopZone(coords) or IsInPrisonShopZone(coords) or IsInWeaponShopZone(coords) or IsInBlackMarketZone(coords) or IsInShopNightclubZone(coords) or IsInPoliceShopZone(coords) or IsInGroothandelSupermarktZone(coords) then	
				
				if IsInIlegalShopZone(coords) then
					if Config.IllegalshopOpen == true then
						OpenShopInv('ilegal')
					else
						if ESX.GetPlayerData().job.name == Config.InventoryJob.Police then
							OpenShopInv('ilegal')
						else
							exports['t-notify']:Alert({
								style  	=  'error',
								message =  _U('no_acces'),
								length 	= 5500
							})
						end
					end
				end
				
				if Config.useAdvancedShop == true then
					if IsInGroothandelSupermarktZone(coords) then
						ESX.TriggerServerCallback('ex-inventory:heeftSupermarkt', function(ja)
							if ja then
								OpenShopInv('groothandel_supermarkt')
							else
								exports['t-notify']:Alert({
									style  	=  'error',
									message =  _U('no_acces'),
									length 	= 5500
								})
							end
						end, GetPlayerServerId(PlayerId()))
					end
				end
				
				
				if IsInPrisonShopZone(coords) then
					if ESX.GetPlayerData().job.name == Config.InventoryJob.Police then
						OpenShopInv('prison')
					end
				end
				
				if IsInDrugShopZone(coords) then
					OpenShopInv('drugs')
				end
				
				if IsInWeaponShopZone(coords) then
					if Config.UseLicense == true then
						ESX.TriggerServerCallback('esx_license:checkLicense', function(hasWeaponLicense)
							if hasWeaponLicense then
								OpenShopInv('weaponshop')
							else
								exports['t-notify']:Alert({
									style  	=  'error',
									message =  _U('license_check_fail'),
									length 	= 5500
								})
							end
						end, GetPlayerServerId(PlayerId()), Config.License.Weapon)
					else
						OpenShopInv('weaponshop')
					end
				end
				
				if IsInPoliceShopZone(coords) then
					if ESX.GetPlayerData().job.name == Config.InventoryJob.Police and ESX.GetPlayerData().job.grade >= Config.ShopMinimumGradePolice then
						OpenShopInv('policeshop')
					end
				end
				
				if IsInShopNightclubZone(coords) then
					if ESX.GetPlayerData().job.name == Config.InventoryJob.Nightclub and ESX.GetPlayerData().job.grade >= Config.ShopMinimumGradeNightclub then
						OpenShopInv('nightclubshop')
					end
				end
				
				if IsInBlackMarketZone(coords) then
					if ESX.GetPlayerData().job.name == Config.InventoryJob.Mafia and ESX.GetPlayerData().job.grade >= Config.ShopMinimumGradeMafia then
						OpenShopInv('blackmarket')
					end
				end
				
			end
		end
	end
)
]]
RegisterNetEvent("policeshop")
AddEventHandler("policeshop", function()
	Citizen.Wait(100)
	OpenShopInv("policeshop")
end)

RegisterNetEvent("regular")
AddEventHandler("regular", function()
	Citizen.Wait(100)
	OpenShopInv("regular")
end)

RegisterNetEvent("youtool")
AddEventHandler("youtool", function()
	Citizen.Wait(100)
	OpenShopInv("youtool")
end)

RegisterNetEvent("cafe")
AddEventHandler("cafe", function()
	Citizen.Wait(100)
	OpenShopInv("cafe")
end)

RegisterNetEvent("napitki")
AddEventHandler("napitki", function()
	Citizen.Wait(100)
	OpenShopInv("napitki")
end)

RegisterNetEvent("sandvichi")
AddEventHandler("sandvichi", function()
	Citizen.Wait(100)
	OpenShopInv("sandvichi")
end)

RegisterNetEvent("mechanicshop")
AddEventHandler("mechanicshop", function()
	Citizen.Wait(100)
	OpenShopInv('MechanicShop')
end)

RegisterNetEvent("showroom")
AddEventHandler("showroom", function()
	Citizen.Wait(100)
	OpenShopInv('Showroom')
end)


function OpenShopInv(shoptype)
	text = _('store')
	data = {text = text}
	inventory = {}
	ESX.TriggerServerCallback('ex-inventory:getShopItems', function(shopInv)
		for i = 1, #shopInv, 1 do
			table.insert(inventory, shopInv[i])
		end
		TriggerEvent('ex-inventory:openShopInventory', data, inventory)
	end, shoptype)
end

RegisterNetEvent('ex-inventory:OpenCustomShopInventory')
AddEventHandler('ex-inventory:OpenCustomShopInventory', function(type, shopinventory)
	text = _('store')
	data = {text = text}
	inventory = {}
	ESX.TriggerServerCallback('ex-inventory:getCustomShopItems', function(shopInv)
		for i = 1, #shopInv, 1 do
			table.insert(inventory, shopInv[i])
		end
		TriggerEvent('ex-inventory:openShopInventory', data, inventory)
	end, type, shopinventory)
end)

RegisterNetEvent('ex-inventory:openShopInventory')
AddEventHandler('ex-inventory:openShopInventory', function(data, inventory)
	setShopInventoryData(data, inventory, weapons)
	openShopInventory()
end)

function setShopInventoryData(data, inventory)
	shopData = data
	SendNUIMessage({
		action = 'setInfoText',
		text = data.text
	})
	items = {}
	SendNUIMessage({
		action = 'setShopInventoryItems',
		itemList = inventory
	})
end

function openShopInventory()
	loadPlayerInventory()
	isInInventory = true
	SendNUIMessage({
		action = 'display',
		type = 'shop'
	})
	SetNuiFocus(true, true)
end

RegisterNUICallback('TakeFromShop', function(data, cb)
	if IsPedSittingInAnyVehicle(playerPed) then
		return
	end
	if type(data.number) == 'number' and math.floor(data.number) == data.number then
		TriggerServerEvent('ex-inventory:SellItemToPlayer', GetPlayerServerId(PlayerId()), data.item.type, data.item.name, tonumber(data.number))
	end
	Wait(0)
	loadPlayerInventory()
	cb('ok')
end)

RegisterNetEvent('ex-inventory:AddAmmoToWeapon')
AddEventHandler('ex-inventory:AddAmmoToWeapon', function(hash, amount)
	AddAmmoToPed(PlayerPedId(), hash, amount)
end)


function IsInIlegalShopZone(coords)
	IlegalShop = Config.Shops.IlegalShop.Locations
	for i = 1, #IlegalShop, 1 do
		if GetDistanceBetweenCoords(coords, IlegalShop[i].x, IlegalShop[i].y, IlegalShop[i].z, true) < 1.5 then
			return true
		end
	end
	return false
end

function IsInDrugShopZone(coords)
	DrugShop = Config.Shops.DrugShop.Locations
	for i = 1, #DrugShop, 1 do
		if GetDistanceBetweenCoords(coords, DrugShop[i].x, DrugShop[i].y, DrugShop[i].z, true) < 1.5 then
			return true
		end
	end
	return false
end


function IsInGroothandelSupermarktZone(coords)
	GroothandelSupermarkt = Config.Shops.GroothandelSupermarkt.Locations
	for i = 1, #GroothandelSupermarkt, 1 do
		if GetDistanceBetweenCoords(coords, GroothandelSupermarkt[i].x, GroothandelSupermarkt[i].y, GroothandelSupermarkt[i].z, true) < 1.5 then
			return true
		end
	end
	return false
end

function IsInPrisonShopZone(coords)
	PrisonShop = Config.Shops.PrisonShop.Locations
	for i = 1, #PrisonShop, 1 do
		if GetDistanceBetweenCoords(coords, PrisonShop[i].x, PrisonShop[i].y, PrisonShop[i].z, true) < 1.5 then
			return true
		end
	end
	return false
end

function IsInWeaponShopZone(coords)
	WeaponShop = Config.Shops.WeaponShop.Locations
	for i = 1, #WeaponShop, 1 do
		if GetDistanceBetweenCoords(coords, WeaponShop[i].x, WeaponShop[i].y, WeaponShop[i].z, true) < 1.5 then
			return true
		end
	end
	return false
end

function IsInPoliceShopZone(coords)
	PoliceShop = Config.Shops.PoliceShop.Locations
	for i = 1, #PoliceShop, 1 do
		if GetDistanceBetweenCoords(coords, PoliceShop[i].x, PoliceShop[i].y, PoliceShop[i].z, true) < 1.5 then
			return true
		end
	end
	return false
end

function IsInBlackMarketZone(coords)
	BlackMarket = Config.Shops.BlackMarket.Locations
	for i = 1, #BlackMarket, 1 do
		if GetDistanceBetweenCoords(coords, BlackMarket[i].x, BlackMarket[i].y, BlackMarket[i].z, true) < 1.5 then
			return true
		end
	end
	return false
end

function IsInShopNightclubZone(coords)
	ShopNightclub = Config.Shops.ShopNightclub.Locations
	for i = 1, #ShopNightclub, 1 do
		if GetDistanceBetweenCoords(coords, ShopNightclub[i].x, ShopNightclub[i].y, ShopNightclub[i].z, true) < 1.5 then
			return true
		end
	end
	return false
end

function IsInShopNightclubZone(coords)
	ShopNightclub = Config.Shops.ShopNightclub.Locations
	for i = 1, #ShopNightclub, 1 do
		if GetDistanceBetweenCoords(coords, ShopNightclub[i].x, ShopNightclub[i].y, ShopNightclub[i].z, true) < 1.5 then
			return true
		end
	end
	return false
end

Citizen.CreateThread(function()
	player = PlayerPedId()
	coords = GetEntityCoords(player)
	if Config.ShowRegularShopBlip then
		for k, v in pairs(Config.Shops.RegularShop.Locations) do
			CreateBlip(vector3(Config.Shops.RegularShop.Locations[k].x, Config.Shops.RegularShop.Locations[k].y, Config.Shops.RegularShop.Locations[k].z ), _U('regular_shop_name'), 3.0, Config.Color, Config.ShopBlipID)
		end
	end
	if Config.ShowGroothandelSupermarktBlip then
		for k, v in pairs(Config.Shops.GroothandelSupermarkt.Locations) do
			CreateBlip(vector3(Config.Shops.GroothandelSupermarkt.Locations[k].x, Config.Shops.GroothandelSupermarkt.Locations[k].y, Config.Shops.GroothandelSupermarkt.Locations[k].z ), _U('regular_shop_name'), 3.0, Config.Color, Config.ShopBlipID)
		end
	end

	if Config.ShowRobsLiquorBlip then
		for k, v in pairs(Config.Shops.RobsLiquor.Locations) do
			CreateBlip(vector3(Config.Shops.RobsLiquor.Locations[k].x, Config.Shops.RobsLiquor.Locations[k].y, Config.Shops.RobsLiquor.Locations[k].z ), _U('robs_liquor_name'), 3.0, Config.Color, Config.LiquorBlipID)
		end
	end

	if Config.ShowYouToolBlip then
		for k, v in pairs(Config.Shops.YouTool.Locations) do
			CreateBlip(vector3(Config.Shops.YouTool.Locations[k].x, Config.Shops.YouTool.Locations[k].y, Config.Shops.YouTool.Locations[k].z ), _U('you_tool_name'), 3.0, Config.Color, Config.YouToolBlipID)
		end
	end

	if Config.ShowPrisonShopBlip then
		for k, v in pairs(Config.Shops.PrisonShop.Locations) do
			CreateBlip(vector3(Config.Shops.PrisonShop.Locations[k].x, Config.Shops.PrisonShop.Locations[k].y, Config.Shops.PrisonShop.Locations[k].z), _U('prison_shop_name'), 3.0, Config.Color, Config.PrisonShopBlipID)
		end
	end

	if Config.ShowWeaponShopBlip then
		for k, v in pairs(Config.Shops.WeaponShop.Locations) do
			CreateBlip(vector3(Config.Shops.WeaponShop.Locations[k].x, Config.Shops.WeaponShop.Locations[k].y, Config.Shops.WeaponShop.Locations[k].z), _U('weapon_shop_name'), 3.0, Config.WeaponColor, Config.WeaponShopBlipID)
		end
	end

	if Config.ShowPoliceShopBlip then
		for k, v in pairs(Config.Shops.PoliceShop.Locations) do
			CreateBlip(vector3(Config.Shops.PoliceShop.Locations[k].x, Config.Shops.PoliceShop.Locations[k].y, Config.Shops.PoliceShop.Locations[k].z), _U('police_shop_name'), 3.0, Config.WeaponColor, Config.PoliceShopBlipID)
		end
	end

	if Config.ShowNightclubShopBlip then
		for k, v in pairs(Config.Shops.ShopNightclub.Locations) do
			CreateBlip(vector3(Config.Shops.ShopNightclub.Locations[k].x, Config.Shops.ShopNightclub.Locations[k].y, Config.Shops.ShopNightclub.Locations[k].z), _U('nightclub_shop_name'), 3.0, Config.WeaponColor, Config.NightclubShopBlipID)
		end
	end

	if Config.ShowBlackMarketBlip then
		for k, v in pairs(Config.Shops.BlackMarket.Locations) do
			CreateBlip(vector3(Config.Shops.BlackMarket.Locations[k].x, Config.Shops.BlackMarket.Locations[k].y, Config.Shops.BlackMarket.Locations[k].z), _U('blackmarket_shop_name'), 3.0, Config.WeaponColor, Config.BlackMarketBlipID)
		end
	end

	if Config.ShowDrugShopBlip then
		for k, v in pairs(Config.Shops.DrugShop.Locations) do
			CreateBlip(vector3(Config.Shops.DrugShop.Locations[k].x, Config.Shops.DrugShop.Locations[k].y, Config.Shops.DrugShop.Locations[k].z), _U('drug_shop_name'), 3.0, Config.WeaponColor, Config.DrugShopBlipID)
		end
	end

	-- if Config.ShowIllegalShopBlip then
	-- 	for k, v in pairs(Config.Shops.IlegalShop.Locations) do
	-- 		CreateBlip(vector3(Config.Shops.IlegalShop.Locations[k].x, Config.Shops.IlegalShop.Locations[k].y, Config.Shops.IlegalShop.Locations[k].z), _U('blackmarket_shop_name'), 3.0, Config.WeaponColor, Config.IllegalShopBlipID)
	-- 	end
	-- end
end)

function OpenBuyLicenseMenu()
	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop_license',{
	title = _U('license_shop_title'),
		elements = {
			{ label = _U('yes') ..' (€' .. Config.LicensePrice ..')', value = 'yes' },
			{ label = _U('no'), value = 'no' },
		}
	},
	function (data, menu)
		if data.current.value == 'yes' then
			ESX.TriggerServerCallback('ex-inventory:buyLicense', function(bought)
				if bought then
					menu.close()
				end
			end)
		end
	end,
	function (data, menu)
		menu.close()
	end)
end

function DrawText3Ds(x, y, z, text)
	local onScreen,_x,_y=World3dToScreen2d(x,y,z)
	local scale = 0.3
	if onScreen then
		SetTextScale(scale, scale)
		SetTextFont(6)
		SetTextProportional(1)
		SetTextColour(255, 255, 255, 215)
		SetTextOutline()
		SetTextEntry('STRING')
		SetTextCentre(1)
		AddTextComponentString(text)
		DrawText(_x,_y)
	end
end

function CreateBlip(coords, text, radius, color, sprite)
	local blip = AddBlipForCoord(coords)
	SetBlipSprite(blip, sprite)
	SetBlipColour(blip, color)
	SetBlipScale(blip, 0.6)
	SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName('STRING')
	AddTextComponentString(text)
	EndTextCommandSetBlipName(blip)
end
