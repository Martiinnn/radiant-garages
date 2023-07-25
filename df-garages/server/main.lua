

ESX.RegisterServerCallback('difamados:getOwnedCars', function(source, cb)
	local ownedCars = {}
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer then
		MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND Type = @Type', {	
			['@owner']  = xPlayer.identifier,	
			['@Type']   = 'car'
		}, function(data)	
			for _,v in pairs(data) do	
				local vehicle = json.decode(v.vehicle)	
				table.insert(ownedCars, {vehicle = vehicle, stored = v.stored, plate = v.plate})	
			end
			cb(ownedCars)
		end)
	end
end)

ESX.RegisterServerCallback('difamados:getGangCars', function(source, cb)
	local gangCars = {}
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer then
		MySQL.Async.fetchAll('SELECT gang FROM users WHERE identifier = @identifier', {
			['@identifier'] = xPlayer.identifier
		}, function(usersResult)
			local gang = nil 
			if usersResult[1] ~= nil then
				gang = usersResult[1].gang
			end
			if gang then
				MySQL.Async.fetchAll('SELECT vehicles FROM roda_gangs WHERE name = @gang', {	
					['@gang'] = gang
				}, function(data)
					if data[1] and data[1].vehicles then
						local vehiclesData = json.decode(data[1].vehicles)
						for _, vehicleInfo in ipairs(vehiclesData) do
							table.insert(gangCars, vehicleInfo.name)
						end
					end
					cb(gangCars)
				end)
			end
		end)
	end
end)

ESX.RegisterServerCallback("difamados:getbanda",function(source,cb)
	local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.fetchAll('SELECT gang FROM users WHERE identifier = @identifier', {
        ['@identifier'] = xPlayer.identifier
    }, function(usersResult)
        if usersResult[1] ~= nil then
            local gang = usersResult[1].gang
			cb(gang)
        else
			cb(nil)
        end
    end)
end)
