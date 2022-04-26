local vaultType = {}

Citizen.CreateThread(function()
	while ESX == nil or PlayerData == nil or PlayerData.job == nil do
		Citizen.Wait(120)
	end
	for k,v in pairs(Config.Vault) do
		if v.show == true then
			ESX.Game.SpawnLocalObject(Config.VaultBox, v.coords, function(obj)
				SetEntityHeading(obj, v.heading)
				PlaceObjectOnGroundProperly(obj)
				FreezeEntityPosition(obj, true)
			end)
		else
		end
	end
end)

--[[RegisterNetEvent('esx:setClub')
AddEventHandler('esx:setClub', function(club)
	--print('setclub', a,b)
	PlayerData.club = club
end)]]

function OpenVaultInventoryMenu(data)
	--if (data.job == PlayerData.job.name and PlayerData.job.grade > 1) or data.job == 'vault' or (data.job == PlayerData.club.name and PlayerData.club.grade == '3') or (data.job == PlayerData.club.name and PlayerData.club.grade == '4') then
	if (data.job == PlayerData.job.name and PlayerData.job.grade > 1) or data.job == 'vault' then
		--print(data.needItemLicense)
		vaultType = data
		ESX.TriggerServerCallback("ex-inventory:getVaultInventory", function(inventory)
			if not inventory then
				TriggerEvent("DoShortHudText", _U('not_found'), 2)
			else
				TriggerEvent("ex-inventory:openVaultInventory", inventory)
			end
		end,
		data)
	else
		TriggerEvent("DoShortHudText", _U('no_key'), 2)
		Citizen.Wait(0)
	end
end

function getMonsterVaultLicense()
	return vaultType
end
RegisterKey('keyboard', 'E', 
	function()
	end,
	-- on release
	function()
		local coords = GetEntityCoords(PlayerPedId())
		for k,v in pairs(Config.Vault) do
			local dist = GetDistanceBetweenCoords(coords, v.coords, true)
			if dist < 1.5 then
				OpenVaultInventoryMenu({job = k, needItemLicense = v.needItemLicense, InfiniteLicense = v.InfiniteLicense})
			end
		end
	end
)