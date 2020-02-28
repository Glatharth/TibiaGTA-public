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
			"Atualmente existe dois clans, os Renegados que s�o considerados do do mal.", 
			"E os Justiceiros, que s�o considerados do bem.",
			"Ambos os clans lutam entre si, at� que o mais forte ven�a.",
			"Voc� pode ajudar seu cl� matando seus inimigos ou ca�ando monstros selecionados que v�o dar dinheiro para seu clan.",
			"Quer ser o Leader do clan?",
			"N�o vai ser nada facil, voc� precisa ser o mais importante do clan!",
			"N�o sabe o que o {Leader} faz?"
		}, cid)
		npcHandler.topic[cid] = 2
	elseif msgcontains(msg, "leader") and (npcHandler.topic[cid] == 2) then
		npcHandler:say({
			"O Leader � o membro mais importante de todo o clan, ele ir� configurar o clan.",
			"Ele tem a palavra final para as desi��es do clan!",
			"Com isso ele que ir� levar o clan a vitoria!"
		}, cid)
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())