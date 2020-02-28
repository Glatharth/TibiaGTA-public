local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_HEALING)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
combat:setParameter(COMBAT_PARAM_TARGETCASTERORTOPMOST, true)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)

function onGetFormulaValues(player, level, maglevel)
	local min = (level / 3) + 40
	local max = (level / 3) + 65
	if _Sistemas[1].enable == 1 then
		local Clan = Clan:new(player:getVocation():getName())
		if Clan:getAtributoValue('Heal') > 0 then
			local percent_min = min * (Clan:getAtributoValue('Heal') / 100)
			local percent_max = max * (Clan:getAtributoValue('Heal') / 100)
			min = min + percent_min
			max = max + percent_max
		end
	end
	return min, max
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

function onCastSpell(creature, variant, isHotkey)
	return combat:execute(creature, variant)
end
