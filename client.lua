RegisterCommand('oxadditem', function()
    local data = lib.inputDialog("Enter Item Details", {
        {
            type = "input",
            label = "Item name (ex - water)",
            icon = ""
         },
         {
            type = "input",
            label = "Item Label",
            icon = ""
         },
         {
            type = "input",
            label = "Weight",
            icon = ""
         },
         {
            type = "input",
            label = "Stack (true or false)",
            icon = ""
         },
         {
            type = "input",
            label = "Close (true or false)",
            icon = ""
         },
         {
            type = "input",
            label = "Description",
            icon = ""
         }
    })
 TriggerServerEvent('supreme_oxitem:addItem', data[1], data[2], data[3], data[4], data[5], data[6])
end)
