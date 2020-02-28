function onLogout(player)
	local playerId = player:getId()
	if nextUseStaminaTime[playerId] ~= nil then
		nextUseStaminaTime[playerId] = nil
	end
	--player:setStorageValue(_config_GTA.storage_moto_check, 0)
	return true
end
