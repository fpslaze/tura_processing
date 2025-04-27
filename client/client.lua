local object = nil or 0
local keyWord = "prop"
local playerPed = PlayerPedId()
local noNeeds = false

local Core = exports.vorp_core:GetCore()
local result = exports.vorp_inventory:getInventoryItems()
local ClientRPC = exports.vorp_core:ClientRpcCall()
local progressbar = exports.vorp_progressbar:initiate()

Citizen.CreateThread(function ()
    if not noNeeds then
        SpawnProp()
    end
 

    while true do
        Citizen.Wait(1)
        for key,entry in pairs(Config.ProcessPoints) do
            local playerCoords = GetEntityCoords(playerPed)
           if GetDistanceBetweenCoords(Config.ProcessPoints[key]["prop"].coords.x, Config.ProcessPoints[key]["prop"].coords.y, Config.ProcessPoints[key]["prop"].coords.z, playerCoords.x, playerCoords.y, playerCoords.z, false) <= entry["prop"].interactRange then
                if IsControlJustReleased(0, 0xCEFD9220) then 
                   TriggerServerEvent("tura_processing:handleProcess", Config.ProcessPoints[key]["items"].neededItem, key)  
                end
           end
        end
    end
end)


function SpawnProp()
    for _, entrySet in pairs(Config.ProcessPoints) do
        local model = RequestModel(entrySet["prop"].prop) or 0

        while HasModelLoaded(model) do
            if(model == nil) then return end
            if(model == 0) then
                Wait(250)
                repeat
                    RequestModel(entrySet["prop"].prop) 
                until model ~= 0
            end
        end
         object = CreateObject(entrySet["prop"].prop, entrySet["prop"].coords.x, entrySet["prop"].coords.y, entrySet["prop"].coords.z, false, true, false)
    end
end


function DeleteProp()
    DeleteObject(object)
end

RegisterNetEvent("tura_processing:startProcessing")
AddEventHandler("tura_processing:startProcessing", function (tableIndex)
    local playerCoords = GetEntityCoords(playerPed)
    
    FreezeEntityPosition(playerPed,  true)
    progressbar.start("Verarbeite "..Config.ProcessPoints[tableIndex]["items"].neededItemAmount.."x "..Config.ProcessPoints[tableIndex]["items"].neededItemLabel, Config.ProcessPoints[tableIndex]["items"].processTime*1000, function ()
        FreezeEntityPosition(playerPed,  false)
        TriggerServerEvent("tura_processing:handleProcessServer", tableIndex)
     end, 'linear')
end)

RegisterNetEvent("tura_processing:notifyPlayer")
AddEventHandler("tura_processing:notifyPlayer", function (text)
    Core.NotifyTip(text, 4000)
end)