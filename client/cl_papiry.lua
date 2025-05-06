-- Roznášení letáků - Klientská část (FINÁLNÍ VERZE - NA PROPECH)
-- Dependencies: ox_lib, ox_target, ESX

local ESX = exports['es_extended']:getSharedObject()

-- Úprava konfigurace - každá lokace může mít vlastní metodu
-- V části Config doplň nastavení:

Config = {}
Config.Debug = false
Config.Blip = { -- ponecháno beze změny
    sprite = 440,
    color = 14,
    scale = 0.7,
    name = '<FONT FACE="Lexend">Brigáda - Roznášení letáků'
}

Config.JobNPC = { -- ponecháno beze změny
    model = "a_m_y_business_03",
    coords = vector4(-598.7656, -933.7056, 22.8647, 93.1549), -- Downtown lokace, lze upravit
}

Config.FlyersPerRoute = 15 -- ponecháno beze změny
Config.LocationCooldown = 10 * 60000 -- ponecháno beze změny
Config.MemoryDepth = 3 -- Pamatovat si 3 poslední trasy

-- Seznam modelů objektů pro vyhledávání - ponecháno beze změny
Config.TargetObjects = {
    -- Poštovní schránky
   --[[ "prop_letterbox_02",
    "prop_letterbox_01",
    "prop_postbox_02a",
    "prop_postbox_02b",
    "prop_postbox_03",]]
    -- (zbytek seznamu ponechán beze změn)
}

-- Úprava lokací - přidáno nastavení useProps pro každou lokaci
Config.Locations = {
    {
        name = "Downtown",
        requiredXP = 0,
        paymentRange = {400, 600},
        cooldown = 5,
        useProps = false, -- Použít pevné souřadnice
        zone = {
            center = vector3(-270.0, -960.0, 31.2),
            radius = 150.0,
        },
        fixedPoints = { -- Pevné body pro tuto lokaci
            vector3(114.1444, -1961.2268, 21.3341),
            vector3(126.7789, -1930.0031, 21.3823),
            vector3(118.4396, -1921.0063, 21.3231),
            vector3(101.0642, -1912.2856, 21.3999),
            vector3(54.4175, -1873.1532, 22.8058),
            vector3(46.1386, -1864.3718, 23.2783),
            vector3(21.3236, -1844.6426, 24.6018),
            vector3(6.3403, -1816.5229, 25.3525),
            vector3(-50.3345, -1783.2603, 28.3008),
            vector3(-20.4692, -1858.9835, 25.4087),
            vector3(-4.8225, -1872.1833, 24.1510),
            vector3(5.2178, -1884.3859, 23.6973),
            vector3(38.8653, -1911.6296, 21.9535),
            vector3(56.5471, -1922.7845, 21.9111),
            vector3(72.1799, -1939.0792, 21.3683),
            vector3(76.3159, -1948.1552, 21.1741),
            vector3(103.9476, -1885.3732, 24.3176),
            vector3(128.2198, -1896.9640, 23.6742),
            vector3(192.3765, -1883.2904, 25.0586),
            vector3(192.3669, -1883.3328, 25.0567),
            vector3(171.6519, -1871.4879, 24.4002),
            vector3(150.1587, -1864.7334, 24.5913),
            vector3(130.7449, -1853.2667, 25.2240),
            vector3(152.9564, -1823.5645, 27.8683),
            vector3(179.2615, -1923.8667, 21.3710),
            vector3(179.2615, -1923.8667, 21.3710),
            vector3(165.0462, -1944.9471, 20.2354),
            vector3(148.8384, -1960.5719, 19.4587),
            vector3(144.2087, -1968.9180, 18.8576),
            vector3(250.8045, -1935.0315, 24.6993),
            vector3(270.4869, -1917.0521, 26.1803),
            vector3(329.2852, -1845.9307, 27.7481),
            vector3(348.8362, -1821.0376, 28.8941),
            vector3(419.1384, -1735.5850, 29.6077),
            vector3(431.2942, -1725.5028, 29.6015),
            vector3(443.3587, -1707.3090, 29.7090),
            vector3(470.9233, -1561.1486, 32.8252), -- baraky 467.3579, -1567.7618, 30.8997, 174.4937
            vector3(465.6084, -1567.3763, 32.8259),
            vector3(460.6466, -1573.3969, 32.8234),
            vector3(454.8216, -1580.0951, 32.8225),
            vector3(460.8965, -1585.2599, 32.8190),
            vector3(466.9294, -1590.2543, 32.8190),
            vector3(442.1582, -1569.5784, 32.8230),
            vector3(436.1750, -1564.5295, 32.8230),
            vector3(430.1605, -1559.3362, 32.8205), -- Další lokace 
            vector3(332.9223, -1741.1058, 29.7305),
            vector3(320.5685, -1759.9052, 29.6379),
            vector3(304.4497, -1775.4396, 29.0981),
            vector3(300.0996, -1783.6772, 28.4387),
            vector3(288.7374, -1792.6659, 28.0891),
            vector3(236.1658, -2046.4552, 18.3800),
            vector3(256.2873, -2023.5792, 19.2673),
            vector3(279.6675, -1994.0040, 20.8038),
            vector3(291.4669, -1980.1326, 21.6005),
            vector3(295.7453, -1971.8695, 22.9000),
            vector3(311.9714, -1956.1063, 24.6173),
            vector3(324.3769, -1937.3522, 25.0190),
            vector3(368.6667, -1895.7219, 25.1785),
            vector3(385.2947, -1881.3297, 26.0314),
            vector3(399.3125, -1865.1562, 26.7164),
            vector3(412.3081, -1856.2683, 27.3231),
            vector3(427.1524, -1841.9858, 28.4634),
            vector3(427.1531, -1842.0317, 28.4635),
            vector3(440.5321, -1829.6229, 28.3619),
            vector3(472.0760, -1775.4172, 29.0709),
            vector3(474.4610, -1757.7410, 29.0926),
            vector3(479.5547, -1735.6698, 29.1510),
            vector3(489.6159, -1713.9744, 29.7075),
            vector3(500.8141, -1697.2827, 29.7893),
            vector3(514.2753, -1780.9453, 28.9140),
            vector3(512.5052, -1790.6199, 28.9195),
            vector3(495.4289, -1823.4050, 28.8697),
            vector3(331.2205, -1982.3518, 24.1673), -- Baraky tady  331.2205, -1982.3518, 24.1673, 214.0305
            vector3(325.3437, -1989.6426, 24.1672),
            vector3(324.3565, -1990.8259, 24.1673),
            vector3(290.1485, -2031.2572, 19.7675),
            vector3(287.1537, -2034.8601, 19.7675),
            vector3(281.0345, -2042.3491, 19.7669),
            vector3(279.9349, -2043.5060, 19.7676),
            vector3(288.4185, -2072.6531, 17.6634),
            vector3(289.9843, -2076.8167, 17.6635),
            vector3(293.3121, -2085.9590, 17.6635),
            vector3(293.9866, -2087.8296, 17.6636),
            vector3(295.9384, -2093.1921, 17.6630),
            vector3(297.5184, -2097.6606, 17.6632),
            vector3(320.2408, -2101.0210, 18.2409),
            vector3(321.7790, -2100.1270, 18.2441),
            vector3(329.9583, -2095.4070, 18.2440),
            vector3(334.1155, -2092.9548, 18.2439),
            vector3(356.7975, -2074.6282, 21.7432),
            vector3(357.8600, -2073.5083, 21.7445),
            vector3(365.1364, -2064.6868, 21.7428),
            vector3(371.3832, -2057.3428, 21.7445),
            vector3(372.4330, -2055.9844, 21.7445),
            vector3(364.5873, -2045.5450, 22.3483),
            vector3(360.9688, -2042.4995, 22.3542),
            vector3(353.5572, -2036.1558, 22.3542),
            vector3(352.2148, -2035.1517, 22.3543),
            vector3(344.8794, -2028.8739, 22.3530),
            vector3(343.4191, -2027.7788, 22.3543),
            vector3(336.1302, -2021.5409, 22.3542),
            vector3(336.1302, -2021.5409, 22.3542),
            vector3(332.2935, -2018.3510, 22.3543),
            vector3(361.9960, -1987.0719, 24.2338),
            vector3(-3364.0031, -1987.8162, 24.2338),
            vector3(374.4108, -1991.5571, 24.2349),
            vector3(383.7321, -1994.9503, 24.2346),
            vector3(385.3852, -1995.5544, 24.2350),
            vector3(393.3573, -2015.7778, 23.4016),
            vector3(393.5793, -2015.5129, 23.4031),
            vector3(388.5989, -2025.9783, 23.4012),
            vector3(383.7643, -2036.3417, 23.3962),
            vector3(372.4692, -2055.9480, 21.7443),
            vector3(365.2301, -2064.5762, 21.7404),
            vector3(357.7986, -2073.5212, 21.7445), -- Další zonaw
            vector3(489.5283, -1714.2449, 29.7069),
            vector3(479.6710, -1735.6812, 29.1510),
            vector3(474.5022, -1757.7500, 29.0926),
            vector3(472.1085, -1775.2290, 29.0711),
            vector3(495.0740, -1823.0814, 28.8696),
        }
    },
    {
        name = "Vinewood",
        requiredXP = 100,
        paymentRange = {600, 800},
        cooldown = 10,
        useProps = false, -- Použít reálné objekty (props)
        zone = {
            center = vector3(-518.4080, 430.1274, 96.7207),
            radius = 450.0,
        },
        fixedPoints = { -- Záložní body pro případ, že nenajde dostatek objektů
        vector3(-518.4377, 430.3610, 97.7217),
        vector3(-485.56634521484, 405.23181152344, 99.488540649414),
        vector3(-455.38537597656, 346.18127441406, 104.00315856934),
        vector3(-442.49005126953, 344.79577636719, 105.13952636719),
        vector3(-407.61837768555, 348.27542114258, 108.04508972168),
        vector3(-377.72946166992, 351.81729125977, 109.19071960449),
        vector3(-344.27499389648, 372.73956298828, 110.0221786499),
        vector3(-302.6834, 385.1657, 111.3817),
        vector3(-255.67486572266, 397.81332397461, 110.0244140625),
        vector3(-206.80250549316, 409.79815673828, 110.18389892578),
        vector3(-169.69578552246, 431.58697509766, 111.19491577148),
        vector3(-85.016983032227, 424.42626953125, 113.16624450684),
        vector3(9.0085525512695, 378.82885742188, 112.10981750488),
        vector3(65.217788696289, 352.26940917969, 113.28057861328),
        vector3(-514.63037109375, 412.73257446289, 97.562927246094),
        vector3(-517.91015625, 430.69418334961, 96.887367248535), -- Didlon Drive postal 6160 - 6177
        vector3(-573.68603515625, 409.26525878906, 100.51984405518),
        vector3(-600.21264648438, 401.65954589844, 101.36936187744),
        vector3(-624.07043457031, 403.13333129883, 101.19969177246),
        vector3(-551.1455078125, 500.08346557617, 104.06772613525),
        vector3(-583.49829101562, 515.16900634766, 106.16634368896),
        vector3(-717.09698486328, 486.74926757812, 108.70238494873),
        vector3(-727.05999755859, 466.10852050781, 105.90910339355),
        vector3(-778.25354003906, 451.70111083984, 96.522979736328),
        vector3(-764.06384277344, 441.49548339844, 98.247428894043),
        vector3(-816.84350585938, 431.28930664062, 89.310699462891),
        vector3(-848.82000732422, 464.34045410156, 87.244186401367),
        vector3(-863.6123046875, 521.33819580078, 89.683944702148),
        vector3(-876.71795654297, 543.50549316406, 92.276069641113),
        vector3(-923.49444580078, 579.97772216797, 99.499504089355),
        vector3(-941.29138183594, 576.27587890625, 100.33929443359),
        vector3(-965.07928466797, 594.21942138672, 101.60511779785),
        vector3(-974.865234375, 585.41857910156, 101.92785644531),
        vector3(-1109.3950195312, 563.47595214844, 102.51106262207),
        vector3(-1128.3637695312, 554.72424316406, 102.25552368164),
        vector3(-1079.1538085938, 427.50985717773, 72.170791625977),
        vector3(-1185.1329345703, 464.1325378418, 87.445755004883),
        vector3(-1217.7178955078, 464.30557250977, 90.657653808594),
        vector3(-1232.9553222656, 472.85385131836, 91.934867858887),
        vector3(-1265.5159912109, 455.50836181641, 94.75203704834),
        vector3(-1293.7309570312, 455.74200439453, 97.269195556641),
        vector3(-1329.6864013672, 454.11016845703, 100.33678436279),
        vector3(-1412.6929931641, 469.78735351562, 108.16635894775),
        vector3(-1426.0196533203, 526.97625732422, 118.87994384766),
        vector3(-1355.5712890625, 573.35296630859, 131.0171661377),
        vector3(-1352.0191650391, 604.34600830078, 133.90029907227),
        vector3(-1289.2152099609, 640.51251220703, 138.36837768555),
        vector3(-1297.2436523438, 627.53167724609, 137.9842376709),
        vector3(-1231.3996582031, 657.16046142578, 142.8067779541),
        vector3(-1238.8450927734, 664.12335205078, 142.62911987305),
        vector3(-1196.7893066406, 696.32495117188, 147.6166229248),
        vector3(-1156.9807128906, 750.62219238281, 155.28863525391),
        vector3(-1122.3409423828, 772.92517089844, 161.83135986328),
        vector3(-1048.6309814453, 763.30932617188, 167.30697631836),
        vector3(-1001.1891479492, 703.92980957031, 160.06970214844),
        vector3(-889.39379882812, 703.16156005859, 150.15190124512),
        vector3(-757.77209472656, 657.51403808594, 143.05206298828),
        vector3(-733.60717773438, 595.00811767578, 141.87030029297),
        vector3(-687.07592773438, 662.4404296875, 151.39227294922),
        vector3(-662.47778320312, 755.18597412109, 175.31875610352),
        vector3(-582.57073974609, 755.62463378906, 184.39152526855),
        vector3(-666.41625976562, 812.70104980469, 200.69050598145),
        vector3(-745.79241943359, 812.82189941406, 213.34057617188),
        vector3(-609.57403564453, 679.95709228516, 149.39552307129),
        vector3(-564.82122802734, 682.44213867188, 146.26490783691),
        vector3(-486.61520385742, 737.32873535156, 162.72102355957),
        vector3(-484.98480224609, 804.12963867188, 182.75846862793),
        vector3(-545.68524169922, 833.19750976562, 197.45484924316),
        vector3(-999.01525878906, 805.62719726562, 172.38421630859),
        vector3(-1964.2202148438, 623.10467529297, 121.50315856934),
        vector3(-1948.6667480469, 590.48614501953, 119.1457901001),
        vector3(-1974.9022216797, 583.66937255859, 117.32083129883),
        vector3(-1958.6867675781, 547.94299316406, 112.67111968994),
        vector3(-1998.1910400391, 486.48046875, 104.81091308594),
        vector3(-1962.5458984375, 430.7356262207, 98.863525390625),
        vector3(-1955.2414550781, 381.00326538086, 94.21605682373),
        vector3(-1980.2202148438, 384.78549194336, 94.653800964355),
        vector3(-1957.8479003906, 252.3782043457, 85.246658325195),
        vector3(-1937.1184082031, 210.66426086426, 84.606719970703),
        vector3(-1922.0974121094, 186.9453125, 84.098068237305),
        vector3(-1886.8898925781, 188.53692626953, 83.433937072754),
        vector3(-1894.4736328125, 151.28350830078, 81.126182556152),
        vector3(327.07629394531, 503.88983154297, 152.10015869141),
        vector3(353.54568481445, 442.19287109375, 145.72364807129),
        vector3(-61.0897, 359.9842, 114.0564),        
        }
    },
    {
        name = "Beach",
        requiredXP = 250,
        paymentRange = {750, 1200},
        cooldown = 5,
        useProps = false, -- Použít pevné souřadnice
        zone = {
            center = vector3(-1300.0, -1500.0, 4.0),
            radius = 150.0,
        },
        fixedPoints = { -- Pevné body pro tuto lokaci
            vector3(-1270.8712, -1148.4756, 6.7939),
            vector3(-1283.1364, -1130.4736, 6.7948),
            vector3(-1246.5104, -1182.9507, 7.6654),
            vector3(-1113.2451, -1195.7437, 6.6833),
            vector3(-1125.7163, -1172.1090, 2.3552),
            vector3(-1142.6527, -1144.0773, 2.8505),
            vector3(-1154.6320, -1120.8250, 2.3298),
            vector3(-1163.6090, -1113.6241, 2.2868),
            vector3(-1182.9309, -1064.2297, 2.1352),
            vector3(-1190.8645, -1054.8671, 2.1479),
            vector3(-1200.5403, -1031.8981, 2.1504),
            vector3(-1089.7888, -953.4619, 2.4322),
            vector3(-1090.3796, -926.6030, 3.1034),
            vector3(-1031.0897, -902.8933, 3.6948),
            vector3(-1022.5492, -896.9583, 5.4113),
            vector3(-975.3202, -909.5132, 2.2627),
            vector3(-1026.0035, -1466.8510, 5.5755),
            vector3(-1056.7943, -1587.2058, 4.6187),
            vector3(-1056.9099, -1587.2888, 4.6131),
            vector3(-1063.6862, -1557.5945, 5.1476),
            vector3(-1087.3547, -1529.1414, 4.6969),
            vector3(-1078.5647, -1524.0345, 5.0940),
            vector3(-1057.9447, -1540.6969, 5.0395),
            vector3(-1115.0005, -1577.8451, 4.5430),
            vector3(-1114.0552, -1579.6296, 8.6795),            
            
        }
    },
    -- Lze přidat další lokace/čtvrti
}

-- Proměnné
local playerData = {xp = 0} -- Inicializace s výchozí hodnotou XP
local activeJob = false
local currentRoute = nil
local currentPoint = nil
local remainingFlyers = 0
local jobBlip = nil
local routeBlips = {}
local targetPoints = {}
local foundObjects = {} -- Seznam nalezených objektů v zóně
local isXPLoaded = false -- Flag pro kontrolu, zda bylo XP načteno

-- Forward declaration pro funkce používané před jejich definicí
local DistributeFlyer

-- Funkce
local function DebugPrint(msg)
    if Config.Debug then
        print("[Letaky] " .. msg)
    end
end



local function CreateJobBlip()
    jobBlip = AddBlipForCoord(Config.JobNPC.coords.x, Config.JobNPC.coords.y, Config.JobNPC.coords.z)
    SetBlipSprite(jobBlip, Config.Blip.sprite)
    SetBlipDisplay(jobBlip, 4)
    SetBlipScale(jobBlip, Config.Blip.scale)
    SetBlipColour(jobBlip, Config.Blip.color)
    SetBlipAsShortRange(jobBlip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(Config.Blip.name)
    EndTextCommandSetBlipName(jobBlip)
end

local function RemoveRouteBlips()
    for _, blip in pairs(routeBlips) do
        if DoesBlipExist(blip) then
            RemoveBlip(blip)
        end
    end
    routeBlips = {}
end

local function RemoveTargetPoints()
    for i, targetId in pairs(targetPoints) do
        if targetId then
            exports.ox_target:removeZone(targetId)
        end
    end
    targetPoints = {}
end




-- Funkce pro vyhledávání objektů v zóně
local function FindObjectsInZone(center, radius, models)
    local objects = {}
    
    -- Získáme hashe modelů
    local modelHashes = {}
    for _, model in ipairs(models) do
        modelHashes[GetHashKey(model)] = model
    end
    
    -- Prohledáme všechny objekty
    local handle, entity = FindFirstObject(0)
    local success = true
    
    repeat
        if DoesEntityExist(entity) then
            local coords = GetEntityCoords(entity)
            local distance = #(coords - center)
            
            if distance <= radius then
                local model = GetEntityModel(entity)
                if modelHashes[model] then
                    -- Našli jsme objekt správného typu
                 --   print("NALEZEN OBJEKT: " .. modelHashes[model] .. " na " .. coords.x .. ", " .. coords.y .. ", " .. coords.z)
                    
                    -- Vytvoříme dočasný blip pro debug
                    local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
                    SetBlipSprite(blip, 1)
                    SetBlipColour(blip, 1) -- červená
                    SetBlipScale(blip, 0.8)
                    BeginTextCommandSetBlipName("STRING")
                    AddTextComponentString("PROP: " .. modelHashes[model])
                    EndTextCommandSetBlipName(blip)
                    
                    -- Přidáme objekt do seznamu
                    table.insert(objects, {
                        entity = entity,
                        coords = coords,
                        model = modelHashes[model],
                        distance = distance
                    })
                end
            end
        end
        success, entity = FindNextObject(handle)
    until not success
    
    EndFindObject(handle)
    return objects
end

-- Aktualizace části kódu o zvětšení rádia zóny
-- V konfiguraci změň radius pro lokaci, kde hledáš objekty:

-- Například:
Config.Locations[2].zone.radius = 300.0  -- Zvětšení rádia pro Vinewood

-- Také můžeš přidat tuto funkci pro testování:
function TestFindObjects()
    -- Získej aktuální pozici hráče
    local playerCoords = GetEntityCoords(PlayerPedId())
    
    -- Hledej objekty v okruhu 50m od hráče
    local foundObjects = FindObjectsInZone(playerCoords, 50.0, Config.TargetObjects)
    
    DebugPrint("TEST: Nalezeno " .. #foundObjects .. " objektů kolem hráče")
    
    -- Vytvoř blipy pro nalezené objekty (dočasné)
    local blips = {}
    for i, obj in ipairs(foundObjects) do
        local blip = AddBlipForCoord(obj.coords.x, obj.coords.y, obj.coords.z)
        SetBlipSprite(blip, 1)
        SetBlipColour(blip, 1) -- červená pro odlišení
        SetBlipScale(blip, 0.8)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("TEST: " .. obj.model)
        EndTextCommandSetBlipName(blip)
        table.insert(blips, blip)
    end
    
    -- Počkej 30 sekund a pak odstraň blipy
    CreateThread(function()
        Wait(30000)
        for _, blip in ipairs(blips) do
            RemoveBlip(blip)
        end
    end)
    
    return #foundObjects
end

-- Testovací příkaz
RegisterCommand('testprops', function()
    local count = TestFindObjects()
    TriggerEvent('chat:addMessage', {
        color = {255, 0, 0},
        multiline = true,
        args = {"System", "Nalezeno " .. count .. " props v okolí. Zkontroluj console."}
    })
end, false)



local function SaveLocationCooldowns()
    local cooldowns = {}
    local usedRoutes = {}
    
    for i, location in ipairs(Config.Locations) do
        -- Uložíme čas cooldownu
        cooldowns[i] = location.cooldown
        
        -- Pokud máme aktivní záznam o použitých trasách, uložíme je
        if location.usedRoutes then
            usedRoutes[i] = location.usedRoutes
        else
            usedRoutes[i] = {}
        end
    end
    
    -- Uložíme cooldowny
    TriggerServerEvent('flyer_job:saveCooldowns', cooldowns)
    -- Uložíme použité trasy
    TriggerServerEvent('flyer_job:saveUsedRoutes', usedRoutes)
    
    DebugPrint('Uloženy cooldowny a použité trasy')
end


-- Upravená funkce CreateFlyerPoints pro náhodný výběr bodů z velkého množství možností

local function CreateFlyerPoints()
    -- Získáme aktuální lokaci
    local location = Config.Locations[currentRoute]
    local locationName = location.name
    local useProps = location.useProps
    
    DebugPrint("Vytvářím body pro lokaci " .. locationName .. " (metoda: " .. (useProps and "objekty" or "pevné body") .. ")")
    
    -- Příprava seznamu všech možných bodů
    local allPossiblePoints = {}
    
    if useProps then
        -- Hledání objektů v zóně
        DebugPrint("Hledám objekty v zóně " .. locationName)
        local foundProps = FindObjectsInZone(location.zone.center, location.zone.radius, Config.TargetObjects)
        
        -- Filtrujeme objekty
        for _, obj in ipairs(foundProps) do
            -- Zkontrolujeme, zda objekt není na silnici
            if not IsPointOnRoad(obj.coords.x, obj.coords.y, obj.coords.z, 0) then
                table.insert(allPossiblePoints, {
                    type = "prop",
                    entity = obj.entity,
                    coords = obj.coords,
                    model = obj.model,
                    distance = obj.distance
                })
            end
        end
        
        DebugPrint("Nalezeno " .. #allPossiblePoints .. " validních objektů")
    end
    
    -- Vždy přidáme fixní body (buď jako hlavní zdroj, nebo jako doplněk)
    if location.fixedPoints and #location.fixedPoints > 0 then
        DebugPrint("Přidávám pevné body z konfigurace")
        
        -- Přidáme pevné body, které nejsou na silnici a nejsou příliš blízko existujících bodů
        for _, coord in ipairs(location.fixedPoints) do
            if not IsPointOnRoad(coord.x, coord.y, coord.z, 0) then
                -- Kontrola, zda bod není příliš blízko již přidaným bodům
                local tooClose = false
                for _, existingPoint in ipairs(allPossiblePoints) do
                    if #(coord - existingPoint.coords) < 5.0 then
                        tooClose = true
                        break
                    end
                end
                
                if not tooClose then
                    table.insert(allPossiblePoints, {
                        type = "fixed",
                        entity = nil,
                        coords = coord,
                        model = "fixed_point",
                        distance = #(coord - location.zone.center)
                    })
                end
            end
        end
    end
    
    DebugPrint("Celkem k dispozici " .. #allPossiblePoints .. " možných bodů")
    
    -- NOVÉ: Vyfiltrujeme body, které byly použity v předchozích trasách
    local filteredPoints = {}
    local usedCoords = {}
    
    -- Vytvoříme seznam použitých souřadnic
    if location.usedRoutes then
        for _, route in ipairs(location.usedRoutes) do
            for _, coord in ipairs(route) do
                table.insert(usedCoords, coord)
            end
        end
        DebugPrint("Nalezeno " .. #usedCoords .. " již použitých souřadnic z předchozích tras")
    end
    
    -- Filtrujeme body, které už byly použity
    for _, point in ipairs(allPossiblePoints) do
        local isUsed = false
        
        for _, usedCoord in ipairs(usedCoords) do
            if #(point.coords - vector3(usedCoord.x, usedCoord.y, usedCoord.z)) < 5.0 then
                isUsed = true
                break
            end
        end
        
        if not isUsed then
            table.insert(filteredPoints, point)
        end
    end
    
    -- Pokud po filtrování zůstalo příliš málo bodů, použijeme všechny body
    if #filteredPoints < Config.FlyersPerRoute * 0.7 then
        DebugPrint("Po filtrování zůstalo příliš málo bodů (" .. #filteredPoints .. "), používám všechny dostupné body")
        filteredPoints = allPossiblePoints
    else
        DebugPrint("Po filtrování zůstalo " .. #filteredPoints .. " použitelných bodů")
    end
    
    -- Pokud nemáme dostatek bodů, zobrazíme varování
    if #filteredPoints < Config.FlyersPerRoute then
        DebugPrint("VAROVÁNÍ: Není dostatek bodů! Požadováno " .. Config.FlyersPerRoute .. ", k dispozici pouze " .. #filteredPoints)
    end
    
    -- Vybíráme náhodně požadovaný počet bodů
    foundObjects = {}
    local numPointsToSelect = math.min(Config.FlyersPerRoute, #filteredPoints)
    
    -- Mícháme body, aby výběr byl opravdu náhodný
    for i = #filteredPoints, 2, -1 do
        local j = math.random(i)
        filteredPoints[i], filteredPoints[j] = filteredPoints[j], filteredPoints[i]
    end
    
    -- Bereme prvních N bodů
    for i = 1, numPointsToSelect do
        table.insert(foundObjects, filteredPoints[i])
    end
    
    -- Seřadíme podle vzdálenosti od středu pro efektivnější trasu
    table.sort(foundObjects, function(a, b)
        return a.distance < b.distance
    end)
    
    -- Ukládáme aktuální trasu
    local currentRouteCoords = {}
    for _, obj in ipairs(foundObjects) do
        table.insert(currentRouteCoords, {
            x = obj.coords.x,
            y = obj.coords.y,
            z = obj.coords.z
        })
    end
    
    -- Přidáme aktuální trasu do seznamu použitých tras
    if not location.usedRoutes then
        location.usedRoutes = {}
    end
    
    table.insert(location.usedRoutes, 1, currentRouteCoords)
    
    -- Omezíme počet uložených tras
    while #location.usedRoutes > Config.MemoryDepth do
        table.remove(location.usedRoutes)
    end
    
    DebugPrint("Vybráno " .. #foundObjects .. " náhodných bodů pro tuto trasu")
    
    -- Vytvoříme blipy a targety pro vybrané body
    for i, obj in ipairs(foundObjects) do
        -- Vytvoření blipu
        local blip = AddBlipForCoord(obj.coords.x, obj.coords.y, obj.coords.z)
        SetBlipSprite(blip, 1)
        SetBlipColour(blip, 2)
        SetBlipScale(blip, 0.6)
        SetBlipAsShortRange(blip, false)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Místo pro roznos letáku")
        EndTextCommandSetBlipName(blip)
        table.insert(routeBlips, blip)
        
        -- Vytvoření targetu jako sférickou zónu
        local targetId = exports.ox_target:addSphereZone({
            coords = obj.coords,
            radius = 2,
            debug = Config.Debug,
            options = {
                {
                    name = 'flyer_dropoff_zone_' .. i,
                    icon = 'fas fa-paper-plane',
                    label = 'Rozdat leták',
                    distance = 2.0,
                    onSelect = function()
                        DistributeFlyer(i)
                    end,
                    canInteract = function()
                        -- Zde upravte podmínku - odstraňte kontrolu currentPoint == i
                        return activeJob 
                    end
                }
            }
        })
        
        if targetId then
            DebugPrint("Vytvořena zóna pro bod " .. i .. " s ID " .. targetId)
            table.insert(targetPoints, targetId)
        else
            DebugPrint("Selhalo vytvoření zóny pro bod " .. i)
        end
    end
    
    -- Nastavení prvního bodu jako aktivní
    currentPoint = 1
    -- Nastavit počet letáků podle počtu vybraných bodů
    remainingFlyers = #foundObjects
    
    DebugPrint("Připraveno " .. remainingFlyers .. " bodů pro doručení letáků")
    DebugPrint("Aktuální bod je: " .. currentPoint)
end



-- Funkce pro odstranění target zón
--[[local function RemoveTargetPoints()
    for _, targetId in pairs(targetPoints) do
        exports.ox_target:removeZone(targetId)
    end
    targetPoints = {}
end]]

-- Implementace funkce DistributeFlyer
DistributeFlyer = function(pointId)
    DebugPrint("Volána funkce DistributeFlyer s ID bodu: " .. pointId)
    
    -- Odstraněna kontrola na aktuální bod, aby bylo možné roznášet v libovolném pořadí
    
    -- Spuštění /me příkazu pro roleplay
    DebugPrint("Spouštím /me příkaz")
    ExecuteCommand("me hází leták do schránky")
    
    -- Animace pro hráče
    DebugPrint("Spouštím animaci")
    TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, true)
    
    -- Progress bar
    DebugPrint("Spouštím progress bar")
    lib.progressBar({
        duration = 3000,
        label = "Rozdávání letáku...",
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = true,
            move = true,
        },
        anim = {
            dict = 'mini@repair',
            clip = 'fixing_a_ped'
        },
    })
    
    ClearPedTasks(PlayerPedId())
    
    -- Odebrat blip pro tento bod
    if routeBlips[pointId] and DoesBlipExist(routeBlips[pointId]) then
        RemoveBlip(routeBlips[pointId])
        routeBlips[pointId] = nil
        DebugPrint("Blip pro bod " .. pointId .. " byl odstraněn")
    else
        DebugPrint("Blip pro bod " .. pointId .. " není k dispozici")
    end
    
    -- Odstranit target zónu pro tento bod
    if targetPoints[pointId] then
        exports.ox_target:removeZone(targetPoints[pointId])
        targetPoints[pointId] = nil
        DebugPrint("Target zóna pro bod " .. pointId .. " byla odstraněna")
    end
    
    -- Aktualizace bodu
    remainingFlyers = remainingFlyers - 1
    DebugPrint("Zbývající letáky: " .. remainingFlyers)
    
    if remainingFlyers <= 0 then
        -- Trasa dokončena
        ESX.ShowNotification("Všechny letáky rozdány! Vrať se k zadavateli pro odměnu.")
        RemoveRouteBlips()
        RemoveTargetPoints()
        
        -- Vytvoření zpětného blipu
        local blip = AddBlipForCoord(Config.JobNPC.coords.x, Config.JobNPC.coords.y, Config.JobNPC.coords.z)
        SetBlipSprite(blip, 1)
        SetBlipColour(blip, 5)
        SetBlipRoute(blip, true)
        table.insert(routeBlips, blip)
    else
        -- Netřeba přesouvat na další bod, protože body lze nyní dokončit v libovolném pořadí
        ESX.ShowNotification("Leták rozdán! Zbývá jich: " .. remainingFlyers)
    end
end

local function StartRoute(locationId)
    if activeJob then
        ESX.ShowNotification("Už máš aktivní práci!")
        return
    end
    
    -- Kontrola cooldownu
    if Config.Locations[locationId].cooldown > GetGameTimer() then
        local remainingCooldown = math.ceil((Config.Locations[locationId].cooldown - GetGameTimer()) / 60000)
        ESX.ShowNotification("Tato oblast je nedostupná! Zkus to znovu za " .. remainingCooldown .. " minut.")
        return
    end
    
    currentRoute = locationId
    activeJob = true
    
    local locationName = ""
    if Config.Locations[locationId].name == "Downtown" then
        locationName = "Centrum města"
    elseif Config.Locations[locationId].name == "Vinewood" then
        locationName = "Vinewood"
    elseif Config.Locations[locationId].name == "Beach" then
        locationName = "Pláž"
    else
        locationName = Config.Locations[locationId].name
    end
    
    ESX.ShowNotification("Hledám schránky v oblasti...")
    DebugPrint("Začínám práci v lokaci " .. locationId)
    
    CreateFlyerPoints()
    
    ESX.ShowNotification("Práce začala! Rozdej " .. remainingFlyers .. " letáků v oblasti: " .. locationName)
end

local function FinishJob()
    if not activeJob then
        ESX.ShowNotification("Nemáš aktivní práci!")
        return
    end
    
    if remainingFlyers > 0 then
        ESX.ShowNotification("Ještě máš letáky k rozdání!")
        return
    end
    
    -- Výpočet platby a XP
    local location = Config.Locations[currentRoute]
    local payment = math.random(location.paymentRange[1], location.paymentRange[2])
    local xpGain = math.floor(payment / 10) -- XP je 10% z platby
    
   -- ESX.ShowNotification("Práce dokončena! Získáno $" .. payment .. " a " .. xpGain .. " XP")

ESX.ShowNotification("Práce dokončena! Získáno $" .. payment .. " a " .. xpGain .. " XP")

-- Zavolání callbacku pro přidání peněz
lib.callback('flyer_job:addMoney', false, function(success)
    if success then
        lib.notify({
            title = 'Práce',
            description = 'Obdržel jsi $' .. payment,
            type = 'success'
        })
    else
        lib.notify({
            title = 'Práce',
            description = 'Nastala chyba při výplatě!',
            type = 'error'
        })
    end
end, payment)

    -- Aktualizace XP
    playerData.xp = playerData.xp + xpGain
    TriggerServerEvent('flyer_job:saveXP', playerData.xp)
    
    -- Nastavení cooldownu pro danou lokaci
    Config.Locations[currentRoute].cooldown = GetGameTimer() + Config.LocationCooldown
    DebugPrint("Nastaven cooldown pro lokaci " .. currentRoute .. " do: " .. Config.Locations[currentRoute].cooldown)
    
    -- Uložení cooldownů
    SaveLocationCooldowns()
    
    -- Reset práce
    activeJob = false
    currentRoute = nil
    currentPoint = nil
    remainingFlyers = 0
    RemoveRouteBlips()
    RemoveTargetPoints()
    foundObjects = {}
end

-- Client-side: Volání callbacku
function AddPlayerMoney(amount)
    lib.callback('flyer_job:addMoney', false, function(success)
        if success then
            lib.notify({
                title = 'Práce',
                description = 'Obdržel jsi $' .. amount,
                type = 'success'
            })
        else
            lib.notify({
                title = 'Práce',
                description = 'Nastala chyba při výplatě!',
                type = 'error'
            })
        end
    end, amount)
end


RegisterNetEvent('flyer_job:loadUsedRoutes')
AddEventHandler('flyer_job:loadUsedRoutes', function(usedRoutes)
    if usedRoutes then
        for i, locationRoutes in pairs(usedRoutes) do
            if Config.Locations[i] then
                Config.Locations[i].usedRoutes = locationRoutes
                DebugPrint('Načteny použité trasy pro lokaci ' .. i .. ': ' .. #locationRoutes .. ' tras')
            end
        end
    end
end)

local function CancelJob()
    if not activeJob then
        ESX.ShowNotification("Nemáš aktivní práci!")
        return
    end
    
    ESX.ShowNotification("Práce zrušena!")
    
    -- Reset práce
    activeJob = false
    currentRoute = nil
    currentPoint = nil
    remainingFlyers = 0
    RemoveRouteBlips()
    RemoveTargetPoints()
    foundObjects = {}
end

local function OpenJobMenu()
    -- Nejprve se ujistíme, že máme načtené XP
    if not isXPLoaded then
        ESX.TriggerServerCallback('flyer_job:getXP', function(xp)
            playerData.xp = xp or 0
            isXPLoaded = true
            DebugPrint('Načtena data hráče před otevřením menu: XP = ' .. playerData.xp)
            OpenJobMenu() -- Znovu otevřeme menu s již načteným XP
        end)
        return -- Vrátíme se a počkáme na callback
    end
    
    -- Maximální XP pro vizualizaci - nastavme ho tak, aby progress bar nebyl plný příliš brzy
    local maxXP = 1000
    
    -- Výpočet hodnoty progress baru (0-100)
    local progressValue = math.min(math.floor((playerData.xp / maxXP) * 100), 100)
    
    local options = {
        {
            title = 'Roznášení letáků',
            description = 'Aktuální XP: ' .. playerData.xp .. ' / ' .. maxXP,
            progress = progressValue, -- Hodnota 0-100
            icon = 'fas fa-paper-plane',
        }
    }
    
    if activeJob and remainingFlyers <= 0 then
        table.insert(options, {
            title = 'Dokončit práci',
            description = 'Získat odměnu za dokončenou trasu',
            icon = 'fas fa-check',
            onSelect = function()
                FinishJob()
            end
        })
    elseif not activeJob then
        -- Zobrazení všech lokací bez ohledu na XP, ale s rozdílnou dostupností
        for i, location in ipairs(Config.Locations) do
            local locationName = ""
            if location.name == "Downtown" then
                locationName = "Centrum města"
            elseif location.name == "Vinewood" then
                locationName = "Vinewood"
            elseif location.name == "Beach" then
                locationName = "Pláž"
            else
                locationName = location.name
            end
            
            -- Kontrola cooldownu
            local onCooldown = location.cooldown > GetGameTimer()
            local remainingCooldown = math.ceil((location.cooldown - GetGameTimer()) / 60000)
            
            -- Kontrola, zda je lokace dostupná na základě XP
            local isAvailable = playerData.xp >= location.requiredXP
            local missingXP = location.requiredXP - playerData.xp
            
            if isAvailable and not onCooldown then
                -- Dostupná lokace
                table.insert(options, {
                    title = locationName,
                    description = 'Požadované XP: ' .. location.requiredXP,
                    icon = 'fas fa-map-marker-alt',
                    onSelect = function()
                        StartRoute(i)
                    end
                })
            elseif isAvailable and onCooldown then
                -- Lokace na cooldownu
                table.insert(options, {
                    title = locationName .. " (Na cooldownu)",
                    description = 'Dostupné za: ' .. remainingCooldown .. ' minut',
                    icon = 'fas fa-clock',
                    disabled = true,
                })
            else
                -- Nedostupná lokace - bez možnosti kliknout
                table.insert(options, {
                    title = locationName .. " (Zamčeno)",
                    description = 'Potřebuješ další XP: ' .. missingXP,
                    icon = 'fas fa-lock',
                    disabled = true,
                })
            end
        end
    end
    
    if activeJob then
        table.insert(options, {
            title = 'Zrušit práci',
            description = 'Zrušit aktuální trasu roznášení',
            icon = 'fas fa-times',
            onSelect = function()
                CancelJob()
            end
        })
    end
    
    lib.registerContext({
        id = 'flyer_job_menu',
        title = 'Roznášení letáků',
        options = options
    })
    
    lib.showContext('flyer_job_menu')
end



-- Synchronizace XP ze serveru a cooldownů
RegisterNetEvent('flyer_job:updateXP')
AddEventHandler('flyer_job:updateXP', function(xp)
    playerData.xp = xp
    isXPLoaded = true
    DebugPrint('Aktualizováno XP ze serveru: ' .. xp)
end)

RegisterNetEvent('flyer_job:loadCooldowns')
AddEventHandler('flyer_job:loadCooldowns', function(cooldowns)
    if cooldowns then
        for i, cooldown in pairs(cooldowns) do
            if Config.Locations[i] then
                Config.Locations[i].cooldown = cooldown
            end
        end
        DebugPrint('Načteny cooldowny lokalit')
    end
end)

-- Načtení dat hráče při připojení
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    -- Získání XP hráče ze serveru
    ESX.TriggerServerCallback('flyer_job:getXP', function(xp)
        playerData.xp = xp or 0
        isXPLoaded = true
        DebugPrint('Načtena data hráče po připojení: XP = ' .. playerData.xp)
    end)
end)


CreateThread(function()
    -- Vytvoření práce NPC a blipu
    CreateJobBlip()
    
    -- Načtení cooldownů
    TriggerServerEvent('flyer_job:getCooldowns')
    
    -- Načtení použitých tras
    TriggerServerEvent('flyer_job:getUsedRoutes')
    
    -- Načtení XP při startu - několik pokusů pro jistotu
    local attempts = 0
    local maxAttempts = 3
    
    local function loadXP()
        ESX.TriggerServerCallback('flyer_job:getXP', function(xp)
            if xp ~= nil then
                playerData.xp = xp
                isXPLoaded = true
                DebugPrint('Načtena data hráče při startu: XP = ' .. playerData.xp)
            else
                attempts = attempts + 1
                if attempts < maxAttempts then
                    DebugPrint('Pokus ' .. attempts .. ' o načtení XP selhal, zkouším znovu za 2 sekundy')
                    Wait(2000)
                    loadXP()
                else
                    DebugPrint('Nepodařilo se načíst XP po ' .. maxAttempts .. ' pokusech')
                    -- Poslední pokus - použijeme event místo callbacku
                    TriggerServerEvent('flyer_job:requestXP')
                end
            end
        end)
    end
    
    -- První pokus o načtení XP
    Wait(2000) -- Počkáme 2 sekundy po startu skriptu
    loadXP()
    
    -- Spawnování NPC
    local npcHash = GetHashKey(Config.JobNPC.model)
    RequestModel(npcHash)
    while not HasModelLoaded(npcHash) do
        Wait(1)
    end
    
    local npc = CreatePed(4, npcHash, Config.JobNPC.coords.x, Config.JobNPC.coords.y, Config.JobNPC.coords.z, Config.JobNPC.coords.w, false, true)
    FreezeEntityPosition(npc, true)
    SetEntityInvincible(npc, true)
    SetBlockingOfNonTemporaryEvents(npc, true)
    
    -- Přidání cíle k NPC
    exports.ox_target:addLocalEntity(npc, {
        {
            name = 'flyer_job_talk',
            icon = 'fas fa-paper-plane',
            label = 'Manager Weazel News',
            distance = 2.0, -- Zvýšená maximální vzdálenost pro interakci
            onSelect = function()
                OpenJobMenu()
            end
        }
    })
    
    DebugPrint('Práce s letáky inicializována')
end)

RegisterNetEvent('onResourceStart')
AddEventHandler('onResourceStart', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        Wait(2000) -- Počkáme pár sekund na inicializaci serveru
        DebugPrint("Resource byl restartován, načítám XP z databáze")
        TriggerServerEvent('flyer_job:requestXP')
    end
end)