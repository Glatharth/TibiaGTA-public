local talkAction = TalkAction("/outfit")

function talkAction.onSay(player, words, param)
    local target = Creature(param)
    -- Attempt to create userdata with the argument passed to a command
    if not target then
        player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Creature not found.")
        return false
    end
    local outfit = target:getOutfit()
    -- Convert outfit table to XML format
    local msg = string.format('<look type="%s" head="%s" body="%s" legs="%s" feet="%s" addons="%s" />', outfit.lookType, outfit.lookHead, outfit.lookBody, outfit.lookLegs, outfit.lookFeet, outfit.lookAddons)
    player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, msg)
    return false
end

talkAction:separator(" ") -- Separate arguments passed to the command by a space
talkAction:register()