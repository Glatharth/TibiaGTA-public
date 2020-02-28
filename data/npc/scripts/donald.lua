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

shopModule:addBuyableItem({'Meat'}, 2666, 6, 1, 'Meat')
shopModule:addBuyableItem({'Brown Mushroom'}, 2789, 8, 1, 'Brown Mushroom')
shopModule:addBuyableItem({'X-Tudo'}, 13373, 7, 1, 'X-Tudo')

function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
