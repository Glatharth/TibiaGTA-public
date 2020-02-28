function Creature:onChangeOutfit(outfit)
	if self:getCondition(CONDITION_OUTFIT, CONDITIONID_COMBAT) then
		return false
	end
	return true
end

function Creature:onAreaCombat(tile, isAggressive)
	return RETURNVALUE_NOERROR
end

function Creature:onTargetCombat(target)
	if self == nil then
		return RETURNVALUE_NOERROR
	end

	if self:isMonster() and target:isPlayer() then
		if self:getName() == tostring("Justiceiro") and (target:getVocation():getId() == 1) then
			self:searchTarget()
			self:removeTarget(target)
			self:addFriend(target)
			return RETURNVALUE_YOUMAYNOTATTACKTHISPLAYER
		end
		if self:getName() == tostring("Renegado") and (target:getVocation():getId() == 2) then
			self:searchTarget()
			self:removeTarget(target)
			self:addFriend(target)
			return RETURNVALUE_YOUMAYNOTATTACKTHISPLAYER
		end
    end

	-- Capacetes --
	if self:isPlayer() and self:getStorageValue(_config_GTA.storage_moto) >= 1 then
		if self:getSlotItem(CONST_SLOT_HEAD) ~= nil then
			head = self:getSlotItem(CONST_SLOT_HEAD) 
			if head ~= nil and Capacete[head:getName()].attack == false then
				return RETURNVALUE_YOUMAYNOTATTACKTHISCREATURE or RETURNVALUE_YOUMAYNOTATTACKTHISPLAYER
			end
		end
	end
	-- /Capacetes --
	return RETURNVALUE_NOERROR
end
