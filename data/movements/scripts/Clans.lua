function onStepIn(creature, item, position, fromPosition)
	if _Sistemas[1].enable == 0 then
		return false
	end
	if item.actionid == 31000 then
		Clan = Clan:new('Justiceiro')
		if creature:getAccountId() ~= Clan:leader() then -- Justiceiro
			creature:teleportTo(fromPosition, true)
			return false
		end
	end

	if item.actionid == 32000 then
		Clan = Clan:new('Renegado')
		if creature:getAccountId() ~= Clan:leader() then -- Renegado
			creature:teleportTo(fromPosition, true)
			return false
		end
	end
	return true
end