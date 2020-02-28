-- Xarope Quest by Gustavo

function onUse(cid, item, frompos, item2, topos)

   	if item.uid == 7723 then
   		queststatus = getPlayerStorageValue(cid,7723)
   		if queststatus == -1 then
   			doPlayerSendTextMessage(cid,22,"Parabens voce recebeu 30 xaropes")
   			doPlayerAddItem(cid,2299,30)
   			setPlayerStorageValue(cid,7723,1)
   		else
   			doPlayerSendTextMessage(cid,22,"Voce ja fez essa quest.")
   		end
      	else
		return 0
   	end

   	return 1
end
