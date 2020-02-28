-- Vitamina Quest by Gustavo

function onUse(cid, item, frompos, item2, topos)

   	if item.uid == 7722 then
   		queststatus = getPlayerStorageValue(cid,7722)
   		if queststatus == -1 then
   			doPlayerSendTextMessage(cid,22,"Parabens voce recebeu 15 vitaminas!")
   			doPlayerAddItem(cid,2265,15)
   			setPlayerStorageValue(cid,7722,1)
   		else
   			doPlayerSendTextMessage(cid,22,"Voce ja fez essa quest.")
   		end
      	else
		return 0
   	end

   	return 1
end
