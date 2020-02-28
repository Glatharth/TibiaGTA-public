function onSay(player, words, param)
	if player:getAccountType() < ACCOUNT_TYPE_GOD then
		return false
	end
	file = io.open('data/monster/'..param..'.xml','r')
	monster = file:read(100000)
	doShowTextDialog(player, 7528, monster)
	file:close()
end