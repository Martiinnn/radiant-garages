local GarageData
local GangData

function openMenu()
	ESX.TriggerServerCallback('difamados:getbanda', function(gang)
		local bandacl = gang
		if bandacl ~= nil then
			lib.showContext('pricipal_menu')
		else
			ListOwnedCarsMenu()
		end
	end)
end


function ListBanda()

	local GangElements = {}

	local listbanda = GetGangsData()

	if #listbanda == 0 then
        lib.notify({
            title = 'Difamados PVP',
            description = "Tu Banda No Tiene Vehiculos",
            type = 'inform'
        })
    else
        for _, v in pairs(listbanda) do
            local vehgangname = v
			table.insert(GangElements, {
				title = vehgangname,
				onSelect = function()
					local ped = PlayerPedId()
					ESX.Game.SpawnVehicle(vehgangname, GetEntityCoords(ped), GetEntityHeading(ped), function(callback_vehicle)
						SetVehRadioStation(callback_vehicle, "ON")
						TaskWarpPedIntoVehicle(GetPlayerPed(-1), callback_vehicle, -1)
					end)
				end
			})
        end
    end
	lib.registerContext({
        id = 'gang_cars',
        title = "Tus Vehiculos De Banda",
        options = GangElements,
    })
	lib.showContext('gang_cars')
end

function ListOwnedCarsMenu()
    local elements = {}
    local ownedCars = GetData()

    if #ownedCars == 0 then
        lib.notify({
            title = 'Difamados PVP',
            description = "No tienes ningun vehiculo.",
            type = 'inform'
        })
    else
        for _, v in pairs(ownedCars) do
            local hashVehicule = v.vehicle.model
            local aheadVehName = GetDisplayNameFromVehicleModel(hashVehicule)
            local vehicleName = GetLabelText(aheadVehName)
            local plate = v.plate

			table.insert(elements, {
				title = vehicleName,
				description = plate,
				onSelect = function()
					local ped = PlayerPedId()
					ESX.Game.SpawnVehicle(hashVehicule, GetEntityCoords(ped), GetEntityHeading(ped), function(callback_vehicle)
						SetVehRadioStation(callback_vehicle, "ON")
						TaskWarpPedIntoVehicle(GetPlayerPed(-1), callback_vehicle, -1)
                                                SetVehicleNumberPlateText(callback_vehicle, plate)
					end)
				end
			})
        end
    end

    lib.registerContext({
        id = 'owned_cars',
        title = "Tus Vehiculos Personales",
        options = elements,
    })
	lib.showContext('owned_cars')
end

function GetData()
	if GarageData == nil then
		local ndata
		local waiting = true
		ESX.TriggerServerCallback('difamados:getOwnedCars', function(ownedCars)
			ndata = ownedCars
			waiting = false
		end)
		while waiting do Citizen.Wait(20) end
		GarageData = ndata
	end
	return GarageData
end

function GetGangsData()
	if GangData == nil then
		local gdata
		local waiting = true
		ESX.TriggerServerCallback('difamados:getGangCars', function(gangCars)
			gdata = gangCars
			waiting = false
		end)
		while waiting do Citizen.Wait(20) end
		GangData = gdata
	end
	return GangData
end


exports("GetData", GetData)
exports("GetGangVeh", GetGangsData)
