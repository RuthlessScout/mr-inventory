local using = false

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(120)
		local currentWeapon = GetSelectedPedWeapon(PlayerPedId())
		DisplayAmmoThisFrame(currentWeapon)
	end
end)

RegisterNetEvent('ammunition:useAmmoItem')
AddEventHandler('ammunition:useAmmoItem', function(ammo)
	local playerPed = PlayerPedId()
	local weapon
	local found, currentWeapon = GetCurrentPedWeapon(playerPed, true)
	if found then
		for _, v in pairs(ammo.weapons) do
			local weaponHash = GetHashKey(v)
			if currentWeapon == weaponHash then
				weapon = v
				break
			end
		end
		if weapon ~= nil then
			local pedAmmo = GetAmmoInPedWeapon(playerPed, weapon)
			local newAmmo = pedAmmo + ammo.count
			ClearPedTasks(playerPed)
			local found, maxAmmo = GetMaxAmmo(playerPed, weapon)
			--print(weapon)
			if newAmmo < maxAmmo then
				local hash = GetHashKey(weapon)
				--print(hash)
				ESX.TriggerServerCallback('ex-inventory:getAmmoCount', function(gunInfo)
					currentWepAttachs = gunInfo.attachments
				end, hash)
				ESX.TriggerServerCallback('ex-inventory:doesWeaponHas', function(hasWeaponId)
					if hasWeaponId then
						weaponKey = hasWeaponId
						--print(weaponKey)
					else
						weaponKey = GenerateWeapon()
						--print(weaponKey)
					end
				end, hash)
				while weaponKey == nil do
				Wait(0)
				end
				local wepInfo = { 
					count = newAmmo,
					attach = currentWepAttachs or '{}',
					weapon_id = weaponKey
				}
				if using then
					TriggerEvent("DoLongHudText", "Не абюзвай, моля та!", 1)
				else
					TriggerServerEvent('ex-inventory:updateAmmoCount', hash, wepInfo)
					using = true
				exports['pogressBar']:drawBar(3000, 'Презареждане')
				TaskReloadWeapon(playerPed)
				Citizen.Wait(3000)
				SetPedAmmo(playerPed, weapon, newAmmo)
				TriggerServerEvent('ammunition:removeAmmoItem', ammo)
				TriggerEvent("DoLongHudText", "Оръжието беше успешно презаредено", 1)
				using = false
				end
			else
				TriggerEvent("DoLongHudText", "Оръжието е пълно", 2)
			end
		end
	end
end)

