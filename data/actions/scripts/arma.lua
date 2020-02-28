function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local _config = _config_GTA
	local name = item:getName()
	local id = item:getId()
	local position = player:getPosition()
	local name = item:getName()
	local ItemPosLEFT = player:getSlotItem(CONST_SLOT_LEFT)
	local storage_muni = player:getStorageValue(_config.storage_muni)

	if player:getStorageValue(_config_GTA.storage_moto) >= 1 then
		local item = player:getSlotItem(CONST_SLOT_HEAD)
		if Capacete[item:getName()].attack == false then
			return false
		end
	end

	if Player.getExhaustion(player, _config.storage_exhaust) > 0 then
        return false
    end

    if getTilePzInfo(player:getPosition()) then
    	return false
    end

	if (ItemPosLEFT == nil) then
		player:sendTextMessage(MESSAGE_INFO_DESCR, "Voce precisa estar com a arma equipada na mao esquerda.")
		return false
	end
	if (ItemPosLEFT.itemid == id) then
		if storage_muni == -1 then
			player:sendTextMessage(MESSAGE_INFO_DESCR, "Selecione alguma municao. !arma")
			return false
		end
		if isInArray(Arma[name].municoes, Municao[storage_muni].id) == false then
			player:sendTextMessage(MESSAGE_INFO_DESCR, "Sua arma nao pode usar essa municao.")
			return false	
		end

		if player:getItemCount(Municao[storage_muni].id) < 1 then
			player:sendTextMessage(MESSAGE_INFO_DESCR, "Voce nao tem municao.")
			return false
		elseif player:getTarget() then
			local level = player:getLevel() / 3
			local distance = player:getSkillLevel(SKILL_DISTANCE)
			local arma_random = math.random(Arma[name].min, Arma[name].max)
			local muni_random = math.random(Municao[storage_muni].min, Municao[storage_muni].max)
			local damage = arma_random + muni_random + level + distance
			player:removeItem(Municao[storage_muni].id, Arma[name].amount)
			position:sendDistanceEffect(toPosition, Municao[player:getStorageValue(_config.storage_muni)].distance)
			doTargetCombatHealth(player, target, Municao[storage_muni].combat, -damage, -damage, _config.blood)
			Player.setExhaustion(player, _config.storage_exhaust, Arma[name].exhaust)
			return damage
		end
		position:sendDistanceEffect(toPosition, Municao[player:getStorageValue(_config.storage_muni)].distance)
    	toPosition:sendMagicEffect(_config.blood)
    else
    	player:sendTextMessage(MESSAGE_INFO_DESCR, "Voce precisa estar com a arma equipada na mao esquerda.")	
    	return false
    end
    return false
end
