function onLogin(player)
	local first_outfit
	local outfit_storage = _config_GTA.storage_first_outfit
	--local setOutfit
	local loginStr = "Welcome to " .. configManager.getString(configKeys.SERVER_NAME) .. "!"
	if player:getLastLoginSaved() <= 0 then
		if player:getVocation():getId() == 1 then 
			if player:getSex() == 0 then
				first_outfit = _config_GTA.outfits.justiceira[1].looktype
			else
				first_outfit = _config_GTA.outfits.justiceiro[1].looktype
			end
		elseif player:getVocation():getId() == 2 then
			if player:getSex() == 0 then
				first_outfit = _config_GTA.outfits.renegada[1].looktype
			else
				first_outfit = _config_GTA.outfits.renegado[1].looktype
			end
		end
		player:addOutfit(first_outfit)
		loginStr = loginStr .. " Any questions you have, call someone on the staff."
		player:sendOutfitWindow()
	else
		if loginStr ~= "" then
			player:sendTextMessage(MESSAGE_STATUS_DEFAULT, loginStr)
		end

		loginStr = string.format("Your last visit was on %s.", os.date("%a %b %d %X %Y", player:getLastLoginSaved()))
	end
	player:sendTextMessage(MESSAGE_STATUS_DEFAULT, loginStr)


	-- Free bless
	local freeBless = {
		level = 50,
		blessTotal = 5,
	}

	if player:getLevel() <= freeBless.level then
		for i = 1, freeBless.blessTotal do
			doPlayerAddBlessing(player, i)
		end
	end 

	-- Stamina
	nextUseStaminaTime[player.uid] = 0

	-- Promotion
	local vocation = player:getVocation()
	local promotion = vocation:getPromotion()
	if player:isPremium() then
		local value = player:getStorageValue(STORAGEVALUE_PROMOTION)
		if not promotion and value ~= 1 then
			player:setStorageValue(STORAGEVALUE_PROMOTION, 1)
		elseif value == 1 then
			player:setVocation(promotion)
		end
	elseif not promotion then
		player:setVocation(vocation:getDemotion())
	end

	-- GTA
	--player:setStorageValue(_config_GTA.storage_moto_check, 2)

	-- Open Justiceiro chat
	if (player:getVocation():getId() == 1) or (player:getAccountType() >= ACCOUNT_TYPE_GOD) then
		player:openChannel(8)
	end

	-- Open Renegado chat
	if (player:getVocation():getId() == 2) or (player:getAccountType() >= ACCOUNT_TYPE_GOD) then
		player:openChannel(7)
	end

	-- Open chats
	player:openChannel(5)
	if player:getAccountType() >= ACCOUNT_TYPE_TUTOR then
		player:openChannel(2)
	end
	
	-- Events
	player:registerEvent("Task")
	player:registerEvent("PlayerDeath")
	player:registerEvent("DropLoot")
	player:registerEvent("Cadeia")
	player:registerEvent("PlayerPoint")
	player:registerEvent("PlayerBank")



	if EnterCloseServer['enable'] == true then
		player:registerEvent("EnterCloseServer")
	end
	return true
end
