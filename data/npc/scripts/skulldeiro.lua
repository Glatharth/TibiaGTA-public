local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                          npcHandler:onThink()                        end

local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)

shopModule:addBuyableItem({'Escudo de Platina'}, 12771, 1500, 1, 'Escudo de Platina')
shopModule:addBuyableItem({'Police Shield'}, 12783, 3500, 1, 'Police Shield')
shopModule:addBuyableItem({'Yellow Police Shield'}, 12780, 16000, 1, 'Yellow Police Shield')
shopModule:addBuyableItem({'Black Police Shield'}, 12784, 25200, 1, 'Black Police Shield')
shopModule:addBuyableItem({'Air Shield'}, 12782, 23000, 1, 'Air Shield')
shopModule:addBuyableItem({'America Shield'}, 12773, 80000, 1, 'America Shield')

function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
