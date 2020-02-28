function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local Clan = Clan:new(player:getVocation():getName())
	local Hunt = _Sistemas[1].config.Hunt
	local Position = player:getPosition()
	local monster = "Mutante"
	local Method = player:getVocation():getName()
	
	if _Sistemas[1].enable == 0 then
		return false
	end

	if player:getAccountId() ~= Clan:leader() then
		return false
	end

	if Clan:getHuntValue('Spawn') <= 0 or Clan:getHuntValue('Monster') <= 0 or Clan:getHuntValue('Expand') <= 0 then
		return false
	end


	local removeB = ((Clan:getHuntValue('Spawn') * Hunt['Spawn'].price) + (Clan:getHuntValue('Monster') * Hunt['Monster'].price)) * Clan:getHuntValue('Expand')
	if Clan:removeBalance(removeB) == false then
		player.sendCancelMessage(player, "O clan não tem dinheiro para isso.")
		return false
	end

	local i = 0
	local expands = {
		[1] = {
			{x = 8, y = 16, z = toPosition.z, monster = monster},
			{x = 0, y = 47, z = toPosition.z, monster = monster},
			{x = 15, y = 25, z = toPosition.z, monster = monster}
		},
		[2] = {
			{x = 8, y = 16, z = toPosition.z, monster = monster},
			{x = 0, y = 47, z = toPosition.z, monster = monster},
			{x = 15, y = 25, z = toPosition.z, monster = monster}
		},
		[3] = {
			{x = 8, y = 16, z = toPosition.z, monster = monster},
			{x = 0, y = 47, z = toPosition.z, monster = monster},
			{x = 15, y = 25, z = toPosition.z, monster = monster}
		},
		[4] = {
			{x = 8, y = 16, z = toPosition.z, monster = monster},
			{x = 0, y = 47, z = toPosition.z, monster = monster},
			{x = 15, y = 25, z = toPosition.z, monster = monster}
		},
		[5] = {
			{x = 8, y = 16, z = toPosition.z, monster = monster},
			{x = 0, y = 47, z = toPosition.z, monster = monster},
			{x = 15, y = 25, z = toPosition.z, monster = monster}
		}
	}
	
	local pos = {}
	for i, c in ipairs(expands) do
		if i <= Clan:getHuntValue('Expand') then
			for u, d in ipairs(expands[i]) do
				if i <= Clan:getHuntValue('Expand') then
					table.insert(pos, 1, expands[i][u])
				end
			end
		else
			break
		end
	end
	for i, c in ipairs(pos) do
		pos[i].x = pos[i].x + toPosition.x
		pos[i].y = toPosition.y - pos[i].y
	end
	if item:getId() == 1945 then
		local Spawn = Spawn:new("Spawn", pos, Method)
		Spawn:Save()
		Spawn:setLimit(Clan:getHuntValue('Spawn'))
		item:transform(item:getId() + 1)
		Spawn:createMonsters(false, false)
	else
		item:transform(item:getId() - 1)
	end
end