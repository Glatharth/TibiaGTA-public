-- Scarab Coin by Gustavo

function onUse(cid, item, frompos, item2, topos)

   	if item.uid == 7718 then
   		queststatus = getPlayerStorageValue(cid,7718)
   		if queststatus == -1 then
   			doPlayerSendTextMessage(cid,22,"Parabens voce recebeu uma scarab coin")
   			doPlayerAddItem(cid,2159,1)
   			setPlayerStorageValue(cid,7718,1)
   		else
   			doPlayerSendTextMessage(cid,22,"Voce ja fez essa quest.")
   		end
      	else
		return 0
   	end

   	return 1
end
