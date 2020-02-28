function onSay(player, words, param)
	local _config = _config_GTA
	local storage = _config.storage_muni
	local param = tonumber(param)
	if not param then
		if player:getStorageValue(storage) == -1 then
			player:setStorageValue(storage, 1)
			player:sendTextMessage(MESSAGE_INFO_DESCR, "Voce mudou a municao para "..Municao[player:getStorageValue(storage)].name..".")
			return false
		end
		if player:getStorageValue(storage) == table.maxn(Municao) then
			player:setStorageValue(storage, 1)
		else
			player:setStorageValue(storage, player:getStorageValue(storage) + 1)
		end
		player:sendTextMessage(MESSAGE_INFO_DESCR, "Voce mudou a municao para "..Municao[player:getStorageValue(storage)].name..".")
		return false
	else
		if param > table.maxn(Municao) then
			player:sendTextMessage(MESSAGE_INFO_DESCR, "Nao existe essa municao.")
			return true
		end
		player:setStorageValue(storage, param)
		player:sendTextMessage(MESSAGE_INFO_DESCR, "Voce mudou a municao para "..Municao[param].name..".")
		return false	
	end
end