ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


ESX.RegisterUsableItem(Config.UsableItem, function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent('gj:testitem', source)
end)

RegisterServerEvent('gj:checkVehiclePlate2')
AddEventHandler('gj:checkVehiclePlate2', function(vehiclePlate)
    local xPlayer = ESX.GetPlayerFromId(source)

    MySQL.Async.fetchAll('SELECT twostep, owner FROM owned_vehicles WHERE plate=@plate', {
        ['@plate'] = vehiclePlate
    }, function(result)
        if result and #result > 0 then
            local twostepValue = tonumber(result[1].twostep)
            local ownerIdentifier = result[1].owner

            if twostepValue == 0 then
                NotifyPlayer(xPlayer.source, Config.Locale['vehicle_not_modified'], 'info')
            elseif twostepValue == 1 then
                if ownerIdentifier == xPlayer.identifier then
                    NotifyPlayer(xPlayer.source, Config.Locale['vehicle_owned'], 'success')
                else
                    NotifyPlayer(xPlayer.source, Config.Locale['vehicle_not_owned'], 'error')
                end
            else
                NotifyPlayer(xPlayer.source, Config.Locale['invalid_twostep_value'], 'error')
            end
        else
            NotifyPlayer(xPlayer.source, Config.Locale['vehicle_not_found'], 'error')
        end
    end)
end)

RegisterServerEvent('gj:checkIllegalParts')
AddEventHandler('gj:checkIllegalParts', function(vehiclePlate)
    local xPlayer = ESX.GetPlayerFromId(source)

    MySQL.Async.fetchAll('SELECT * FROM vehicle_parts WHERE plate = @plate', {
        ['@plate'] = vehiclePlate
    }, function(result)
        if result and result[1] then
            local illegalParts = {}

            for _, part in pairs(result) do
                for illegalPart, displayName in pairs(illegalPartsList) do
                    if string.find(part.parts, illegalPart) then
                        table.insert(illegalParts, displayName)
                    end
                end
            end

            if #illegalParts > 0 then
                local illegalPartsStr = table.concat(illegalParts, ', ')
                NotifyPlayer(xPlayer.source, Config.Locale['illegal_parts_found'] .. illegalPartsStr, 'error')
            else
                NotifyPlayer(xPlayer.source, Config.Locale['no_illegal_parts'], 'info')
            end
        else
            NotifyPlayer(xPlayer.source, Config.Locale['no_illegal_parts'], 'info')
        end
    end)
end)

function NotifyPlayer(playerId, message, messageType)
    if Config.NotificationType == 'okokNotify' then
        TriggerClientEvent('okokNotify:Alert', playerId, 'Information', message, 5000, messageType)
    elseif Config.NotificationType == 'esx' then
        TriggerClientEvent('esx:showNotification', playerId, message)
    elseif Config.NotificationType == 'custom' then
        -- add own
    end
end
