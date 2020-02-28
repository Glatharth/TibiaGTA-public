function onStepIn(creature, item, position, fromPosition)
	if item.actionid == 30000 then
		creature:teleportTo(fromPosition, true)
	end
	return true
end