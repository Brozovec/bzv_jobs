-- Roznášení letáků - Serverová část s cooldowny
-- Dependencies: ox_lib, ESX

local ESX = exports['es_extended']:getSharedObject()

-- Úložiště XP hráčů
local playerXP = {}
-- Úložiště cooldownů pro každého hráče
local playerCooldowns = {}

-- Načtení hráčova XP
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    
    if xPlayer then
        local identifier = xPlayer.getIdentifier()
        
        -- Načtení XP z databáze
        MySQL.Async.fetchScalar('SELECT xp FROM flyer_job_xp WHERE identifier = @identifier', {
            ['@identifier'] = identifier
        }, function(xp)
            playerXP[identifier] = xp or 0
            -- Synchronizujeme s klientem
            TriggerClientEvent('flyer_job:updateXP', src, playerXP[identifier])
        end)
        
        -- Načtení cooldownů z databáze
        MySQL.Async.fetchAll('SELECT location_cooldowns FROM flyer_job_cooldowns WHERE identifier = @identifier', {
            ['@identifier'] = identifier
        }, function(result)
            if result and result[1] and result[1].location_cooldowns then
                local cooldowns = json.decode(result[1].location_cooldowns)
                playerCooldowns[identifier] = cooldowns
                TriggerClientEvent('flyer_job:loadCooldowns', src, cooldowns)
            else
                playerCooldowns[identifier] = {}
            end
        end)
    end
end)

-- Uložení hráčova XP
RegisterNetEvent('flyer_job:saveXP')
AddEventHandler('flyer_job:saveXP', function(xp)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    
    if xPlayer then
        local identifier = xPlayer.getIdentifier()
        playerXP[identifier] = xp
        
        -- Uložení do databáze
        MySQL.Async.execute('INSERT INTO flyer_job_xp (identifier, xp) VALUES (@identifier, @xp) ON DUPLICATE KEY UPDATE xp = @xp', {
            ['@identifier'] = identifier,
            ['@xp'] = xp
        })
        
        -- Synchronizujeme s klientem
        TriggerClientEvent('flyer_job:updateXP', src, xp)
    end
end)

-- Uložení cooldownů hráče
RegisterNetEvent('flyer_job:saveCooldowns')
AddEventHandler('flyer_job:saveCooldowns', function(cooldowns)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    
    if xPlayer then
        local identifier = xPlayer.getIdentifier()
        playerCooldowns[identifier] = cooldowns
        
        -- Uložení do databáze jako JSON
        local cooldownsJson = json.encode(cooldowns)
        MySQL.Async.execute('INSERT INTO flyer_job_cooldowns (identifier, location_cooldowns) VALUES (@identifier, @cooldowns) ON DUPLICATE KEY UPDATE location_cooldowns = @cooldowns', {
            ['@identifier'] = identifier,
            ['@cooldowns'] = cooldownsJson
        })
    end
end)

-- Získání cooldownů hráče
RegisterNetEvent('flyer_job:getCooldowns')
AddEventHandler('flyer_job:getCooldowns', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    
    if xPlayer then
        local identifier = xPlayer.getIdentifier()
        TriggerClientEvent('flyer_job:loadCooldowns', src, playerCooldowns[identifier] or {})
    end
end)


lib.callback.register('flyer_job:addMoney', function(source, amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    
    if xPlayer then
        xPlayer.addMoney(amount)
        return true  
    end
    
    return false  
end)

-- Callback pro získání XP hráče
ESX.RegisterServerCallback('flyer_job:getXP', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    
    if xPlayer then
        local identifier = xPlayer.getIdentifier()
        cb(playerXP[identifier] or 0)
    else
        cb(0)
    end
end)

-- Inicializace resource
AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then
        return
    end
    
    -- Vytvoření databázové tabulky pro XP, pokud neexistuje
    MySQL.Async.execute([[
        CREATE TABLE IF NOT EXISTS flyer_job_xp (
            identifier VARCHAR(60) PRIMARY KEY,
            xp INT NOT NULL DEFAULT 0
        )
    ]])
    
    -- Vytvoření databázové tabulky pro cooldowny, pokud neexistuje
    MySQL.Async.execute([[
        CREATE TABLE IF NOT EXISTS flyer_job_cooldowns (
            identifier VARCHAR(60) PRIMARY KEY,
            location_cooldowns LONGTEXT NOT NULL
        )
    ]])

    MySQL.Async.execute([[
        CREATE TABLE IF NOT EXISTS flyer_job_used_routes (
            identifier VARCHAR(60) PRIMARY KEY,
            used_routes LONGTEXT NOT NULL
        )
    ]])
    
    --print('Serverová část práce s letáky inicializována')
end)

-- Serverová část - přidejte tyto funkce do sv_papiry.lua

-- Nový event pro explicitní požadavek na XP
RegisterNetEvent('flyer_job:requestXP')
AddEventHandler('flyer_job:requestXP', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    
    if xPlayer then
        local identifier = xPlayer.getIdentifier()
        
        -- Pokusíme se získat XP z paměti
        if playerXP[identifier] ~= nil then
            TriggerClientEvent('flyer_job:updateXP', src, playerXP[identifier])
           -- print('[Letaky] Odesláno XP z paměti: ' .. playerXP[identifier])
            return
        end
        
        -- Pokud XP není v paměti, načteme ho přímo z databáze
        MySQL.Async.fetchScalar('SELECT xp FROM flyer_job_xp WHERE identifier = @identifier', {
            ['@identifier'] = identifier
        }, function(xp)
            if xp then
                playerXP[identifier] = xp
                TriggerClientEvent('flyer_job:updateXP', src, xp)
               -- print('[Letaky] Odesláno XP z databáze: ' .. xp)
            else
                playerXP[identifier] = 0
                TriggerClientEvent('flyer_job:updateXP', src, 0)
               -- print('[Letaky] Hráč nemá žádné XP v databázi, nastaveno na 0')
            end
        end)
    end
end)

-- Upravená funkce pro callback (přidáno logování a lepší kontroly)
ESX.RegisterServerCallback('flyer_job:getXP', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    
    if xPlayer then
        local identifier = xPlayer.getIdentifier()
        
        -- Pokud máme XP v paměti, vrátíme ho
        if playerXP[identifier] ~= nil then
           -- print('[Letaky] Vracím XP z paměti: ' .. playerXP[identifier])
            cb(playerXP[identifier])
            return
        end
        
        -- Jinak načteme z databáze
        MySQL.Async.fetchScalar('SELECT xp FROM flyer_job_xp WHERE identifier = @identifier', {
            ['@identifier'] = identifier
        }, function(xp)
            if xp then
                playerXP[identifier] = xp
                --print('[Letaky] Načteno XP z databáze: ' .. xp)
                cb(xp)
            else
                -- Pokud hráč nemá záznam, vytvoříme ho s 0 XP
                playerXP[identifier] = 0
                MySQL.Async.execute('INSERT INTO flyer_job_xp (identifier, xp) VALUES (@identifier, 0)', {
                    ['@identifier'] = identifier
                })
                print('[Letaky] Vytvořen nový záznam s 0 XP')
                cb(0)
            end
        end)
    else
        print('[Letaky] Nepodařilo se najít hráče')
        cb(0)
    end
end)

-- Upravená inicializace serveru - předběžné načtení všech dat
AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then
        return
    end
    
    -- Vytvoření databázové tabulky pro XP, pokud neexistuje
    MySQL.Async.execute([[
        CREATE TABLE IF NOT EXISTS flyer_job_xp (
            identifier VARCHAR(60) PRIMARY KEY,
            xp INT NOT NULL DEFAULT 0
        )
    ]])
    
    -- Vytvoření databázové tabulky pro cooldowny, pokud neexistuje
    MySQL.Async.execute([[
        CREATE TABLE IF NOT EXISTS flyer_job_cooldowns (
            identifier VARCHAR(60) PRIMARY KEY,
            location_cooldowns LONGTEXT NOT NULL
        )
    ]])
    
    --print('[Letaky] Serverová část práce s letáky inicializována')
    
    -- Předběžné načtení všech dat XP do paměti
    MySQL.Async.fetchAll('SELECT identifier, xp FROM flyer_job_xp', {}, function(results)
        if results then
            for _, row in ipairs(results) do
                playerXP[row.identifier] = row.xp
            end
            --print('[Letaky] Předběžně načteno ' .. #results .. ' záznamů XP')
        end
    end)
end)

local playerUsedRoutes = {}

-- Uložení použitých tras hráče
RegisterNetEvent('flyer_job:saveUsedRoutes')
AddEventHandler('flyer_job:saveUsedRoutes', function(usedRoutes)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    
    if xPlayer then
        local identifier = xPlayer.getIdentifier()
        playerUsedRoutes[identifier] = usedRoutes
        
        -- Uložení do databáze jako JSON
        local usedRoutesJson = json.encode(usedRoutes)
        MySQL.Async.execute('INSERT INTO flyer_job_used_routes (identifier, used_routes) VALUES (@identifier, @used_routes) ON DUPLICATE KEY UPDATE used_routes = @used_routes', {
            ['@identifier'] = identifier,
            ['@used_routes'] = usedRoutesJson
        })
    end
end)

-- Načtení použitých tras hráče
RegisterNetEvent('flyer_job:getUsedRoutes')
AddEventHandler('flyer_job:getUsedRoutes', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    
    if xPlayer then
        local identifier = xPlayer.getIdentifier()
        
        if playerUsedRoutes[identifier] then
            TriggerClientEvent('flyer_job:loadUsedRoutes', src, playerUsedRoutes[identifier])
        else
            -- Pokud nemáme v paměti, načteme z databáze
            MySQL.Async.fetchAll('SELECT used_routes FROM flyer_job_used_routes WHERE identifier = @identifier', {
                ['@identifier'] = identifier
            }, function(result)
                if result and result[1] and result[1].used_routes then
                    local usedRoutes = json.decode(result[1].used_routes)
                    playerUsedRoutes[identifier] = usedRoutes
                    TriggerClientEvent('flyer_job:loadUsedRoutes', src, usedRoutes)
                else
                    -- Pokud neexistuje záznam v databázi, vytvoříme prázdný
                    playerUsedRoutes[identifier] = {}
                    TriggerClientEvent('flyer_job:loadUsedRoutes', src, {})
                    
                    -- Vytvoříme záznam v databázi
                    MySQL.Async.execute('INSERT INTO flyer_job_used_routes (identifier, used_routes) VALUES (@identifier, @used_routes)', {
                        ['@identifier'] = identifier,
                        ['@used_routes'] = '{}'
                    })
                end
            end)
        end
    end
end)

