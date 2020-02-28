function onEquip(player, item)
	if player:getStorageValue(_config_GTA.storage_moto_check) >= 3 then
		return false
	end
	local speed = Capacete[item:getName()].speed
	local playerOutfit = player:getOutfit()

	if (player:getVocation():getId() == (1 or 3)) then
		playerOutfit.lookType = Capacete[item:getName()].looktype_J
	elseif (player:getVocation():getId() == (2 or 4)) then
		playerOutfit.lookType = Capacete[item:getName()].looktype_R
	elseif player:getAccountType() >= ACCOUNT_TYPE_GAMEMASTER then
		playerOutfit.lookType = Capacete[item:getName()].looktype_R
	else
		player:sendTextMessage(MESSAGE_STATUS_WARNING, "Ocorreu um erro, contate a Staff. Error: MVOnEquipCapacete.")
		return false
	end
	player:setStorageValue(_config_GTA.storage_moto_check, (player:getStorageValue(_config_GTA.storage_moto_check) + 1))	
	doSetCreatureOutfit(player, playerOutfit, 100000)
	if player:getBaseSpeed() == player:getSpeed() then
		player:changeSpeed(speed)
		player:setStorageValue(_config_GTA.storage_moto, 1)
	end
	return true
end

function onDeEquip(player, item)
	local speed = player:getBaseSpeed() - player:getSpeed()
	player:removeCondition(CONDITION_OUTFIT)
	player:changeSpeed(speed)
	player:setStorageValue(_config_GTA.storage_moto, 0)
	player:setStorageValue(_config_GTA.storage_moto_check, 0)
	return true
end