local inzone

Citizen.CreateThread(function()
	for index, vectors in pairs(Config.Garages) do
		PolyZone:Create(vectors, { name = "garage_"..index }):onPlayerInOut(function(isPointInside, point)
			inzone = isPointInside and index or nil
		end)
	end

	while true do
		local veh = GetVehiclePedIsIn(PlayerPedId())
		local inVeh = DoesEntityExist(veh)

		if inzone then
			lib.showTextUI('[E] - Garage', {
				position = "left-center",
				icon = 'car',
				iconColor = '#00c717',
				style = {
					backgroundColor = '#1c3324',
				}
			})
        else
			lib.hideTextUI()
		end
		Citizen.Wait(500)
	end
end)

Citizen.CreateThread(function()
	local nextInteract = 0
	while true do
		local wait = 1000
		if inzone then
			wait = 0
			if IsControlJustPressed(0, 38) and GetGameTimer() > nextInteract then
				nextInteract = GetGameTimer() + 1000
				local veh = GetVehiclePedIsIn(PlayerPedId())
				local inVeh = DoesEntityExist(veh)
				
				if inVeh then
					DeleteEntity(veh)
				else
					openMenu()
				end
			end
		end
		Citizen.Wait(wait)
	end
end)

lib.registerContext({
	id = 'pricipal_menu',
	title = 'Garages',
	options = {
		{
			title = 'Garage Personal',
			description = '¡Tus Vehiculos Personales!',
			icon = 'car',
			onSelect = function()
				ListOwnedCarsMenu()
			  end,
		},
		{
			title = 'Garage De Banda',
			description = '¡Tus Vehiculos De Banda!',
			icon = 'gun',
			onSelect = function()
				ListBanda()
			  end,
		},
	}
})