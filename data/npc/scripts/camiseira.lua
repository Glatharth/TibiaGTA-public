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
shopModule:addBuyableItem({'Camisa Verde'}, 12798, 500, 1, 'Camisa Verde')
shopModule:addBuyableItem({'Camisa Yang'}, 12799, 2500, 1, 'Camisa Yang')
shopModule:addBuyableItem({'Camisa Skull'}, 12760, 8500, 1, 'Camisa Skull')
shopModule:addBuyableItem({'Camisa Rang Lose'}, 12742, 22000, 1, 'Camisa Rang Lose')

shopModule:addSellableItem({'Camisa Azul'}, 2650, 100, 'Camisa Verde')
shopModule:addSellableItem({'Camisa Yang'}, 2651, 750, 'Camisa Yang')
shopModule:addSellableItem({'Camisa Skull'}, 2494, 3000, 'Camisa Skull')
shopModule:addSellableItem({'Camisa Rang Lose'}, 2472, 8000, 'Camisa Rang Lose')

function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
