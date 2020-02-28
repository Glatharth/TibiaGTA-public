local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                          npcHandler:onThink()                        end


local nameNPC = NPC_config['Riara']
local msgReturn
local exit = 10000
local initStorage
local finalStorage
local rewards
local takeItem
local allow

local function allowTable(paramtable, var)
	if table.maxn(paramtable) == var then
		return true
	else
		return false
	end
	return error()
end

local function checkTable(table)
	local enter
	for i, c in ipairs(table) do
		if player:getStorageValue(table[i][1]) >= table[i][2] then
			enter = enter + 1
		else
			break
		end
	end
	return enter
end


local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end
	local player = Player(cid)
	msg = string.lower(msg)

	-- O NPC fala quais quests estão disponiveis.
	if msgcontains(msg, "quest") then
		msgReturn = "As quests disponiveis para você são: "
		i = 0
		for i, c in pairs(nameNPC.quest) do
			if nameNPC.quest[i].secretQuest == true then
				if nameNPC.quest[i].requirementQuest ~= nil then
					if allowTable(nameNPC.quest[i].requirementQuest, checkTable(nameNPC.quest[i].requirementQuest)) then
						msgReturn = msgReturn..", "..i
					end
				else
					print("Error NPC Riara: secretQuest")
					print(error())
					msgReturn = msgReturn..", "..i
				end
			else
				msgReturn = msgReturn..", "..i
			end
		end
		npcHandler:say(msgReturn, cid)
		npcHandler.topic[cid] = 1
	--
	elseif npcHandler.topic[cid] == 1 then
		if isInArray(nameNPC.quest, nameNPC.quest[tostring(msg)]) then
			-- Caso especial, por isso não usei a função checkTable()
			-- Ele verifica se o player já fez a quest.
			initStorage = nameNPC.quest[msg].initStorage
			local allow_initStorage = 0
			for i, c in ipairs(initStorage) do
				if player:getStorageValue(initStorage[i][1]) >= initStorage[i][3] then
					allow_initStorage = allow_initStorage + 1
				else
					break
				end
			end
			--
			-- Caso ele tenha feito, ele ganha as rewards.
			if allowTable(initStorage, allow_initStorage) then
				takeItem = nameNPC.quest[msg].takeItem
				if takeItem ~= nil then
					if allowTable(takeItem, checkTable(takeItem)) then
						for i, c in ipairs(takeItem) do
							player:removeItem(takeItem[i][1], takeItem[i][2])
						end
					else
						npcHandler:say("Está faltando alguns itens", cid)
						npcHandler.topic[cid] = exit
						return false
					end
				end
				-- Rewards
				rewards = nameNPC.quest[msg].rewards
				for i, c in ipairs(rewards) do
					player:addDepotItems(rewards[i][1], rewards[i][2], 100)
				end
				local finalStorage = nameNPC.quest[msg].finalStorage
				for i, c in ipairs(finalStorage) do
					player:setStorageValue(finalStorage[i][1], finalStorage[i][2])
				end
				npcHandler:say(nameNPC.quest[msg].finalMessage, cid)
				npcHandler.topic[cid] = exit
				--
			--
			-- Verifica se o player tem os requerimentos para fazer a quest
			local requirementQuest = nameNPC.quest[msg].requirementQuest
			elseif requirementQuest ~= nil then
				if allowTable(requirementQuest, checkTable(requirementQuest)) then
					allow = true
				else
					allow = false
					npcHandler.topic[cid] = exit
				end
			end
			if allow == true or allow == nil then
				npcStorageMSG = msg
				npcHandler:say(nameNPC.initMessage, cid)
				npcHandler:say("Tem certeza que você quer fazer a quest {".. msg .. "}?", cid)
				npcHandler.topic[cid] = 2
			end
		end
	elseif npcHandler.topic[cid] == 2 and msg == "yes" then
		initStorage = nameNPC.quest[npcStorageMSG].initStorage
		for i, c in ipairs(initStorage) do
			if player:getStorageValue(initStorage[i][1]) < 0 then
				player:setStorageValue(initStorage[i][1], initStorage[i][2])
			end
		end
		npcHandler:say("Você está fazendo a quest agora.", cid)
	elseif npcHandler.topic[cid] == exit then
		npcHandler:say("Você deseja mais alguma coisa?", cid)
		npcHandler.topic[cid] = 0
	end
	return true
end

local function greetCallback(cid)
	local player = Player(cid)
	npcHandler:say({
		"Olá, eu posso ajudar você se você fizer alguma coisa por mim.",
		"Por exemplo: {quest}"		
	}, cid)
	return true
end

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())