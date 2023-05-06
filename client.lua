local imageActive = false



RegisterNetEvent('supreme_oxitems:openDevTools', function()
   if Config.Framework == "ox" then 
local coords = GetEntityCoords(PlayerPedId())
local coordsStr = string.format("%.2f, %.2f, %.2f", coords.x, coords.y, coords.z)
lib.registerContext({
   id = 'devtools',
   title = 'OX Dev Tools',
   options = {
      {
      title = 'Create Item',
      description = 'Creates item and saves it to items.lua',
      icon = 'fas fa-clipboard',
      event = "supreme_oxitems:openItemMenu",
     },
     {
      title = 'Image URL Viewer',
      description = 'Input URL to view image on screen',
      icon = 'fas fa-link',
      event = "supreme_oxitems:openImageMenu",
     },
     {
      title = 'Spawn Vehicle',
      description = 'Spawn in a vehicle',
      icon = 'fas fa-car',
      event = "supreme_oxitems:openCarMenu",
     },
     {
      title = 'Teleport',
      description = 'Teleport to coords',
      icon = 'fas fa-wind',
      event = "supreme_oxitems:openTeleportMenu",
     },
     {
      title = 'Player Coords - (Press to copy)',
      description = 'vector3('..coordsStr..')',
      icon = 'fa-universal-access',
      event = "supreme_oxitems:saveCoords",
      args = {
         coords = coordsStr
      }
  }
   },
})
lib.showContext('devtools')
elseif Config.Framework == "ui" then
   SetDisplay(not display)
end
end)

RegisterNetEvent('supreme_oxitems:openItemMenu')
AddEventHandler('supreme_oxitems:openItemMenu', function()
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

RegisterNetEvent('supreme_oxitems:openImageMenu')
AddEventHandler('supreme_oxitems:openImageMenu', function()
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

RegisterNetEvent('supreme_oxitems:openTeleportMenu')
AddEventHandler('supreme_oxitems:openTeleportMenu', function()
   local data = lib.inputDialog("Enter Coords", {
      {
          type = "input",
          label = "X",
          icon = "",
          required = true
       },
       {
         type = "input",
         label = "Y",
         icon = "",
         required = true
      },
      {
         type = "input",
         label = "Z",
         icon = "",
         required = true
      },
      })
      local x = tonumber(data[1])
      local y = tonumber(data[2])
      local z = tonumber(data[3])
SetEntityCoords(PlayerPedId(), x,y,z)
end)

RegisterNetEvent('supreme_oxitems:openCarMenu')
AddEventHandler('supreme_oxitems:openCarMenu', function()
   local data = lib.inputDialog("Enter Vehicle Model", {
      {
          type = "input",
          label = "Enter model name",
          icon = "",
          required = true
      },
      })
      local vehicleName = data[1]
      local playerPed = PlayerPedId()
      local playerCoords = GetEntityCoords(playerPed)
      local playerHeading = GetEntityHeading(playerPed)
      local vehicleModel = GetHashKey(vehicleName)
      
      RequestModel(vehicleModel)
      while not HasModelLoaded(vehicleModel) do
          Citizen.Wait(0)
      end
  
      local vehicle = CreateVehicle(vehicleModel, playerCoords, playerHeading, true, false)
      SetPedIntoVehicle(playerPed, vehicle, -1)
      TriggerEvent('qb-vehiclekeys:client:AddKeys', GetVehicleNumberPlateText(vehicle))
end)

RegisterNetEvent('supreme_oxitems:saveCoords')
AddEventHandler('supreme_oxitems:saveCoords', function(args)
SendNUIMessage({
   coords = 'vector3('..args.coords..')'
})
end)

local isNoclipEnabled = false
RegisterNetEvent('supreme_oxitems:noClip')
AddEventHandler('supreme_oxitems:noClip', function()
   isNoclipEnabled = not isNoclipEnabled

   -- toggle noclip mode
   SetEntityInvincible(PlayerPedId(), isNoclipEnabled)
   SetEntityCollision(PlayerPedId(), not isNoclipEnabled, not isNoclipEnabled)
   SetEntityAlpha(PlayerPedId(), isNoclipEnabled and 0 or 255, false)
   SetPlayerInvincible(PlayerId(), isNoclipEnabled)
   SetEntityVisible(PlayerPedId(), not isNoclipEnabled, false)

   -- show status message
   local status = isNoclipEnabled and "^2enabled" or "^1disabled"
   TriggerEvent("chat:addMessage", {
       color = {255, 255, 255},
       args = {"Noclip", "Noclip mode " .. status}
   })
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

RegisterNUICallback("exit", function()
   SetDisplay(false)
end)

RegisterNUICallback("itemCreate", function(data)
   TriggerServerEvent('supreme_oxitem:addItem', data.name, data.label, data.weight, data.stack, data.close, data.description)
   TriggerServerEvent('supreme_oxitem:addImage', data.name, data.image)
   SetDisplay(false)
end)

RegisterNUICallback("image", function(data)
   Wait(500)
   TriggerEvent('supreme_oxitem:viewImage', data.url)
end)

RegisterNUICallback("carModel", function(data)
   SetDisplay(false)
   local vehicleName = data.model
   local playerPed = PlayerPedId()
   local playerCoords = GetEntityCoords(playerPed)
   local playerHeading = GetEntityHeading(playerPed)
   local vehicleModel = GetHashKey(vehicleName)
   
   RequestModel(vehicleModel)
   while not HasModelLoaded(vehicleModel) do
       Citizen.Wait(0)
   end

   local vehicle = CreateVehicle(vehicleModel, playerCoords, playerHeading, true, false)
   SetPedIntoVehicle(playerPed, vehicle, -1)
   TriggerEvent('qb-vehiclekeys:client:AddKeys', GetVehicleNumberPlateText(vehicle))
end)

RegisterNUICallback("error", function(data)
   print(data.error)
   SetDisplay(false)
end)

function SetDisplay(bool)
   display = bool
   SetNuiFocus(bool, bool)
   SendNUIMessage({
       type = "ui",
       status = bool,
   })
end

Citizen.CreateThread(function()
   while display do
       Citizen.Wait(0)
       DisableControlAction(0, 1, display)
       DisableControlAction(0, 2, display)
       DisableControlAction(0, 142, display)
       DisableControlAction(0, 18, display)
       DisableControlAction(0, 322, display)
       DisableControlAction(0, 106, display)
   end
end)