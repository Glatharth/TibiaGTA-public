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

	if msgcontains(msg, "yes") then
		npcHandler:say("Sobre o que posso ajudar? {Clans}, {Balance}.", cid)
		npcHandler.topic[cid] = 1
	elseif msgcontains(msg, "clans") and (npcHandler.topic[cid] == 1) then
		npcHandler:say({
			"Atualmente existe dois clans, os Renegados que são considerados do do mal.", 
			"E os Justiceiros, que são considerados do bem.",
			"Ambos os clans lutam entre si, até que o mais forte vença.",
			"Você pode ajudar seu clã matando seus inimigos ou caçando monstros selecionados que vão dar dinheiro para seu clan.",
			"Quer ser o Leader do clan?",
			"Não vai ser nada facil, você precisa ser o mais importante do clan!",
			"Não sabe o que o {Leader} faz?"
		}, cid)
		npcHandler.topic[cid] = 2
	elseif msgcontains(msg, "leader") and (npcHandler.topic[cid] == 2) then
		npcHandler:say({
			"O Leader é o membro mais importante de todo o clan, ele irá configurar o clan.",
			"Ele tem a palavra final para as desições do clan!",
			"Com isso ele que irá levar o clan a vitoria!"
		}, cid)
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())