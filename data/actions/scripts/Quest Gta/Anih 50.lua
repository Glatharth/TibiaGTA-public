-- Anih 50 by Gustavo

function onUse(cid, item, frompos, item2, topos)

   	if item.uid == 7704 then
   		queststatus = getPlayerStorageValue(cid,7704)
   		if queststatus == -1 then
   			doPlayerSendTextMessage(cid,22,"Parabens voce terminou a ANIH 50 e por isso ganhou 50k.")
   			doPlayerAddItem(cid,2160,5)
   			setPlayerStorageValue(cid,7704,1)
   		else
   			doPlayerSendTextMessage(cid,22,"Voce ja fez essa quest.")
   		end
      	else
		return 0
   	end

   	return 1
end
