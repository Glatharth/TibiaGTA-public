-- local player = Player(cid)



function Player:addDepotItems(item, count, depot)
    local item, count, depot = {item}, {(count or 1)}, {depot or 100}
    for i, c in ipairs(item) do
        local list = db.getResult("SELECT `sid` FROM `player_depotitems` WHERE `player_id` = "..player.." ORDER BY `sid` DESC LIMIT 1")
        return db.executeQuery("INSERT INTO `player_depotitems` (`player_id`, `sid`, `pid`, `itemtype`, `count`, `attributes`) VALUES ("..player..", "..(list:getDataInt("sid")+1)..", " ..depot.. ", "..c..", "..count[i]..", '')") or LUA_CONSOLE_ERROR
    end
end




function enterCloseServer(player)
	local access = false
	if (isInArray(EnterCloseServer["staff"], player:getAccountType()) == true) then
		access = true
	elseif (isInArray(EnterCloseServer["IP"], player:getIp()) == true) then
		access = true
	elseif (isInArray(EnterCloseServer["names"], player:getName()) == true) then
		access = true
	elseif (player:getAccountType() >= ACCOUNT_TYPE_GOD) then
		access = true
	end
	if (access == false) then
		doPlayerPopupFYI(
			player,
			"Voc� n�o tem permiss�o para entrar no servidor.\nPara mais informa��es, converse com a staff do servidor."
		)
		return false
	else
		return true
	end
end

function getItemUID(item)
	local UID = (item:getPosition().x * item:getPosition().y * item:getPosition().z)
	if item:getActionId() then
		UID = UID * item:getActionId()
	end
	return UID
end

Clan = {}
function Clan:new(Clan)
	if _Sistemas[1].enable == 0 then
		print(_Sistemas[1].message_disable)
		return false
	end
	if Clan == nil then
		Clan = false
	else
		Clan = string.lower(Clan)
	end
	return setmetatable({status = _Sistemas[1].enable, clan = Clan}, {__index = self})
end

function Clan:leader()
	if _Sistemas[1].config["enable_functions_leaders"] == 0 then
		print("Disable: functions_leaders")
		return false
	end

	if self.clan == nil or false then
		print("Error: (Clan:leader)")
		return false
	end

	if self.clan == "justiceiro" then
		return self.justiceiro_leader
	end

	if self.clan == "renegado" then
		return self.renegado_leader
	end
	return false
end

function Clan:setLeader(Justiceiro, Renegado)
	if Justiceiro == nil then
		_Sistemas[1].config["enable_functions_leaders"] = 0
		print("Error: (Clan:setLeader(Justiceiro))")
		return false
	end

	if Renegado == nil then
		print("Error: (Clan:setLeader(Renegado))")
		_Sistemas[1].config["enable_functions_leaders"] = 0
		return false
	end

	if Justiceiro == false then
		print("Warning: (Clan:setLeader(Justiceiro)) = false")
	end

	if Renegado == false then
		print("Warning: (Clan:setLeader(Renegado)) = false")
	end

	self.justiceiro_leader = Justiceiro
	self.renegado_leader = Renegado
	_Sistemas[1].config["enable_functions_leaders"] = 1
	return true
end

function Clan:getBalance()
	local queryResult
	if self.clan == "justiceiro" then
		queryResult = db.storeQuery("SELECT `value` FROM `clans_config` WHERE `config` = 'Balance_Justiceiro'")
	end

	if self.clan == "renegado" then
		queryResult = db.storeQuery("SELECT `value` FROM `clans_config` WHERE `config` = 'Balance_Renegado'")
	end
	local result = result.getDataInt(queryResult, "value")
	return result
end

function Clan:removeBalance(value)
	local balance = self:getBalance()
	if balance >= value then
		if self.clan == "justiceiro" then
			db.query(
				"UPDATE `clans_config` SET `value` = value - " .. value .. " WHERE `clans_config`.`config` = 'Balance_Justiceiro';"
			)
		end

		if self.clan == "renegado" then
			db.query(
				"UPDATE `clans_config` SET `value` = value - " .. value .. " WHERE `clans_config`.`config` = 'Balance_Renegado';"
			)
		end
		return true
	end
	return false
end

function Clan:getAtributoValue(Atributo)
	local result
	if self.clan == "justiceiro" then
		result = getGlobalStorageValue(_Sistemas[1].config.Atributos[Atributo].global_storage_J)
	end

	if self.clan == "renegado" then
		result = getGlobalStorageValue(_Sistemas[1].config.Atributos[Atributo].global_storage_R)
	end
	return result
end

function Clan:getAtributoStorage(Atributo)
	local result
	if self.clan == "justiceiro" then
		result = _Sistemas[1].config.Atributos[Atributo].global_storage_J
	end

	if self.clan == "renegado" then
		result = _Sistemas[1].config.Atributos[Atributo].global_storage_R
	end
	return result
end

function Clan:setAtributoStorage(Atributo, value)
	setGlobalStorageValue(self:getAtributoStorage(Atributo), value)
end

function Clan:getHuntValue(Hunt)
	local result
	if self.clan == "justiceiro" then
		result = getGlobalStorageValue(_Sistemas[1].config.Hunt[Hunt].global_storage_J)
	end

	if self.clan == "renegado" then
		result = getGlobalStorageValue(_Sistemas[1].config.Hunt[Hunt].global_storage_R)
	end
	return result
end

function Clan:getHuntStorage(Hunt)
	local result
	if self.clan == "justiceiro" then
		result = _Sistemas[1].config.Hunt[Hunt].global_storage_J
	end

	if self.clan == "renegado" then
		result = _Sistemas[1].config.Hunt[Hunt].global_storage_R
	end
	return result
end

function Clan:setHuntStorage(Hunt, value)
	setGlobalStorageValue(self:getHuntStorage(Hunt), value)
end

Spawn = {}
SpawnInfo = {}
MonsterSpawn = {}
function Spawn:new(Event, Position, Method)
	return setmetatable(
		{
			event = Event,
			pos = Position,
			state = true,
			rateSpawn = 1000,
			method = Method or nil,
			save = false,
			limitSpawn = nil
		},
		{__index = self}
	)
end

function Spawn:createMonsters(extended, force)
	if self.state == false then
		return false
	end

	extended = extended or false
	force = force or false

	self.extended = extended
	self.force = force

	local i = 0
	for i, c in ipairs(self.pos) do
		local creature =
			Game.createMonster(
			self.pos[i].monster,
			Position(self.pos[i].x, self.pos[i].y, self.pos[i].z),
			self.extended,
			self.force
		)
		if creature then
			MonsterSpawn[creature:getId()] = {self = self, pos = i, limitSpawn = self.limitSpawn}
			creature:registerEvent(self.event)
			if self.save == true then
				table.insert(SpawnInfo[self.method].monsters, 1, creature:getId())
			end
		end
	end
end

function Spawn:killMonsters()
	for i, c in ipairs(SpawnInfo[self.method].monsters) do
		local creature = Creature(SpawnInfo[self.method].monsters[i])
		if creature then
			creature:remove()
			if creature:isRemoved() then
				SpawnInfo[self.method].monsters[i] = nil
			end
		end
	end
end

function Spawn:Save()
	SpawnInfo[self.method] = {spawn = self, monsters = {}}
	self.save = true
end

function SpawnLoad(Method)
	return SpawnInfo[Method].spawn
end

function Spawn:setState(state)
	self.state = state
end

function Spawn:getState()
	return self.state
end

function Spawn:setRate(value)
	self.rateSpawn = value
end

function Spawn:getRate()
	return self.rateSpawn
end

function Spawn:setLimit(value)
	self.limitSpawn = value
end

function Spawn:getLimit()
	return self.limitSpawn
end

function Spawn:createMonster(i, limitSpawn)
	if self.state == false then
		return false
	end

	if limitSpawn ~= nil then
		if limitSpawn <= 0 then
			return false
		end
	end

	local i = i
	local creature =
		Game.createMonster(
		self.pos[i].monster,
		Position(self.pos[i].x, self.pos[i].y, self.pos[i].z),
		self.extended,
		self.force
	)
	if creature then
		MonsterSpawn[creature:getId()] = {self = self, pos = i, rateSpawn = self.rateSpawn, limitSpawn = limitSpawn}
		creature:registerEvent(self.event)
	end
end

function SpawncreateMonster(i, self, limitSpawn)
	local Spawn = self
	Spawn:createMonster(i, limitSpawn)
end

Fazenda = {}
function Fazenda:new(Position, Vocation)
	return setmetatable({pos = Position, state = true, rateSpawn = 45000, vocation = Vocation}, {__index = self})
end

function Fazenda:saveDB(player_id, plant)
	local time
	local queryResult = db.storeQuery("SELECT `time` FROM `clans_fazenda` WHERE `pos` = '" .. self.pos .. "'")
	if queryResult ~= false then
		time = time.getDataInt(queryResult, "time")
	else
		time = 0
	end
	db.query(
		"INSERT INTO `clans_fazenda`(`player_id`, `player_vocation`, `pos`, `plant`, `time`) VALUES (" ..
			player_id .. ", '" .. self.vocation .. "', '" .. self.pos .. "', '" .. plant .. "', " .. time .. ")"
	)
end

-- Navegation = {}
-- function Navegation:new(init_pos, final_pos)
-- 	return setmetatable({init_pos = init_pos, final_pos = final_pos, speed = 500}, {__index = self})
-- end

-- function Navegation:setSpeed(value)
-- 	self.speed = value
-- end

-- function Navegation:getSpeed()
-- 	return self.speed
-- end

-- function Navegation:setId(value)
-- 	self.id = value
-- end

-- function Navegation:setLoop(boolean)
-- 	self.loop = boolean
-- end

-- function Navegation:getLoop()
-- 	return self.loop
-- end

-- function Navegation:start()
-- 	self.running = true
-- end

-- function Navegation:stop()
-- 	self.running = false
-- end

-- function Navegation:getPosition()
-- 	if
-- end

-- function Navegation:nav()
-- 	if
-- 	if self.id ~= nil then
-- 		while