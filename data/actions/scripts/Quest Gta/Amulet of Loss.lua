-- Amulet of Loss by Gustavo

function onUse(cid, item, frompos, item2, topos)

   	if item.uid == 7703 then
   		queststatus = getPlayerStorageValue(cid,7703)
   		if queststatus == -1 then
   			doPlayerSendTextMessage(cid,22,"Parabens voce recebeu um Amulet of Loss.")
   			doPlayerAddItem(cid,2173,1)
   			setPlayerStorageValue(cid,7703,1)
   		else
   			doPlayerSendTextMessage(cid,22,"Voce ja fez essa quest.")
   		end
      	else
		return 0
   	end

   	return 1
end
