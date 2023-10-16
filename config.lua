Config = {}

-- Number of messages allowed in a specific time period
Config.SpamLimit = 3

-- Cooldown period in milliseconds
Config.SpamCooldown = 100000

-- List of group names to exclude from chat spam checks
Config.ExcludedGroups = {
    "admin",
    "mod"
}

-- List of permission names to exclude from chat spam checks
Config.ExcludedPermissions = {
    "bypass.chatspam"
}
