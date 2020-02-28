function onSay(player, words, param)
	if not player:getGroup():getAccess() then
		return true
	end

	player:teleportTo({x = 1237, y = 487, z = 7})
	
	return false
end
