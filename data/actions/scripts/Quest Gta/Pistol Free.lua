-- Pistol Free by Gustavo

function onUse(cid, item, frompos, item2, topos)

   	if item.uid == 7716 then
   		queststatus = getPlayerStorageValue(cid,7716)
   		if queststatus == -1 then
   			doPlayerSendTextMessage(cid,22,"Parabens voce recebeu uma pistol free")
   			doPlayerAddItem(cid,12661,1)
   			setPlayerStorageValue(cid,7716,1)
   		else
   			doPlayerSendTextMessage(cid,22,"Voce ja fez essa quest.")
   		end
      	else
		return 0
   	end

   	return 1
end
