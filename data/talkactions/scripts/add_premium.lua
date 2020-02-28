local config = {
	days = 30,
	maxDays = 60
}

function onSay(player, words, param)
	if configManager.getBoolean(configKeys.FREE_PREMIUM) then
		return true
	end

	if player:getAccountType() < ACCOUNT_TYPE_GOD then
		return true
	end
	local target = Player(param)
	print(1)
	if target:getPremiumDays() <= config.maxDays then
		print(2)
		target:addPremiumDays(config.days)
		target:sendTextMessage(MESSAGE_INFO_DESCR, "Agora voce é VIP! Voce ganhou " .. config.days .." dias de VIP.")
	else
		print(3)
		target:sendCancelMessage("Voce não pode ter mais de " .. config.maxDays .. " dias de VIP.")
		player:sendCancelMessage("Voce não pode dar mais de " .. config.maxDays .. " dias de VIP.")
		target:getPosition():sendMagicEffect(CONST_ME_POFF)
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
	end
	return false
end
