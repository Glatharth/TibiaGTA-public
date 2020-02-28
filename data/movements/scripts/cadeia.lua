function onStepIn(creature, item, position, fromPosition)
	if Player.getExhaustion(creature, _config_GTA.storage_cadeia_time) > 0 then
		creature:teleportTo(fromPosition, true)
		creature.sendCancelMessage(creature, "Você está preso, falta "..Player.getExhaustion(creature, _config_GTA.storage_cadeia_time).." segundos para você pode sair.")
		
		return false
	end
	return true
end