function onThink(creature, interval)
	if self:isMonster() and (string.lower(self:getName()) == 'justiceiro' or 'renegado') then
		if string.lower(self:getName()) == string.lower(target:getVocation():getName()) then
			print(112233)
			self:removeTarget(target)
			return RETURNVALUE_YOUMAYNOTATTACKTHISCREATURE
		end
	end
	return true
end