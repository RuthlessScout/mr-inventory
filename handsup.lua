local handsup = false
local dict = "random@mugging3"

Citizen.CreateThread(function()
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(100)
	end
    
	while true do
		Citizen.Wait(0)
		if handsup then
			local lPed = GetPlayerPed(-1)
				DisablePlayerFiring(lPed, true)
				DisableControlAction(0, 25, true)
				DisableControlAction(1, 140, true)
				DisableControlAction(1, 141, true)
				DisableControlAction(1, 142, true)
				SetPedPathCanUseLadders(lPed, false)
				if IsPedInAnyVehicle(lPed, false) then
					DisableControlAction(0, 59, true)
				end
		end
    end
end)
	
RegisterCommand('handsup', function()
	if not handsup then
		if IsPedOnFoot(GetPlayerPed(-1)) then
			handsup = true
			TaskPlayAnim(GetPlayerPed(-1), dict, "handsup_standing_base", 8.0, 8.0, -1, 51, 0, false, false, false)
			SetCurrentPedWeapon(lPed, 0xA2719263, true)
		end
	else
		if IsPedOnFoot(GetPlayerPed(-1)) then
			handsup = false
			ClearPedTasks(GetPlayerPed(-1))
			SetCurrentPedWeapon(lPed, 0xA2719263, true)
		end
	end
end, false)

RegisterKeyMapping('handsup', 'Hands Up', 'keyboard', 'EQUALS')