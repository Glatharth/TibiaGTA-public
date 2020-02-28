local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                          npcHandler:onThink()                        end

local function creatureSayCallback(cid, type, msg)
	if _Sistemas[4].enable ~= 1 then
		npcHandler:say(_Sistemas[4].message_disable, cid)
		npcHandler.topic[cid] = 0
		return false
	end
	if not npcHandler:isFocused(cid) then
		return false
	end
	local player = Player(cid)
	msg = string.lower(msg)

	if msgcontains(msg, "no") then
		npcHandler.topic[cid] = 0
		npcHandler:say("Deseja mais alguma coisa?", cid)
		return false
	end

	if msgcontains(msg, "lista") then
		local lista = "Lista de procurados:"
		for i, c in pairs(Game.getPlayers()) do
			if c:getStorageValue(_Sistemas[4].config['Hunted_storage']) >= 1 then
				lista = lista.."\n"..c:getName()..": "..c:getStorageValue(_Sistemas[4].config['Hunted_storage'])
			end
		end
		npcHandler:say(lista, cid)
	end
	if msgcontains(msg, "hunted") then
		npcHandler:say("Qual o nome?", cid)
		npcHandler.topic[cid] = 1
	elseif npcHandler.topic[cid] == 1 then
		local hunted = false
		for i, c in pairs(Game.getPlayers()) do
			if string.lower(c:getName()) == msg then
				if player:getAccountType() < ACCOUNT_TYPE_GAMEMASTER then
					if c:getLevel() >= _Sistemas[4].config['Level'] then
						hunted = true
						hunted_userdata = Player(c:getName())
					end
				end
				break
			end
		end
		if hunted == true then
			calculate = (hunted_userdata:getLevel()^3) - ((hunted_userdata:getLevel()^2) * (hunted_userdata:getLevel() - 130))
			local price = "O preço minimo é {"..calculate.."}, deseja continuar?"
			npcHandler:say(price, cid)
			npcHandler.topic[cid] = 2
		else
			npcHandler:say("Desculpe, o nome está errado ou o player está offline ou ele não tem level o suficiente. Tente novamente mais tarde.", cid)
		end
	elseif npcHandler.topic[cid] == 2 and msgcontains(msg, "yes") then
		npcHandler:say("Você tem certeza que quer colocar a cabeça do {"..hunted_userdata:getName().."} por {"..calculate.."}?", cid)
		npcHandler.topic[cid] = 3
	elseif npcHandler.topic[cid] == 3 and msgcontains(msg, "yes") then
		if player:removeMoney(calculate) then
			hunted_userdata:setStorageValue(_Sistemas[4].config['Hunted_storage'], hunted_userdata:getStorageValue(_Sistemas[4].config['Hunted_storage']) + calculate)
			npcHandler:say("Prontinho.", cid)
		else
			npcHandler:say("Você não tem dinheiro.", cid)
		end
		npcHandler.topic[cid] = 0
	end

	if msgcontains(msg, "remover") then
		npcHandler:say("Qual o nome?", cid)
		npcHandler.topic[cid] = 4
	elseif npcHandler.topic[cid] == 4 then
		local remove = false
		for i, c in pairs(Game.getPlayers()) do
			if string.lower(c:getName()) == msg then
				if c:getStorageValue(_Sistemas[4].config['Hunted_storage']) >= 1 then
					remove = true
					remove_userdata = Player(c:getName())
				end
				break
			end
		end
		if remove == true then
			calculate = remove_userdata:getStorageValue(_Sistemas[4].config['Hunted_storage'])
			local price = "O preço para remover é de {"..calculate.."}, deseja continuar?"
			npcHandler:say(price, cid)
			npcHandler.topic[cid] = 5
		else
			npcHandler:say("Desculpe, o nome está errado ou o player está offline ou ele não tem level o suficiente. Tente novamente mais tarde.", cid)
		end
	elseif npcHandler.topic[cid] == 5 and msgcontains(msg, "yes") then
		npcHandler:say("Você tem certeza que quer remover o preço da cabeça do {"..hunted_userdata:getName().."} por {"..calculate.."}?", cid)
		npcHandler.topic[cid] = 6
	elseif npcHandler.topic[cid] == 6 and msgcontains(msg, "yes") then
		if player:removeMoney(calculate) then
			hunted_userdata:setStorageValue(_Sistemas[4].config['Hunted_storage'], 0)
			npcHandler:say("Prontinho.", cid)
		else
			npcHandler:say("Você não tem dinheiro.", cid)
		end
		npcHandler.topic[cid] = 0
	end


	return true
end

local function greetCallback(cid)
	local player = Player(cid)
	if player:getLevel() <= _Sistemas[4].config['Level'] then
		npcHandler:say("Volte mais tarde, não tenho nada para se tratar com você.", cid)
	end
	return true
end

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())