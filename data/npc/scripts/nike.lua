local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                          npcHandler:onThink()                        end

local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)

shopModule:addBuyableItem({'Blanc Shoes'}, 12810, 650, 1, 'Blanc Shoes')
shopModule:addBuyableItem({'Green Shoes'}, 12790, 4700, 1, 'Green Shoes')
shopModule:addBuyableItem({'Yellow Shoes'}, 12789, 11000, 1, 'Yelow Shoes')
shopModule:addBuyableItem({'Blue Shoes'}, 12793, 28200, 1, 'Blue Shoes')

function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
