-- Anih 80 by Gustavo

function onUse(cid, item, frompos, item2, topos)

   	if item.uid == 7705 then
   		queststatus = getPlayerStorageValue(cid,7705)
   		if queststatus == -1 then
   			doPlayerSendTextMessage(cid,22,"Parabens voce terminou a ANIH 80 e por isso ganhou 80k.")
   			doPlayerAddItem(cid,2160,8)
   			setPlayerStorageValue(cid,7705,1)
   		else
   			doPlayerSendTextMessage(cid,22,"Voce ja fez essa quest.")
   		end
      	else
		return 0
   	end

   	return 1
end
