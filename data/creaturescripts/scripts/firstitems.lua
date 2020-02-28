local firstItems = {2050, 12781, 12667}

function onLogin(player)
	if player:getLastLoginSaved() == 0 then
		for i = 1, #firstItems do
			player:addItem(firstItems[i], 1)
		end
		player:addItem(1987, 1):addItem(2674, 15)
	end
	return true
end
