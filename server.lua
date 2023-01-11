-- Table to store the licenses required for each item
local itemLicenses = {
    ["item1"] = "item1license",
    ["item2"] = "item2license",
    ["item3"] = "item3license",
    -- Add more items and their required licenses here
}

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

-- Function to use an item
function useItem(player, item)
    -- Check if the player has the necessary license for the item
    if hasLicense(player.identifier, itemLicenses[item]) then
        -- Get a list of nearby players
        local players = ESX.GetPlayers()
        for i=1, #players do
            local targetPlayer = ESX.GetPlayerFromId(players[i])
            if targetPlayer.identifier ~= player.identifier then
                -- Heal the player by 40%
                targetPlayer.setHealth(targetPlayer.getHealth() + (targetPlayer.getMaxHealth()*0.4))
                targetPlayer.notify("You have been healed by 40%")
                break
            end
        end
    else
        player.notify("You do not have the necessary license to use this item.")
    end
end

-- Register the event for using the item
RegisterServerEvent("useItem")
AddEventHandler("useItem", useItem)

-- UPDATE CHECKER

local currentVersion = '0.0.1'
local githubApiUrl = 'https://api.github.com/repos/SimpliAj/healitem_esx_baguslicensemanager/releases/latest'

function checkForUpdates()
    -- Use LUA's http library to fetch the latest release information from GitHub
    local response = nil
    local success, response = pcall(function()
        response = json.decode(Get(githubApiUrl))
    end)
    if success then
        local latestVersion = response.tag_name
        -- Compare the current version with the latest version on GitHub
        if currentVersion ~= latestVersion then
            print("A new version of the script is available: " .. latestVersion)
            --Add code to download the new version from github
        else
            print("You are running the latest version of the script.")
        end
    else
        print("Error checking for updates: " .. response)
    end
end

-- call the check for update function
checkForUpdates()

