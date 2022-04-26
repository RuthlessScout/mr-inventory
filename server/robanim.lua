RegisterServerEvent('robo:jugador')
AddEventHandler('robo:jugador', function(targetid, playerheading, playerCoords,  playerlocation)
	_source = source

	TriggerClientEvent('robo:getarrested', targetid, playerheading, playerCoords, playerlocation)
	TriggerClientEvent('robo:doarrested', _source)
end)
