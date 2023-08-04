repeat task.wait() until game:IsLoaded() and Nexus
repeat wait() until game.Players
repeat wait() until game.Players.LocalPlayer
repeat wait() until game.ReplicatedStorage
repeat wait() until game.ReplicatedStorage:FindFirstChild("Remotes");
repeat wait() until game.Players.LocalPlayer:FindFirstChild("PlayerGui");
repeat wait() until game.Players.LocalPlayer.PlayerGui:FindFirstChild("Main");

join = game.Players.localPlayer.Neutral == false
if _G.Team == nil then
    _G.Team = "Pirates"
end
_G.Team = "Pirates"
if (_G.Team == "Pirates" or _G.Team == "Marines") and not join then
    repeat wait()
        pcall(function()
            join = game.Players.localPlayer.Neutral == false
            if _G.Team == "Pirates" then
                for i,v in pairs({"MouseButton1Click", "MouseButton1Down", "Activated"}) do
                    for i,v in pairs(getconnections(game:GetService("Players").LocalPlayer.PlayerGui.Main.ChooseTeam.Container.Pirates.Frame.ViewportFrame.TextButton[v])) do
                        v.Function()
                    end
                end
            elseif _G.Team == "Marines" then
                for i,v in pairs({"MouseButton1Click", "MouseButton1Down", "Activated"}) do
                    for i,v in pairs(getconnections(game:GetService("Players").LocalPlayer.PlayerGui.Main.ChooseTeam.Container.Marines.Frame.ViewportFrame.TextButton[v])) do
                        v.Function()
                    end
                end
            else
                for i,v in pairs({"MouseButton1Click", "MouseButton1Down", "Activated"}) do
                    for i,v in pairs(getconnections(game:GetService("Players").LocalPlayer.PlayerGui.Main.ChooseTeam.Container.Marines.Frame.ViewportFrame.TextButton[v])) do
                        v.Function()
                    end
                end
            end
        end)
    until join == true
end


repeat task.wait() until game:IsLoaded() and Nexus and not game:GetService("Players").LocalPlayer.PlayerGui.Main:FindFirstChild("ChooseTeam")

if not Nexus.IsConnected then Nexus.Connected:Wait() end

local request = request or http_request or syn.request
local TeleportService = game:GetService'TeleportService'

if not _G.WebServer then
    return print("Invalid WebServer.")
end

if not _G.WebServer["WebServerPort"] then
    return print("Invalid WebServerPort")
end

if not _G.WebServer["AutoDescription"] then
    _G.WebServer["AutoDescription"] = false
end

function split (inputstr, sep)
    if sep == nil then
            sep = "%s"
    end
    local t={}
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
            table.insert(t, str)
    end
    return t
end

function World()
    if game.PlaceId == 2753915549 then
        return 1
    elseif game.PlaceId == 4442272183 then
        return 2
    elseif game.PlaceId == 7449423635 then
        return 3
    end
end

function FormatInt(number)
    local steps = {
        {1,""},
        {1e3,"K"},
        {1e6,"M"},
        {1e9,"G"},
        {1e12,"T"},
    }
    for _,b in ipairs(steps) do
        if b[1] <= number+1 then
            steps.use = _
        end
    end
    local result = string.format("%.1f", number / steps[steps.use][1])
    if tonumber(result) >= 1e3 and steps.use < #steps then
        steps.use = steps.use + 1
        result = string.format("%.1f", tonumber(result) / 1e3)
    end
    result = string.sub(result,0,string.sub(result,-1) == "0" and -3 or -1)
    return result .. steps[steps.use][2]
end

function FormatInt2(number)
    local i, j, minus, int, fraction = tostring(number):find('([-]?)(%d+)([.]?%d*)')
    int = int:reverse():gsub("(%d%d%d)", "%1,")
    return minus .. int:reverse():gsub("^,", "") .. fraction
end

function Money()
    return game:GetService("Players").LocalPlayer.Data.Beli.Value
end

function Fragment()
    return game:GetService("Players").LocalPlayer.Data.Fragments.Value
end

function Level()
    return game:GetService("Players").LocalPlayer.Data.Level.Value
end

function Race()
    local info = {
        Name = game:GetService("Players").LocalPlayer.Data.Race.Value,
        Tiers = game:GetService("Players").LocalPlayer.Data.Race.C.Value,
        Version = 0,
        Text = ""
    }

    local check1 = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Alchemist","1")
    local check2 = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Wenlocktoad","1")

    if check1 ~= -2 then
        info.Version = 1
    else
        info.Version = 2

        if check2 == -2 then
            info.Version = 3
                if game.Players.LocalPlayer.Character:FindFirstChild("RaceTransformed") then
                    info.Version = 4
                end
        end
    end

    if info.Version == 4 then
        info.Text = info.Name .. " ( V: ".. info.Version .. " | T: ".. info.Tiers .." )"
    else
        info.Text = info.Name .. " ( V: ".. info.Version .. ")"
    end

    return info
end

function CheckItem ()
    local Inventory = game:GetService("ReplicatedStorage").Remotes["CommF_"]:InvokeServer("getInventoryWeapons")
    local Inventory2 = game.Players.LocalPlayer.Character:GetChildren()
    local Inventory3 = game.Players.LocalPlayer.Backpack:GetChildren()

    local Item = {}

    if not _G.LogInventory or #_G.LogInventory == 0 then
        return "None"
    end

    for i,v in pairs(Inventory3) do
        if v:IsA("Tool") then
            if v.ToolTip == "Sword" then
                if  table.find(_G.LogInventory, v.Name) then
                    table.insert(Item, v.Name)
                end
            end
        end
    end

    for i,v in pairs(Inventory2) do
        if v:IsA("Tool") then
            if v.ToolTip == "Sword" then
                if  table.find(_G.LogInventory, v.Name) then
                    table.insert(Item, v.Name)
                end
            end
        end
    end
    
    for i,v in pairs(Inventory) do
        if table.find(_G.LogInventory, v.Name) then
            table.insert(Item, v.Name)
        end
    end
    
    if #Item == 0  then
        table.insert(Item, "None")
    end
    table.sort(Item)
    return Item
end

function CheckMelee ()
    local melee = {}

    if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySuperhuman", true) == 1 then
        table.insert(melee, "Superhuman")
    end

    if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyGodhuman", true) == 1 then
        table.insert(melee, "Godhuman")
    end

    if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySharkmanKarate", true) == 1 then
        table.insert(melee, "SharkMan")
    end

    if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyDeathStep", true) == 1 then
        table.insert(melee, "DeathStep")
    end

    if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectricClaw", true) == 1 then
        table.insert(melee, "ElectricV2")
    end

    if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyDragonTalon", true) == 1 then
        table.insert(melee, "DragonV2")
    end

    if #melee == 0  then
        table.insert(melee, "None")
    end

    return melee
end

function getFruit ()
    local Fruit = {
        ["Awake"] = {},
        ["Fruit"] = "None",
        ["Mastery"] = 0
    }
    local DevilFruit = game.Players.LocalPlayer.Data.DevilFruit.Value

    if #DevilFruit == 0 then
        return Fruit
    else
        Fruit["Fruit"] = (DevilFruit):match("%-(.+)")
    end

    if not game.Players.LocalPlayer.Character:FindFirstChild(DevilFruit) then
        Fruit["Mastery"] = game.Players.LocalPlayer.Backpack[DevilFruit].Level.Value
    else
        Fruit["Mastery"] = game.Players.LocalPlayer.Character[DevilFruit].Level.Value
    end
    
    local GetAwake = game:GetService("ReplicatedStorage").Remotes["CommF_"]:InvokeServer("getAwakenedAbilities")
    local IsAwake = game:GetService("ReplicatedStorage").Remotes["CommF_"]:InvokeServer("AwakeningChanger", "Check")

    if GetAwake and IsAwake then
        for i,v in pairs(GetAwake) do
            if v.Awakened then
                table.insert(Fruit["Awake"], i)
            end
        end
    end
    
    if #Fruit["Awake"] == 0 then
        Fruit["Awake"] = "None"
    end

    return Fruit
end

function RareFuit()
    local RareFruit = {}
    for i,v in pairs(game:GetService("ReplicatedStorage").Remotes["CommF_"]:InvokeServer("getInventoryFruits")) do
		if v.Price >= 1000000 then
		    table.insert(RareFruit, v.Name:match("%-(.+)"))
		end
    end

    if #RareFruit == 0  then
        table.insert(RareFruit, "None")
    end
    table.sort(RareFruit)
    return RareFruit
end

function type()
    local melee = CheckMelee()
    local item = CheckItem()
    local fruit = getFruit()

    local text = ""

    if Level() ~= 2450 then
        text = text .. "!"
    end

    if fruit["Fruit"] == "Dough" and #fruit["Awake"] == 6 then
        text = text .. "Dough (A)"
    elseif table.find(item, "Cursed Dual Katana") then
        text = text .. "Dual Katana"
    elseif fruit["Fruit"] == "Leopard" then
        text = text .. "Leopard"
    elseif #(melee) == 6 then
        text = text .. "6 Melee"
    elseif table.find(item, "Hallow Scythe") then
        text = text .. "H-Scythe"
    elseif #(melee) <= 5 and #(melee) >= 3 then
        text = text .. "3-5 Melee"
    else
        text = text .. "Noob"
    end

    return text
end


-- check fruit

function fruit()
    local fruit = getFruit()

    if fruit["Fruit"] == "None" then
        fruit = "None"
    elseif (fruit["Awake"] == "None") then
        fruit = fruit["Fruit"].." ( M:"..fruit["Mastery"].." )"
    else
        fruit = fruit["Fruit"].." ( M: "..fruit["Mastery"].." | A: " .. #fruit["Awake"] .. " )"
    end

    return fruit
end

function Tagetlevel()
    local tagetlevel = Level()

    if tagetlevel >= 2450 then
        return "Max"
    else
        return FormatInt2(tagetlevel)
    end
end


-- sheet best
function LogSheet()

    return request({
        Url = _G.SheetBest,
        Method = "POST",
        Headers = {
            ["Content-Type"] = "application/json"
        },
        Body = game:GetService("HttpService"):JSONEncode({
            ["Type"] = type(),
            ["World"] = World(),
            ["Level"] = Tagetlevel(),
            ["Inventory"] = table.concat(CheckItem (), ", "),
            ["Melee"] = table.concat(CheckMelee (), ", "),
            ["RareFruit"] = table.concat(RareFuit(), ", "),
            ["Fruit"] = fruit(),
            ["Race"] = (Race()).Text,
            ["Money"] = FormatInt(Money()),
            ["Fragment"] = FormatInt(Fragment()),
            ["Account"] = game.Players.LocalPlayer.Name,
        })
    })
end

-- roblox account manager log

function tosheet() 
    if not _G.SheetBest then
        return print("Invalid sheet best URL.")
    end

    local res = LogSheet()

    request({
        Url = "http://localhost:"..tostring(_G.WebServer["WebServerPort"]).."/SetAlias?Account=".. game.Players.LocalPlayer.Name,
        Method = "POST",
        Body = "Sheet: "..tostring(res.Success)
    })

    if res.StatusCode == 200 and _G.AutoShutdown then
        game:shutdown()
    else
        return print("Sheet Best Error Code: ".. res.StatusCode)
    end
end

function SetDescription(username, description)
    return request({
        Url = "http://localhost:".._G.WebServer["WebServerPort"].."/SetDescription?Account=".. username,
        Method = "POST",
        Body = description
    })
end

if _G.WebServer["AutoDescription"] then
	Nexus:CreateLabel('DDelay', 'Auto Description Delay')
	Nexus:CreateNumeric('Delay', 1, 0, 1)
end
Nexus:CreateButton('Rejoin', 'Rejoin Server', { 125, 25 }, { 3, 3, 3, 3 })
Nexus:CreateButton('Shutdown', 'Shutdown Game', { 125, 25 }, { 3, 3, 3, 3 })
Nexus:CreateButton('Sheetbest', 'Log to Sheet Best', { 256, 25 }, { 3, 3, 3, 3 })
Nexus:OnButtonClick('Sheetbest', function() tosheet() end)
Nexus:OnButtonClick('Rejoin', function() TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId) end)
Nexus:OnButtonClick('Shutdown', function() game:shutdown() end);


Nexus:AddCommand('sheet', function() tosheet() end)
Nexus:AddCommand('shutdown', function() game:shutdown() end);


(function()
    local Time = Nexus:GetText('Delay')

    if _G.WebServer["AutoDescription"] then
        while wait(60 * Time) do
            local res = SetDescription(game.Players.LocalPlayer.Name, 
                Tagetlevel() .. "(".. type() ..")" ..
                "\n-W: ".. World() ..
                "\n-INV: ".. table.concat(CheckItem (), ", ") ..
                "\n-ML: ".. table.concat(CheckMelee (), ", ") ..
                "\n-FRUITS: ".. fruit() ..
                "\n-RF: ".. table.concat(RareFuit(), ", ")..
                "\n-RACE: ".. (Race()).Text ..
                "\n-BELI: ".. FormatInt2(Money()) ..
                "\n-Money: ".. FormatInt2(Money()) ..
                "\n-FM: ".. FormatInt2(Fragment()) 
            )

            if res.StatusCode ~= 200 then
                return print("SetDescription: ".. res.Body)
            end
        end
    end
end)()
