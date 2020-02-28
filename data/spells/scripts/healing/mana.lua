local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
combat:setParameter(COMBAT_PARAM_TARGETCASTERORTOPMOST, true)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)

function onCastSpell(creature, variant, isHotkey)
	local min = (level / 3.3) + 230
	local max = (level / 3) + 300
	local random = math.random(min, max)
	creature:addMana(random)
	return combat:execute(creature, variant)
end
