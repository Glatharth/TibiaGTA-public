local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                          npcHandler:onThink()                        end

local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)

-- NOME do Item/ID do Item/VALOR do Item/QUANTIDADE do Item/NOME do Item -->
shopModule:addBuyableItem({'Bone Azul'}, 12731, 360, 1, 'Bone Azul')
shopModule:addBuyableItem({'Police Cap'}, 12730, 2000, 1, 'Police Cap')
shopModule:addBuyableItem({'Ripper Cap'}, 12744, 3200, 1, 'Ripper Cap')

function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
