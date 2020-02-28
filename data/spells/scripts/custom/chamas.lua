local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_FIREAREA)
combat:setArea(createCombatArea(AREA_BEAM5, AREADIAGONAL_BEAM5))

function onGetFormulaValues(player, level, maglevel)
	if player:getStorageValue(_config_GTA.storage_moto) <= 0 then
		player:sendTextMessage(MESSAGE_STATUS_WARNING, "Voce precisa estar montado na moto.")
		return false
	end

	local min = 500
	local max = 500
	return -min, -max
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

function onCastSpell(creature, variant)
	if creature:getStorageValue(_config_GTA.storage_moto) <= 0 then
		creature:sendTextMessage(MESSAGE_STATUS_WARNING, "Voce precisa estar montado na moto.")
		return false
	end
	return combat:execute(creature, variant)
end
