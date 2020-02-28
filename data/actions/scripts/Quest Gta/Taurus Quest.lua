-- Taurus Quest by Gustavo

function onUse(cid, item, frompos, item2, topos)

   	if item.uid == 7720 then
   		queststatus = getPlayerStorageValue(cid,7720)
   		if queststatus == -1 then
   			doPlayerSendTextMessage(cid,22,"Parabens voce completou a Taurus Quest e ganhou uma Taurus")
   			doPlayerAddItem(cid,12681,1)
   			setPlayerStorageValue(cid,7720,1)
   		else
   			doPlayerSendTextMessage(cid,22,"Voce ja fez essa quest.")
   		end
      	else
		return 0
   	end

   	return 1
end
