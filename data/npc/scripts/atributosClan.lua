local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                          npcHandler:onThink()                        end

local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end
	local player = Player(cid)
	local config = _Sistemas[1].config
	local Clan = Clan:new(player:getVocation():getName())
	msg = string.lower(msg)

	if msgcontains(msg, "atributos") then
		local atributos = "Otima escolha! O que deseja?\nLembrando que o saldo do seu clan é de {"..Clan:getBalance().."}"
		atributos = atributos.."\nAqui está o catalogo:"
		for i, c in pairs(config.Atributos) do
			if Clan:getAtributoValue(i) >= config.Atributos[i].max then
				atributos = atributos.."\n"..i..": Maximo"
			else
				atributos = atributos.."\n"..i..": "..((config.Atributos[i].price) * (Clan:getAtributoValue(i) + config.Atributos[i].min))
			end
		end
		npcHandler:say(atributos, cid)
		npcHandler.topic[cid] = 1
	elseif npcHandler.topic[cid] == 1 then
		npcHandler:say("Vejamos...", cid)
		local check_msg
		for i, c in pairs(config.Atributos) do
			if msgcontains(msg, i) then
				if Clan:getAtributoValue(i) >= config.Atributos[i].max then
					npcHandler.topic[cid] = 0
					npcHandler:say("Desculpa, mas não posso vender isso para você.",cid)
					break
				else
					buy_atributo = i
					npcHandler.topic[cid] = 2
					npcHandler:say("Tem certeza que você quer comprar: {"..i.."}?", cid)
				end
				check_msg = true
				break
			end
		end
		if check_msg ~= true then
			npcHandler:say("Não entendi o que você quer.", cid)
		end
	elseif msgcontains(msg, "yes") and npcHandler.topic[cid] == 2 then
		local atributo_add = Clan:getAtributoValue(buy_atributo) + config.Atributos[buy_atributo].min
		atributo_check = config.Atributos[buy_atributo].price * atributo_add
		if Clan:removeBalance(atributo_check) then
			npcHandler:say("Parabéns, você comprou a categoria atributo!", cid)
			Clan:setAtributoStorage(buy_atributo, atributo_add)
			print()
		else
			npcHandler:say("Desculpe, mas seu clan não possui dinheiro suficiente!", cid)
		end
		npcHandler.topic[cid] = 0
	elseif msgcontains(msg, "no") and npcHandler.topic[cid] == 2 then
		npcHandler:say("Deseja mais alguma coisa?", cid)
		npcHandler.topic[cid] = 0
	end



	if msgcontains(msg, "hunt") then
		local Hunt = "Otima escolha! O que deseja?\nLembrando que o saldo do seu clan é de {"..Clan:getBalance().."}"
		Hunt = Hunt.."\nAqui está o catalogo:"
		for i, c in pairs(config.Hunt) do
			if Clan:getHuntValue(i) >= config.Hunt[i].max then
				Hunt = Hunt.."\n"..i..": Maximo"
			else
				Hunt = Hunt.."\n"..i..": "..((config.Hunt[i].price) * (Clan:getHuntValue(i) + config.Hunt[i].min))
			end
		end
		npcHandler:say(Hunt, cid)
		npcHandler.topic[cid] = 10
	elseif npcHandler.topic[cid] == 10 then
		npcHandler:say("Vejamos...", cid)
		local check_msg
		for i, c in pairs(config.Hunt) do
			if msgcontains(msg, i) then
				if Clan:getHuntValue(i) >= config.Hunt[i].max then
					npcHandler.topic[cid] = 0
					npcHandler:say("Desculpa, mas não posso vender isso para você.",cid)
					break
				else
					buy_hunt = i
					npcHandler.topic[cid] = 11
					npcHandler:say("Tem certeza que você quer comprar: {"..i.."}?", cid)
				end
				check_msg = true
				break
			end
		end
		if check_msg ~= true then
			npcHandler:say("Não entendi o que você quer.", cid)
		end
	elseif msgcontains(msg, "yes") and npcHandler.topic[cid] == 11 then
		local hunt_add = Clan:getHuntValue(buy_hunt) + config.Hunt[buy_hunt].min
		hunt_check = config.Hunt[buy_hunt].price * hunt_add
		if Clan:removeBalance(hunt_check) then
			npcHandler:say("Parabéns, você comprou a categoria Hunt!", cid)
			Clan:setHuntStorage(buy_hunt, hunt_add)
		else
			npcHandler:say("Desculpe, mas seu clan não possui dinheiro suficiente!", cid)
		end
		npcHandler.topic[cid] = 0
	elseif msgcontains(msg, "no") and npcHandler.topic[cid] == 11 then
		npcHandler:say("Deseja mais alguma coisa?", cid)
		npcHandler.topic[cid] = 0
	end







	return true
end

local function greetCallback(cid)
	local player = Player(cid)
	local Clan = Clan:new(player:getVocation():getName())
	if Clan:leader() == player:getAccountId() then
		npcHandler:say({
			"Bem vindo {|PLAYERNAME|}!",
			"O saldo do seu clan é de {"..Clan:getBalance().."}",
			"O que deseja fazer pelo seu clan? {Atributos}, {Hunt}, {Fazenda}."
		}, cid)
		return true
	else
		npcHandler:say("Você não é o leader do clan.", cid)
	end
end

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())