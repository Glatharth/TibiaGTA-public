-- Anih 100 by Gustavo

function onUse(cid, item, frompos, item2, topos)

   	if item.uid == 7706 then
   		queststatus = getPlayerStorageValue(cid,7706)
   		if queststatus == -1 then
   			doPlayerSendTextMessage(cid,22,"Parabens voce terminou a ANIH 100 e por isso ganhou uma Skate Legs")
   			doPlayerAddItem(cid,12746,1)
   			setPlayerStorageValue(cid,7706,1)
   		else
   			doPlayerSendTextMessage(cid,22,"Voce ja fez essa quest.")
   		end
      	else
		return 0
   	end

   	return 1
end
