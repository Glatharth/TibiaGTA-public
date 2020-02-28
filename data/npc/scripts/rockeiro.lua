local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                          npcHandler:onThink()                        end

local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)

shopModule:addBuyableItem({'Jeans Legs'}, 12797, 700, 1, 'Jeans Legs')
shopModule:addBuyableItem({'Nylon Legs'}, 12740, 8500, 1, 'Nylon Legs')
shopModule:addBuyableItem({'Terrorista Legs'}, 12796, 19500, 1, 'Terrorista Legs')
shopModule:addBuyableItem({'Infantaria Legs'}, 12739, 32000, 1, 'Infantaria Legs')
shopModule:addBuyableItem({'Iron Legs'}, 12761, 125000, 1, 'Iron Legs')

function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
