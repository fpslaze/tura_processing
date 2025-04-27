Config  = {}


Config.Messages = {
    ["start"] = "Processing started!",
    ["stop"] = "Processing stopped!",
    ["not_enough"] = "You don't have enough items to process!",
    ["no_item"] = "You don't have any items to process!",
    ["process_done"] = "Processing done!",
    ["process_failed"] = "Processing failed!",
    ["process_canceled"] = "Processing canceled!",
}




Config.ProcessPoints = {
     {
      ["prop"] = {
        prop = "p_benchironnbx01x",
        coords = {x=-750.5773, y=-1256.9865, z=43.2991, h=24.9785},
        interactRange = 5.0,
        interactKeyHash = 0xCEFD9220
      },
      ["items"] = {
        neededItem = "consumable_kidneybeans_can",
        neededItemLabel = "Kidneybohnen",
        processTime = 2,
        animation = "",
        neededItemAmount = 1, 
        removeItem = "",
         giveItems = {},
         giveItemAmount = 0,
      }
     },
}


Config.Notify = function ()
  
end

Config.HelpNotify = function ()
  
end

Config.StartProgBar = function ()
  
end

