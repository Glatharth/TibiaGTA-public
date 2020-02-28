function onStepIn(creature, item, position, fromPosition)
	if not isPremium(creature) then
		creature:teleportTo(fromPosition, true)
		return true
	end
	return true
end