-- Amason Quest by Gustavo

function onUse(cid, item, frompos, item2, topos)

   	if item.uid == 7712 then
   		queststatus = getPlayerStorageValue(cid,7712)
   		if queststatus == -1 then
   			doPlayerSendTextMessage(cid,22,"Parabens voce recebeu 2k.")
   			doPlayerAddItem(cid,2152,20)
   			setPlayerStorageValue(cid,7712,1)
   		else
   			doPlayerSendTextMessage(cid,22,"Voce ja fez essa quest.")
   		end
      	else
		return 0
   	end

   	return 1
end
