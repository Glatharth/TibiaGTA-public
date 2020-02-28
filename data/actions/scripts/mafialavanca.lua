function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if player:getStorageValue(89893) > 0 then
        player:sendTextMessage(MESSAGE_STATUS_DEFAULT, 'Voce liberou os prisioneiros, fale com EL Capone.')
        player:setStorageValue(89893, 1)
        player:getPosition():sendMagicEffect(7)
    else
        player:sendTextMessage(MESSAGE_STATUS_DEFAULT, 'Voce ja liberou os prisioneiros.')
    end
    return true
end