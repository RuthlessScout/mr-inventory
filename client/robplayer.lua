local targetPlayer
local targetPlayerName
local roboestado = false

Citizen.CreateThread(function()
	TriggerEvent("chat:addSuggestion", "/openinventory", _U("openinv_help"), {{name = _U("openinv_id"), help = _U("openinv_help")}})
end)

AddEventHandler( "onResourceStop", function(resource)
	if resource == GetCurrentResourceName() then
		TriggerEvent("chat:removeSuggestion", "/openinventory")
	end
end)

--RegisterNetEvent("ex-inventory:openPlayerInventory")
--AddEventHandler("ex-inventory:openPlayerInventory", function(target, playerName)
--	targetPlayer = target
--	targetPlayerName = playerName
--	setPlayerInventoryData()
--	openPlayerInventory()
--	TriggerServerEvent('ex-inventory:disableTargetInv', target)
--end)

RegisterCommand('rob', function(source, args)
	local ped = PlayerPedId()
	if not IsEntityDead(ped) and not IsPedInAnyVehicle(ped, true) then
		  robo()
	end
end)


function robo()
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	local ped = PlayerPedId()

	if closestPlayer ~= -1 and closestDistance <= 1.5 then
		local target, distance = ESX.Game.GetClosestPlayer()
		playerheading = GetEntityHeading(GetPlayerPed(-1))
		playerlocation = GetEntityForwardVector(PlayerPedId())
		playerCoords = GetEntityCoords(GetPlayerPed(-1))
		local target_id = GetPlayerServerId(target)
		local searchPlayerPed = GetPlayerPed(target)

		if distance <= 1.5 then
			if IsPedInAnyVehicle(searchPlayerPed, true) then
				ESX.ShowNotification(_U('victim_in_vehicle'))
				return
			end
			if (IsEntityPlayingAnim(searchPlayerPed, 'random@mugging3', 'handsup_standing_base', 3) and IsPedArmed(ped, 7)) or IsEntityDead(searchPlayerPed) then
				TriggerServerEvent('robo:jugador', target_id, playerheading, playerCoords, playerlocation)
				--Citizen.Wait(4500)
			else
				--exports['mythic_notify']:DoCustomHudText('error', "Victim don't have his hands up.")
				ESX.ShowNotification(_U('victim_no_hands_up'))	
			end
		end
	else
		 --exports['mythic_notify']:DoCustomHudText('error', 'No Players Nearby')
		 ESX.ShowNotification(_U('no1_nearby'))	
    end
end


RegisterNetEvent('robo:getarrested')
AddEventHandler('robo:getarrested', function(playerheading, playercoords, playerlocation)
	playerPed = GetPlayerPed(-1)

if not IsEntityDead(playerPed) then
	roboestado = true
	TriggerEvent('ex-inventory:removeCurrentWeapon')
	local x, y, z   = table.unpack(playercoords + playerlocation * 0.85)
	SetEntityCoords(GetPlayerPed(-1), x, y, z-0.50)
	SetEntityHeading(GetPlayerPed(-1), playerheading)
	Citizen.Wait(250)
	loadanimdict('random@mugging3')
	TaskPlayAnim(GetPlayerPed(-1), 'random@mugging3', 'handsup_standing_base', 8.0, -8, -1, 49, 0.0, false, false, false)
	roboestado = true
	Citizen.Wait(12500)
	roboestado = false
end
end)

RegisterNetEvent('robo:doarrested')
AddEventHandler('robo:doarrested', function()
	local target, distance = ESX.Game.GetClosestPlayer()
	Citizen.Wait(250)
if not IsEntityDead(GetPlayerPed(target)) then
	loadanimdict('combat@aim_variations@arrest')
	--TaskPlayAnim(GetPlayerPed(-1), 'combat@aim_variations@arrest', 'cop_med_arrest_01', 8.0, -8,3750, 2, 0, 0, 0, 0)
	exports['mythic_progbar']:Progress({
		name = "Rob",
		duration = 3500,
		label = _U('stealing'),
		useWhileDead = false,
		canCancel = false,
		controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        },
		animation = {
            animDict = "combat@aim_variations@arrest",
			anim = "cop_med_arrest_01",
			flags = 0,
			task = nil,
        },
		prop = {},
	}, function(status)
		if not status then 
			TriggerEvent("ex-inventory:openPlayerInventory", GetPlayerServerId(target), GetPlayerName(target))
		end
	end)
else
	TriggerEvent('ex-inventory:removeCurrentWeapon')
	--loadanimdict("amb@medic@standing@timeofdeath@idle_a")
	exports['mythic_progbar']:Progress({
		name = "Rob",
		duration = 20000,
		label = _U('stealing'),
		useWhileDead = false,
		canCancel = false,
		controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        },
		animation = {},
		prop = {},
	}, function(status)
		if not status then 
			TriggerEvent("ex-inventory:openPlayerInventory", GetPlayerServerId(target), GetPlayerName(target))
		end
	end)
end
end)
function loadanimdict(dictname)
	if not HasAnimDictLoaded(dictname) then
		RequestAnimDict(dictname) 
		while not HasAnimDictLoaded(dictname) do 
			Citizen.Wait(1)
		end
	end
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()

		if roboestado then
			DisableControlAction(0, 2, true) -- Disable tilt
			DisableControlAction(0, 24, true) -- Attack
			DisableControlAction(0, 257, true) -- Attack 2
			DisableControlAction(0, 25, true) -- Aim
			DisableControlAction(0, 263, true) -- Melee Attack 1
			DisableControlAction(0, 32, true) -- W
			DisableControlAction(0, 34, true) -- A
			DisableControlAction(0, 31, true) -- S
			DisableControlAction(0, 30, true) -- D
			DisableControlAction(0, 45, true) -- Reload
			DisableControlAction(0, 22, true) -- Jump
			DisableControlAction(0, 44, true) -- Cover
			DisableControlAction(0, 37, true) -- Select Weapon
			DisableControlAction(0, 23, true) -- Also 'enter'?
			DisableControlAction(0, 24, true) -- Attack
			DisableControlAction(0, 257, true) -- Attack 2
		    DisableControlAction(0, 263, true) -- Melee Attack 1
	        DisableControlAction(0, 217, true) -- Also 'enter'?
		    DisableControlAction(0, 137, true) -- Also 'enter'?		
			DisableControlAction(0, 288,  true) -- Disable phone
			DisableControlAction(0, 289, true) -- Inventory
			DisableControlAction(0, 170, true) -- Animations
			DisableControlAction(0, 167, true) -- Job
			DisableControlAction(0, 0, true) -- Disable changing view
			DisableControlAction(0, 26, true) -- Disable looking behind
			DisableControlAction(0, 73, true) -- Disable clearing animation
			DisableControlAction(2, 199, true) -- Disable pause screen
			DisableControlAction(0, 59, true) -- Disable steering in vehicle
			DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
			DisableControlAction(0, 72, true) -- Disable reversing in vehicle
			DisableControlAction(2, 36, true) -- Disable going stealth
			DisableControlAction(0, 47, true)  -- Disable weapon
			DisableControlAction(0, 264, true) -- Disable melee
			DisableControlAction(0, 257, true) -- Disable melee
			DisableControlAction(0, 140, true) -- Disable melee
			DisableControlAction(0, 141, true) -- Disable melee
			DisableControlAction(0, 142, true) -- Disable melee
			DisableControlAction(0, 143, true) -- Disable melee
			DisableControlAction(0, 75, true)  -- Disable exit vehicle
			DisableControlAction(27, 75, true) -- Disable exit vehicle

			if IsEntityPlayingAnim(playerPed, 'random@mugging3', 'handsup_standing_base', 3) ~= 1 then
				 ESX.Streaming.RequestAnimDict('random@mugging3', function()
				 TaskPlayAnim(playerPed, 'random@mugging3', 'handsup_standing_base', 8.0, -8, -1, 49, 0.0, false, false, false)
						
				end)
			end
		else
			Citizen.Wait(500)
		end 
	end
end)

function refreshPlayerInventory()
	setPlayerInventoryData()
end

function setPlayerInventoryData()
	ESX.TriggerServerCallback("ex-inventory:getPlayerInventory", function(data)
		SendNUIMessage({
			action = "setInfoText",
			text = "<strong>" .. _U("player_inventory") .. "</strong><br>" .. targetPlayerName .. " (" .. targetPlayer .. ")"
		})

		items = {}
		inventory = data.inventory
		accounts = data.accounts
		money = data.money
		weapons = data.weapons

		if Config.IncludeCash and money ~= nil and money > 0 then
			moneyData = {
				label = _U("cash"),
				name = "cash",
				type = "item_money",
				count = money,
				usable = false,
				rare = false,
				weight = -1,
				canRemove = true
			}
			table.insert(items, moneyData)
		end

		if Config.IncludeAccounts and accounts ~= nil then
			for key, value in pairs(accounts) do
				if not shouldSkipAccount(accounts[key].name) then
					local canDrop = accounts[key].name ~= "bank"
					if accounts[key].money > 0 then
						accountData = {
							label = accounts[key].label,
							count = accounts[key].money,
							type = "item_account",
							name = accounts[key].name,
							usable = false,
							rare = false,
							weight = -1,
							canRemove = canDrop
						}
						table.insert(items, accountData)
					end
				end
			end
		end

		if inventory ~= nil then
			for key, value in pairs(inventory) do
				if inventory[key].count <= 0 then
					inventory[key] = nil
				else
					inventory[key].type = "item_standard"
					table.insert(items, inventory[key])
				end
			end
		end

		SendNUIMessage({
			action = "setSecondInventoryItems",
			itemList = items
		})
	end, targetPlayer)
end

function openPlayerInventory()
	loadPlayerInventory()
	isInInventory = true
	SendNUIMessage({
		action = "display",
		type = "player"
	})
	SetNuiFocus(true, true)
end

RegisterNUICallback("PutIntoPlayer", function(data, cb)
	if IsPedSittingInAnyVehicle(playerPed) then
		return
	end
	if type(data.number) == "number" and math.floor(data.number) == data.number then
		local count = tonumber(data.number)
		TriggerServerEvent("ex-inventory:tradePlayerItem", GetPlayerServerId(PlayerId()), targetPlayer, data.item.type, data.item.name, count)
	end
	Wait(250)
	refreshPlayerInventory()
	loadPlayerInventory()
	cb("ok")
end)

RegisterNUICallback("TakeFromPlayer", function(data, cb)
	if IsPedSittingInAnyVehicle(playerPed) then
		return
	end
	if type(data.number) == "number" and math.floor(data.number) == data.number then
		local count = tonumber(data.number)
		TriggerServerEvent("ex-inventory:tradePlayerItem", targetPlayer, GetPlayerServerId(PlayerId()), data.item.type, data.item.name, count)
	end
	Wait(250)
	refreshPlayerInventory()
	loadPlayerInventory()
	cb("ok")
end)
