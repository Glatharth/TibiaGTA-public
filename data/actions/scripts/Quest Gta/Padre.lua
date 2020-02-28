-- Padre Quest by Gustavo

function onUse(cid, item, frompos, item2, topos)

   	if item.uid == 7715 then
   		queststatus = getPlayerStorageValue(cid,7715)
   		if queststatus == -1 then
   			doPlayerSendTextMessage(cid,22,"Parabens voce recebeu 1k.")
   			doPlayerAddItem(cid,2152,10)
   			setPlayerStorageValue(cid,7715,1)
   		else
   			doPlayerSendTextMessage(cid,22,"Voce ja fez essa quest.")
   		end
      	else
		return 0
   	end

   	return 1
end
