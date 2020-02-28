function onSay(player, words, param)
	if not player:getGroup():getAccess() then
		return true
	end

	if player:getAccountType() < ACCOUNT_TYPE_GOD then
		return false
	end

	local split = param:split(",")
	local itemType = ItemType(split[1])
	if itemType:getId() == 0 then
		itemType = ItemType(tonumber(split[1]))
		if itemType:getId() == 0 then
			player:sendCancelMessage("There is no item with that id or name.")
			return false
		end
	end

	if not isInArray(keys, itemType:getId()) then
		player:sendCancelMessage("There is no key.")
		return false
	end

	local keyActionID = tonumber(split[2])
	if keyActionID == nil then
		keyActionID = 1
	end
	local item = player:addItem(itemType:getId(), 1)
	item:setActionId(keyActionID)
	player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
	return false
end
