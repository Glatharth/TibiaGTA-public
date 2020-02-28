function onDeath(player, corpse, killer, mostDamageKiller, unjustified, mostDamageUnjustified)
	if _Sistemas[1].enable == 1 then
		if player:isPlayer() and killer:isPlayer() and killer:getVocation():getId() ~= player:getVocation():getId() then
			if player:getLevel() >= _Sistemas[1].config['death_min'] then
				local points = player:getLevel() / _Sistemas[1].config['points_killer']
				if player:getLevel() > killer:getLevel() then
					if (player:getLevel() - killer:getLevel()) < 100 then
						points = points + ((player:getLevel() - killer:getLevel()) / _Sistemas[1].config['points_killer_bonus'])
					end
				end
				db.query("UPDATE `clans_player_point` SET `points` = points + "..points.." WHERE `player_id` = "..killer:getGuid()..";")
			end
		end	
	else 
		return false
	end
	return true
end

function onKill(creature, target)
	local monsters = {
		['Rato'] = {points = 1},
		['Ratazana'] = {points = 1}
	}

	if _Sistemas[1].enable == 1 then
		if creature:isPlayer() and target:isMonster() and monsters[target:getName()] ~= nil then
			if monsters[target:getName()].points ~= nil then
				db.query("UPDATE `clans_player_bank` SET `balance` = balance + "..monsters[target:getName()].points.." WHERE `player_id` = "..creature:getGuid()..";")
			end
		end
	end
	return true
end