-- Bat Quest by Gustavo

function onUse(cid, item, frompos, item2, topos)

   	if item.uid == 7708 then
   		queststatus = getPlayerStorageValue(cid,7708)
   		if queststatus == -1 then
   			doPlayerSendTextMessage(cid,22,"Parabens voce recebeu um Bat")
   			doPlayerAddItem(cid,12665,1)
   			setPlayerStorageValue(cid,7708,1)
   		else
   			doPlayerSendTextMessage(cid,22,"Voce ja fez essa quest.")
   		end
      	else
		return 0
   	end

   	return 1
end
