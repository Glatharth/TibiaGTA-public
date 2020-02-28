-- Violet Gem by Gustavo

function onUse(cid, item, frompos, item2, topos)

   	if item.uid == 7721 then
   		queststatus = getPlayerStorageValue(cid,7721)
   		if queststatus == -1 then
   			doPlayerSendTextMessage(cid,22,"Parabens voce recebeu uma violet gem.")
   			doPlayerAddItem(cid,2153,1)
   			setPlayerStorageValue(cid,7721,1)
   		else
   			doPlayerSendTextMessage(cid,22,"Voce ja fez essa quest.")
   		end
      	else
		return 0
   	end

   	return 1
end
