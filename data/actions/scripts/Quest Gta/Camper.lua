-- Camper Quest by Gustavo

function onUse(cid, item, frompos, item2, topos)

   	if item.uid == 7709 then
   		queststatus = getPlayerStorageValue(cid,7709)
   		if queststatus == -1 then
   			doPlayerSendTextMessage(cid,22,"Parabens voce completou a Camper Quest e ganhou 30k.")
   			doPlayerAddItem(cid,2160,3)
   			setPlayerStorageValue(cid,7709,1)
   		else
   			doPlayerSendTextMessage(cid,22,"Voce ja fez essa quest.")
   		end
      	else
		return 0
   	end

   	return 1
end
