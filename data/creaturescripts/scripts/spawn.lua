function onDeath(creature, corpse, killer, mostDamageKiller, unjustified, mostDamageUnjustified)
    local MonsterSpawn = MonsterSpawn[creature:getId()]
    if MonsterSpawn then
        if MonsterSpawn.limitSpawn ~= nil then
            if MonsterSpawn.limitSpawn > 0 then
                MonsterSpawn.limitSpawn = MonsterSpawn.limitSpawn - 1
            end
        end
        addEvent(SpawncreateMonster, MonsterSpawn.self.rateSpawn, MonsterSpawn.pos, MonsterSpawn.self, MonsterSpawn.limitSpawn)
        MonsterSpawn[creature:getId()] = nil
    end
    return true
end