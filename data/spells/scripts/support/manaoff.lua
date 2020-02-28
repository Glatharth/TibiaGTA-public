local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_RED)
setCombatParam(combat, COMBAT_PARAM_DISPEL, CONDITION_MANASHIELD)
setCombatParam(combat, COMBAT_PARAM_AGGRESSIVE, 0)

function onCastSpell(cid, var)
return doCombat(cid, combat, var)
end