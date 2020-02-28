function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local _config = _config_GTA
	local ItemPosLEFT = player:getSlotItem(CONST_SLOT_LEFT)
	local id = 12695
	local muni = 12698
	local position = player:getPosition()

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
		if player:getItemCount(muni) < 1 then
			player:sendTextMessage(MESSAGE_INFO_DESCR, "Voce nao tem municao.")
			return false
		elseif player:getTarget() then
			local level = player:getLevel() / 3
			local distance = player:getSkillLevel(SKILL_DISTANCE)
			local arma_random = math.random(5, 15)
			local muni_random = math.random(5, 10)
			local damage = arma_random + muni_random + level + distance
			player:removeItem(muni, 1)
			position:sendDistanceEffect(toPosition, 41)
			doTargetCombatHealth(player, target, COMBAT_ICEDAMAGE, -damage, -damage, _config.blood)
			Player.setExhaustion(player, _config.storage_exhaust, 2)
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
