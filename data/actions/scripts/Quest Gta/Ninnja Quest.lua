-- Anih 50 by Gustavo

function onUse(cid, item, frompos, item2, topos)

   	if item.uid == 7714 then
   		queststatus = getPlayerStorageValue(cid,7714)
   		if queststatus == -1 then
   			doPlayerSendTextMessage(cid,22,"Parabens voce recebeu uma camisa Skull.")
   			doPlayerAddItem(cid,12760,1)
   			setPlayerStorageValue(cid,7714,1)
   		else
   			doPlayerSendTextMessage(cid,22,"Voce ja fez essa quest.")
   		end
      	else
		return 0
   	end

   	return 1
end
