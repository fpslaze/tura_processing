local Core = exports.vorp_core:GetCore()
local ServerRPC = exports.vorp_core:ServerRpcCall() --[[@as ServerRPC]] -- for intellisense

RegisterNetEvent("tura_processing:handleProcess")
AddEventHandler("tura_processing:handleProcess", function (itemname, tablexIndex)
 local ItemCount = exports.vorp_inventory:getItemCount(source, function ()
    end, itemname, {}, 1)


local neededItem = itemname or nil -- Item was er  braucht was  ihm abgezogen wird 
local giveItems = Config.ProcessPoints[tablexIndex]["items"].giveItems -- Items die ihm gegeben werden
local amount = Config.ProcessPoints[tablexIndex]["items"].giveItemAmount
local neededItemAmount = Config.ProcessPoints[tablexIndex]["items"].neededItemAmount


if(ItemCount <= neededItemAmount) then
  TriggerClientEvent("tura_processing:notifyPlayer", source, "Du brauchst ".. neededItemAmount-ItemCount.."x "..string.upper(itemname).. " um die Verarbeitung zu beginnen!")
  return
end

 TriggerClientEvent("tura_processing:notifyPlayer", source, "Processing Startet...")
  TriggerClientEvent("tura_processing:startProcessing", source, tablexIndex)
end)

local item = nil

RegisterNetEvent("tura_processing:handleProcessServer")
AddEventHandler("tura_processing:handleProcessServer", function (tablexIndex)
  local giveItems = Config.ProcessPoints[tablexIndex]["items"].giveItems
  local giveItem = math.random(1, Config.ProcessPoints[tablexIndex]["items"].giveItems)

   print(giveItems[giveItem])
   exports.vorp_inventory:subItem(source, Config.ProcessPoints[tablexIndex]["items"].neededItem, Config.ProcessPoints[tablexIndex]["items"].neededItemAmount, 0, function() end,0,nil)
    item = exports.vorp_inventory:addItem(source, giveItem, Config.ProcessPoints[tablexIndex]["items"].giveItemAmount, 0, function ()
    TriggerClientEvent("tura_processing:notifyPlayer",source,  "Du hast ".. Config.ProcessPoints[tablexIndex]["items"].neededItemLabel .. " verarbeitet. \n Du hast "..Config.ProcessPoints[tablexIndex]["items"].giveItemAmount .. "x ".. item .. "erhalten!")
    print(item)
end,true)
end)