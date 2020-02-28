local _config = _config_GTA
local muni_random = 0
local item

local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, _config.blood)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, true)
combat:setParameter(COMBAT_PARAM_BLOCKARMOR, true)
combat:setParameter(COMBAT_PARAM_BLOCKSHIELD, true)

function onGetFormulaValues(player, level, maglevel)
	local item = player:getSlotItem(CONST_SLOT_LEFT)
	local name = item:getName()
    local level = player:getLevel() / 3
	local distance = player:getSkillLevel(SKILL_DISTANCE)
	local arma_random = math.random(Arma[name].min, Arma[name].max)
	local damage = arma_random + muni_random + level + distance
	local min, max = damage, damage
	if _Sistemas[1].enable == (1 and not nil)  then
		local Clan = Clan:new(player:getVocation():getName())
		if Clan:getAtributoValue('Damage') > 0 then
			local percent_min = min * (Clan:getAtributoValue('Damage') / 100)
			local percent_max = max * (Clan:getAtributoValue('Damage') / 100)
			min = min + percent_min
			max = max + percent_max
		end
	end
	return -min, -max
end

combat:setCallback(CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValues")

function onCastSpell(creature, variant, isHotkey)
	local player = creature
	if player:getSlotItem(CONST_SLOT_LEFT) == nil then
		return false
	else item = player:getSlotItem(CONST_SLOT_LEFT) end
	local name = item:getName()
	local id = item:getId()
	local position = player:getPosition()
	local ItemPosLEFT = player:getSlotItem(CONST_SLOT_LEFT)
	local storage_muni = player:getStorageValue(_config.storage_muni)

	--[[if player:getStorageValue(_config_GTA.storage_moto) >= 1 then
		local head = self:getSlotItem(CONST_SLOT_HEAD)
		local feet = self:getSlotItem(CONST_SLOT_FEET)
		if Capacete[head:getName()].attack == false or Capacete[feet:getName()].attack == false then
			return false
		end
	end]]--

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
		if table.maxn(Arma[name].municoes) > 1 then
			if isInArray(Arma[name].municoes, Municao[storage_muni]) == false then
				player:sendTextMessage(MESSAGE_INFO_DESCR, "Sua arma nao pode usar essa municao.")
				return false	
			end
			if player:getItemCount(Municao[storage_muni].id) < 1 then
				player:sendTextMessage(MESSAGE_INFO_DESCR, "Voce nao tem municao.")
				return false
			else
				muni_random = math.random(Municao[storage_muni].min, Municao[storage_muni].max)
				player:removeItem(Municao[storage_muni].id, Arma[name].amount)
				combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, Municao[player:getStorageValue(_config.storage_muni)].distance)
			end
		elseif player:getItemCount(Arma[name].municoes[1].id) < 1 then
			player:sendTextMessage(MESSAGE_INFO_DESCR, "Voce nao tem municao.")
			return false
		else
			player:removeItem(Arma[name].municoes[1].id, Arma[name].amount)
			muni_random = math.random(Arma[name].municoes[1].min, Arma[name].municoes[1].max)
			combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, Arma[name].municoes[1].distance)
		end
    else
    	player:sendTextMessage(MESSAGE_INFO_DESCR, "Voce precisa estar com a arma equipada na mao esquerda.")	
    	return false
	end
    combat:setParameter(COMBAT_PARAM_TYPE, Municao[storage_muni].combat)



	return combat:execute(creature, variant)
end