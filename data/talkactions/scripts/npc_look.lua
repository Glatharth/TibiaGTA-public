function onSay(player, words, param)
	if _Sistemas[2].enable == 1 then
		if player:getStorageValue(_Sistemas[2].storage) == 1 then
			player:setStorageValue(_Sistemas[2].storage, 0)
			player:sendTextMessage(MESSAGE_EVENT_DEFAULT, "Você desativou o NPC look.")
		else 
			player:setStorageValue(_Sistemas[2].storage, 1) 
			player:sendTextMessage(MESSAGE_EVENT_DEFAULT, "Você ativou o NPC look.")
		end
	else player:sendTextMessage(MESSAGE_EVENT_DEFAULT, _Sistemas[2].message_disable) end
	return false
end