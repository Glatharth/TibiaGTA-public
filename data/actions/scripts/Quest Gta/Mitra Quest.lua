-- Mitra Quest by Gustavo

function onUse(cid, item, frompos, item2, topos)

   	if item.uid == 7713 then
   		queststatus = getPlayerStorageValue(cid,7713)
   		if queststatus == -1 then
   			doPlayerSendTextMessage(cid,22,"Parabens voce recebeu um Yellow Shoes")
   			doPlayerAddItem(cid,12789,1)
   			setPlayerStorageValue(cid,7713,1)
   		else
   			doPlayerSendTextMessage(cid,22,"Voce ja fez essa quest.")
   		end
      	else
		return 0
   	end

   	return 1
end
