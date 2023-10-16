Config = {}

-- Load the configuration
local configFile = LoadResourceFile(GetCurrentResourceName(), "config.lua")
assert(load(configFile))()

-- Number of messages allowed in a specific time period
local spamLimit = Config.SpamLimit or 3

-- Cooldown period in milliseconds
local spamCooldown = Config.SpamCooldown or 10000

-- List of group names to exclude from chat spam checks
local excludedGroups = Config.ExcludedGroups or {}

-- List of permission names to exclude from chat spam checks
local excludedPermissions = Config.ExcludedPermissions or {}

local spamChecker = {}

RegisterServerEvent('chatMessage')
AddEventHandler('chatMessage', function(source, name, message)
    if not IsAdminOrExcluded(source) then
        local sourceId = source
        if spamChecker[sourceId] == nil then
            spamChecker[sourceId] = {count = 1, lastMessageTime = GetGameTimer()}
        else
            local currentTime = GetGameTimer()
            local timeDifference = currentTime - spamChecker[sourceId].lastMessageTime

            if timeDifference < spamCooldown then
                spamChecker[sourceId].count = spamChecker[sourceId].count + 1
            else
                spamChecker[sourceId].count = 1
            end

            spamChecker[sourceId].lastMessageTime = currentTime

            if spamChecker[sourceId].count > spamLimit then
                -- Kick the player
                local reason = 'You were kicked for chat spam.'
                DropPlayer(source, reason)
            end
        end
    end
end)

function IsAdminOrExcluded(source)
    local player = GetPlayerIdentifiers(source)


    for _, group in ipairs(excludedGroups) do
        if IsPlayerInGroup(player, group) then
            return true
        end
    end

    -- Example: Check if player has an excluded permission
    for _, permission in ipairs(excludedPermissions) do
        if IsPlayerInPermission(player, permission) then
            return true
        end
    end

    return false
end

function IsPlayerInGroup(player, group)
end

function IsPlayerInPermission(player, permission)
end
