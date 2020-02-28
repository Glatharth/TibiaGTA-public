local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}
function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink() npcHandler:onThink() end
function creatureSayCallback(cid, type, msg)
    local player = Player(cid)
    if(not npcHandler:isFocused(cid)) then
        return false
    end
    local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid
    if(msgcontains(msg, 'yes')) then
        npcHandler:say('Cara, vá até o local futuro do jao muito loko ai e///liberte meus companheiros.', cid)
    end
---------------------------------------------------------
    if(msgcontains(msg, 'local futuro')) then
        npcHandler:say('Voce foi até la e libertou meus aliados?', cid)
        talkState[talkUser] = 1
    elseif(msgcontains(msg, 'yes') and talkState[talkUser] == 1) then
        if player:getStorageValue(89893) > 1 then
            player:addItem(2160, 1)
            npcHandler:say('Po brother, valeu ai.', cid)
            player:addExperience(5000)
            player:setStorageValue(89895)
            if player:getStorageValue(89893) > 0 then
                npcHandler:say('Voce ainda nao libertou meus companheiros, seu tempo esta acabando.', cid)
                if player:getStorageValue(89895) > 1 then
                    npcHandler:say('Voce ja é da mafia bro.', cid)
                end
            end
        end
    end
    return true
end
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())