-- Escola Quest by Gustavo

function onUse(cid, item, frompos, item2, topos)

   	if item.uid == 7710 then
   		queststatus = getPlayerStorageValue(cid,7710)
   		if queststatus == -1 then
   			doPlayerSendTextMessage(cid,22,"Parabens voce recebeu 100 chumbinhos.")
   			doPlayerAddItem(cid,12702,100)
   			setPlayerStorageValue(cid,7710,1)
   		else
   			doPlayerSendTextMessage(cid,22,"Voce ja fez essa quest.")
   		end
      	else
		return 0
   	end

   	return 1
end
