local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                          npcHandler:onThink()                        end

local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)

shopModule:addBuyableItem({'Blue Backpack'}, 2002, 20, 1, 'Blue Backpack')
shopModule:addBuyableItem({'Grey Backpack'}, 2003, 20, 1, 'Grey Backpack')
shopModule:addBuyableItem({'Golden Backpack'}, 2004, 20, 1, 'Golden Backpack')
shopModule:addBuyableItem({'Green Backpack'}, 1998, 20, 1, 'Green Backpack')
shopModule:addBuyableItem({'Backpack'}, 1988, 20, 1, 'Backpack')
shopModule:addBuyableItem({'Red Backpack'}, 2000, 20, 1, 'Red Backpack')
shopModule:addBuyableItem({'Camouflage Backpack'}, 3940, 20, 1, 'Camouflage Backpack')
shopModule:addBuyableItem({'Brocade Backpack'}, 9774, 20, 1, 'Brocade Backpack')


function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
