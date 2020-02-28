-- Fibra Shield by Gustavo

function onUse(cid, item, frompos, item2, topos)

   	if item.uid == 7711 then
   		local queststatus = getPlayerStorageValue(cid,7711)
   		if queststatus == -1 then
   			doPlayerSendTextMessage(cid,22,"Parabens voce recebeu um Fibra Shield.")
   			doPlayerAddItem(cid,12783,1)
   			setPlayerStorageValue(cid,7711,1)
   		else
   			doPlayerSendTextMessage(cid,22,"Voce ja fez essa quest.")
   		end
      	else
		return 0
   	end

   	return 1
end
