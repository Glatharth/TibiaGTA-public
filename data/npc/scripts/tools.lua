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

shopModule:addBuyableItem({'Backpack'}, 1988, 20, 1, 'Backpack')
shopModule:addBuyableItem({'Rope'}, 2120, 15, 1, 'Rope')
shopModule:addBuyableItem({'Shovel'}, 2554, 12, 1, 'Shovel')
shopModule:addBuyableItem({'Pick'}, 2553, 10000, 1, 'Pick')
shopModule:addBuyableItem({'Fishing Rod'}, 2580, 8, 1, 'Fishing Rod')

function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
