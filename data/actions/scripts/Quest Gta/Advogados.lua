-- Advogados Quest by Gustavo

function onUse(cid, item, fromPosition, itemEx, toPosition)
    if getPlayerStorageValue(cid, 7702) < 1 then
        doPlayerSetStorageValue(cid, 7702, 1)
        doPlayerSendTextMessage(cid, 22, "Voce ganhou a magia !FAST")
    else
        doPlayerSendCancel(cid, "Voce ja pegou a recompensa.")
    end
    return true
end