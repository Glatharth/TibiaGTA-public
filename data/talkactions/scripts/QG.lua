function onSay(player, words, param)
	if _Sistemas[3].enable == 0 then
		return true
	end
	local storage = _Storage['QG']
	local monsters = _Sistemas[3].monsters
	local dialog = "Você precisa digitar o nome do monstro exatamente igual.Ex: !qg Mutante\nLista de monstros disponível na QG:"
	local param = tostring(param)
	player:sendTextMessage(MESSAGE_STATUS_CONSOLE_RED, words.." "..param)
	if param == "" then
		for i, c in ipairs(monsters) do
			if monsters[i].quest[1] == true and player:getStorageValue(monsters[i].quest[2]) >= monsters[i].quest[3] then
				dialog = dialog.."\n"..monsters[i].name
			elseif monsters[i].quest[1] == false then
				dialog = dialog.."\n"..monsters[i].name
			end
		end
		dialog = dialog.."\nEm breve mais monstros..."
		player:showTextDialog(7528, dialog)
		return false
	end
	for i, c in ipairs(monsters) do
		if monsters[i].name == param then
			if monsters[i].quest[1] == true and player:getStorageValue(monsters[i].quest[2]) < monsters[i].quest[3] then
				player.sendCancelMessage(player, "Você precisa fazer a quest para obter esse monstro!")
				return false
			end
			player:setStorageValue(storage, i)
			break
		end
	end
	return false
end