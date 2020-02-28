function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local Position = player:getPosition()
	local monster = player:getStorageValue(_Storage['QG'])
	local monsters = _Sistemas[3].monsters
	local Method = getItemUID(item)
	if _Sistemas[3].enable == 0 then
		return false
	end
	if monster == -1 or monster == nil then
		player:sendTextMessage(MESSAGE_INFO_DESCR, "Escolha um monstro primeiro!")
		Position:sendMagicEffect(CONST_ME_POFF)
		return false
	end
	local monster = monsters[monster].name
	local i = 0
	local pos = {
		{x = 8, y = 16, z = toPosition.z, monster = monster},
		{x = 0, y = 47, z = toPosition.z, monster = monster},
		{x = 15, y = 25, z = toPosition.z, monster = monster},
		{x = 16, y = 47, z = toPosition.z, monster = monster},
		{x = 30, y = 25, z = toPosition.z, monster = monster},
		{x = 30, y = 47, z = toPosition.z, monster = monster},
		{x = 45, y = 25, z = toPosition.z, monster = monster},
		{x = 45, y = 47, z = toPosition.z, monster = monster},
		{x = 59, y = 25, z = toPosition.z, monster = monster},
		{x = 62, y = 47, z = toPosition.z, monster = monster},
		{x = 77, y = 25, z = toPosition.z, monster = monster},
		{x = 77, y = 8, z = toPosition.z, monster = monster},
		{x = 53, y = 17, z = toPosition.z, monster = monster},
		{x = 36, y = 17, z = toPosition.z, monster = monster},
		{x = 21, y = 17, z = toPosition.z, monster = monster},
		{x = 3, y = 0, z = toPosition.z, monster = "Training Monk"},
		{x = 5, y = 0, z = toPosition.z, monster = "Training Monk"}
	}
	for i, c in ipairs(pos) do
		pos[i].x = pos[i].x + toPosition.x
		pos[i].y = toPosition.y - pos[i].y
	end
	if item:getId() == 1945 then
		local Spawn = Spawn:new("Spawn", pos, Method)
		Spawn:Save()
		item:transform(item:getId() + 1)
		Spawn:createMonsters(false, false)
	else
		local Spawn = SpawnLoad(Method)
		Spawn:killMonsters()
		Spawn:setState(false)
		item:transform(item:getId() - 1)
	end
end