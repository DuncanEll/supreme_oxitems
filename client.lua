local imageActive = false

RegisterNetEvent('supreme_oxitems:openMenu')
AddEventHandler('supreme_oxitems:openMenu', function()
    local data = lib.inputDialog("Enter Item Details", {
        {
            type = "input",
            label = "Item name (ex - water)",
            icon = "",
            required = true
         },
         {
            type = "input",
            label = "Item Label",
            icon = "",
            required = true
         },
         {
            type = "slider",
            label = "Weight",
            icon = "",
            required = true
         },
         {
            type = "select",
            label = "Stack",
            icon = "",
            required = true,
            options = {
               { value = 'true', label = 'True' },
               { value = 'false', label = 'False' },
           }
         },
         {
            type = "select",
            label = "Close",
            icon = "",
            required = true,
            options = {
               { value = 'true', label = 'True' },
               { value = 'false', label = 'False' },
           }
         },
         {
            type = "input",
            label = "Description",
            icon = "",
            required = true
         },
         {
            type = "input",
            label = "Image URL",
            icon = "",
            required = true
         }
    })
    if data == nil then
      print('it was nil')
    else
 TriggerServerEvent('supreme_oxitem:addItem', data[1], data[2], data[3], data[4], data[5], data[6])
 TriggerServerEvent('supreme_oxitem:addImage', data[1], data[7])
    end
end)

-- View image

RegisterCommand('oximage', function()
   local data = lib.inputDialog("Image URL", {
      {
          type = "input",
          label = "Image URL to view (imgur)",
          icon = "",
          required = true
       },
      })
TriggerEvent('supreme_oxitem:viewImage', data[1])
end)

RegisterNetEvent("supreme_oxitem:viewImage", function(url1)
   if not imageActive then
       imageActive = true
       SetNuiFocus(true, true)
       SendNUIMessage({action = "Show", photo = url1}) 
   end
end)

RegisterNUICallback("Close", function()
   SetNuiFocus(false, false)
   imageActive = false
end)
