dofile('./tables.lua')

profession = {}
setmetatable(profession,
{
	__call =
	function(self, professionName, mask)
		for _,parse in pairs(self) do
			parse(professionName, mask)
		end
    end
})

profession.register = function(self, mask)
	return registerMonsterType(self, mask)
end

profession.doCheckJob = function(professionName, table, compare)
	if isInArray(profession[professionName][table], compare) then
		return true
	else
		return false
	end
end

profession.getStorage = function(professionName, mask)
	


end

profession.setJob = function(professionName, mask)
	if mask.setJob then
		professionName:setJob(mask.setJob)
	end
end

profession.setTool = function(professionName, mask)
	if professionName:doCheckJob(tool, setTool) then	
		if mask.setTool then
			professionName:setTool(mask.setTool)
		end
	end
end

profession.setSkill = function(professionName, mask)
	if professionName:doCheckJob(skill, setSkill) then
		if mask.setSkill then
			professionName:setSkill(mask.setSkill)
		end
	end
end

profession.setLevel = function(professionName, mask)
	if professionName:doCheckJob(level, setLevel) then
		if mask.setLevel then
			professionName:setLevel(mask.setLevel)
		end
	end
end

profession.setPermission = function(professionName, mask)
	if professionName:doCheckJob(level, setPermission) then
		if mask.setPermission then
			professionName:setPermission(mask.setPermission)
		end
	end
end