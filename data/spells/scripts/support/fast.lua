local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_GREEN)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)

local condition = Condition(CONDITION_HASTE)
condition:setParameter(CONDITION_PARAM_TICKS, 22000)
condition:setFormula(0.7, -56, 0.7, -56)
combat:addCondition(condition)

function onCastSpell(creature, variant)
	if not creature:removeMoney(500) then
		creature:sendTextMessage(MESSAGE_STATUS_WARNING, "Voce nao tem dinheiro.")	
		return false
	end
	return combat:execute(creature, variant)
end
