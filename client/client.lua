local scriptLoaded = false




Citizen.CreateThread(function ()
    if not scriptLoaded then print("Error while loading Script!") return end
    scriptLoaded = true

    SpawnProps()

    while scriptLoaded do

        Citizen.Wait(1)

        for _,entrys in pairs(Config.ProcessPoints) do
            
            local playerPed = PlayerPedId()
            local playerCoords = GetEntityCoords(playerPed)
            local targetCoords = entrys["props"].coords or "no dataa"

           if Vdist(targetCoords.x, targetCoords.y, targetCoords.z, playerCoords.x, playerCoords.y, playerCoords.z) <= entrys["prop"].interactRange then
                if IsControlJustReleased(0, entrys["prop"].interactKeyHash) then
                    print("Action worked!")
                end
           end
        end
    end
end)



function SpawnProps()
    for _, entrySet in pairs(Config.ProcessPoints) do
        local model = RequestModel(entrySet["prop"].prop) or 0

        while HasModelLoaded(model) do
            if(model == 0) then
                Wait(250)
                repeat
                    RequestModel(entrySet["prop"].prop) 
                until model ~= 0
            end

        end
          CreateObject(entrySet["prop"].prop, entrySet["prop"].coords.x, entrySet["prop"].coords.y, entrySet["prop"].coords.z, false, false, false)
    end
end