local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                          npcHandler:onThink()                        end

local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)

-- NOME do Item/ID do Item/VALOR do Item/QUANTIDADE do Item/NOME do Item
shopModule:addSellableItem({'Yellow Gem'}, 2154, 250, 'Yellow Gem')
shopModule:addSellableItem({'Violet Gem'}, 2153, 200, 'Violet Gem')
shopModule:addSellableItem({'Green Gem'}, 2155, 300, 'Green Gem')
shopModule:addSellableItem({'Small Diamond'}, 2145, 400, 'Small Diamond')
shopModule:addSellableItem({'Scarab Coin'}, 2159, 230, 'Scarab Coin')
shopModule:addSellableItem({'Wolf Paw'}, 5897, 500, 'Wolf Paw')


function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
