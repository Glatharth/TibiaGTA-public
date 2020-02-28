-- Anih 200 by Gustavo

function onUse(cid, item, frompos, item2, topos)

   	if item.uid == 7707 then
   		queststatus = getPlayerStorageValue(cid,7707)
   		if queststatus == -1 then
   			doPlayerSendTextMessage(cid,22,"Parabens voce terminou a ANIH 200 e por isso ganhou uma paint gold")
   			doPlayerAddItem(cid,12676,1)
   			setPlayerStorageValue(cid,7707,1)
   		else
   			doPlayerSendTextMessage(cid,22,"Voce ja fez essa quest.")
   		end
      	else
		return 0
   	end

   	return 1
end
