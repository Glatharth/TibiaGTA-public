function onDeath(player, corpse, killer, mostDamageKiller, unjustified, mostDamageUnjustified)
	if player:isPlayer() and killer:isPlayer() and killer:getVocation():getId() == player:getVocation():getId() then
		if unjustified then
			killer:teleportTo({x = 1008, y = 1032, z = 6})
			broadcastMessage("O jogador "..killer:getName().." foi preso por matar outro jogador do mesmo Clã.", MESSAGE_STATUS_CONSOLE_BLUE)
			Player.setExhaustion(killer, _config_GTA.storage_cadeia_time, _config_GTA.cadeia_time)
			
			return true
		end
	end
end