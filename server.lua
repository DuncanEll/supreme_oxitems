RegisterServerEvent('supreme_oxitem:addItem')
AddEventHandler('supreme_oxitem:addItem', function(name, label2, weight, stack, close, description)
	if IsPlayerAceAllowed(source, "oxitems") then
	local src = source
	local path = GetResourcePath(GetCurrentResourceName())
	path = path:gsub('//', '/')..'/createditems.lua'

	file = io.open(path, 'a+')
	if not itemname then label = "\n['"..name.."'] = {\n"
	else
		label = '\n\n-- '..itemname.. '\n[]'
	end
	file:write(label)
	file:write(
		
	"label = '"..label2.."',\n".."weight = "..weight..",\n".."stack = "..stack..",\n".."close = "..close..",\n".."description = '"..description.."',\n"
)
	file:write('},')
	file:close()
end
end)

RegisterServerEvent('supreme_oxitem:addImage')
AddEventHandler('supreme_oxitem:addImage', function(name, url)
	if IsPlayerAceAllowed(source, "oxitems") then
	PerformHttpRequest(url, function (errorCode, imageData, resultHeaders)
		local path = GetResourcePath("ox_inventory")
		path = path:gsub('//', '/')..'/web/images/'..name..'.png'
		local f = assert(io.open(path, 'wb')) 
        f:write(imageData)
        f:close()
	  end)
	end
end)


RegisterCommand('oxadditem', function(source)
    if IsPlayerAceAllowed(source, "oxitems") then
        TriggerClientEvent("supreme_oxitems:openMenu", source)
	else
		print('not allowed')
    end
end)
