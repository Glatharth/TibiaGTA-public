local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                          npcHandler:onThink()                        end

local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)

shopModule:addBuyableItem({'Soqueira'}, 12667, 200, 1, 'Soqueira')
shopModule:addBuyableItem({'Bat'}, 12665, 500, 1, 'Bat')
shopModule:addBuyableItem({'Metal Bat'}, 12674, 3000, 1, 'Metal Bat')
shopModule:addBuyableItem({'Diamond Bat'}, 12675, 20000, 1, 'Diamond Bat')
shopModule:addBuyableItem({'Espuleta'}, 12695, 500, 1, 'Espuleta')
shopModule:addBuyableItem({'Pistol Free'}, 12661, 3500, 1, 'Pistol Free')
shopModule:addBuyableItem({'Taurus'}, 12681, 13000, 1, 'Taurus')
shopModule:addBuyableItem({'Magnum'}, 12664, 45000, 1, 'Magnum')
shopModule:addBuyableItem({'Navy'}, 12671, 120000, 1, 'Navy')
shopModule:addBuyableItem({'Shotgun'}, 12677, 64000, 1, 'Shotgun')

function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
