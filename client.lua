
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


RegisterNetEvent('NoName:vintest3')
AddEventHandler('NoName:vintest3', function(x, y, z)
	exports['progressbar']:Progress({
		name = "vintest",
		duration = 15000,
		label = Config.Locale['check_vehicle_exhaust'],
		useWhileDead = false,
		canCancel = false,
		controlDisables = {
			disableMovement = true,
			disableCarMovement = true,
			disableMouse = false,
			disableCombat = true,
		},
		animation = {
			animDict = "random@train_tracks",
			anim = "idle_e",
			flags = 49,
		},
		prop = {},
		propTwo = {}
	}, function(cancelled)
		if not cancelled then
			-- finished
		else
			-- cancelled
		end
	end)
end)

-- PRÜF SYSTEM
lib.registerContext({
    id = 'pruefitem',
    title = Config.Locale['menu_title'],
    options = (function()
        local menuOptions = {}

        if Config.MenuOptions.exhaust then
            table.insert(menuOptions, {
                title = Config.Locale['check_vehicle_exhaust'],
                icon = 'car-burst',
                event = 'gj:2steptestermenuit',
                description = Config.Locale['check_vehicle_exhaust']
            })
        end

        if Config.MenuOptions.illegal_tuning then
            table.insert(menuOptions, {
                title = Config.Locale['check_illegal_tuning'],
                icon = 'car',
                event = 'gj:illegalestuningtester',
                description = Config.Locale['check_illegal_tuning']
            })
        end

        if Config.MenuOptions.tuev then
            table.insert(menuOptions, {
                title = Config.Locale['check_tuev'],
                icon = 'square-check',
                event = 'gj:tuevtest',
                description = Config.Locale['check_tuev']
            })
        end

        if Config.MenuOptions.vin then
            table.insert(menuOptions, {
                title = Config.Locale['check_vin'],
                icon = 'hashtag',
                event = 'gj:vintestermenuitem',
                description = Config.Locale['check_vin']
            })
        end

        return menuOptions
    end)()
})



RegisterNetEvent("gj:2steptestermenuit")
AddEventHandler('gj:2steptestermenuit', function()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local closestVehicle, closestDistance = ESX.Game.GetClosestVehicle(playerCoords)

    if closestVehicle ~= nil and closestDistance < 5.0 then
        local vehiclePlate = GetVehicleNumberPlateText(closestVehicle)
		TriggerEvent('NoName:vintest', source)
    	Citizen.Wait(4000)
        TriggerServerEvent('gj:checkVehiclePlate2', vehiclePlate)
    else
        notify('Information', Config.Locale['no_vehicle_found'], 'warning')
    end
end)

RegisterNetEvent('gj:2steptesterresult')
AddEventHandler('gj:2steptesterresult', function(result)
    if result == false then
        notify('Information', Config.Locale['exhaust_ok'], 'success')
    elseif result == true then
        notify('Information', Config.Locale['exhaust_modified'], 'error')
    else
        notify('Information', Config.Locale['exhaust_ok'], 'success')
    end
end)

RegisterNetEvent('gj:illegalestuningtester')
AddEventHandler('gj:illegalestuningtester', function()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local closestVehicle, closestDistance = ESX.Game.GetClosestVehicle(playerCoords)

    if closestVehicle ~= nil and closestDistance < 5.0 then
        local vehiclePlate = GetVehicleNumberPlateText(closestVehicle)
		TriggerEvent('NoName:vintest3', source)
    	Citizen.Wait(15000)
        TriggerServerEvent('gj:checkIllegalParts', vehiclePlate)
    else
        notify('Information', Config.Locale['no_vehicle_found'], 'warning')
    end
end)

RegisterNetEvent('gj:ituningresult')
AddEventHandler('gj:ituningresult', function(result, illegalPartsStr)
    if result then
		local alertIllegalParts = lib.alertDialog({
			header = 'Untersuchungsergebnisse:',
			content = Config.Locale['illegal_parts_found'] .. illegalPartsStr,
			centered = true,
			cancel = false
		})
		print(alertIllegalParts)
    else
        notify('Information', Config.Locale['no_illegal_parts'], 'success')
    end
end)

RegisterNetEvent('gj:tuevtest')
AddEventHandler('gj:tuevtest', function()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local closestVehicle, closestDistance = ESX.Game.GetClosestVehicle(playerCoords)

    if closestVehicle ~= nil and closestDistance < 5.0 then
        local vehiclePlate = GetVehicleNumberPlateText(closestVehicle)
		TriggerEvent('NoName:vintest', source)
    	Citizen.Wait(4000)
        TriggerServerEvent('esx_tuev:checkVehicleForTUEV', vehiclePlate)
    else
        notify('Information', Config.Locale['no_vehicle_found'], 'warning')
    end
end)




function notify(title, message, type)
	if Config.NotifySystem == 'okokNotify' then
		exports['okokNotify']:Alert(title, message, 5000, type)
	elseif Config.NotifySystem == 'mythic_notify' then
		-- Beispiel für Mythic Notify
		exports['mythic_notify']:SendAlert(type, message)
	elseif Config.NotificationType == 'custom' then
        -- add own
    end
end
