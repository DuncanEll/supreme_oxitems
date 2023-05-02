RegisterServerEvent('supreme_oxitem:addItem')
AddEventHandler('supreme_oxitem:addItem', function(name, label2, weight, stack, close, description)
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
end)
