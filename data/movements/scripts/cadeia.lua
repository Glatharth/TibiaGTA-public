function onStepIn(creature, item, position, fromPosition)
	if Player.getExhaustion(creature, _config_GTA.storage_cadeia_time) > 0 then
		creature:teleportTo(fromPosition, true)
		creature.sendCancelMessage(creature, "Voc� est� preso, falta "..Player.getExhaustion(creature, _config_GTA.storage_cadeia_time).." segundos para voc� pode sair.")
		
		return false
	end
	return true
end