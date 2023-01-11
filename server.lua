-- Function to check if a user has a certain license
function hasLicense(player, license)
    local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {
        ['@identifier'] = player
    })

    for k,v in ipairs(result) do
        if v.license == license then
            return true
        end
    end

    return false
end

-- Function to use an item to heal nearby players
function useItem(player, item)
    if hasLicense(player.identifier, "healer") then
        -- Code to use the item and heal nearby players goes here
    else
        player.notify("You do not have the necessary license to use this item.")
    end
end

-- Register the event for using the item
RegisterServerEvent("useItem")
AddEventHandler("useItem", useItem)
