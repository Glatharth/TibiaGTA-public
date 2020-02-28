local tiles = _Sistemas[1].config.Fazenda['Tiles']
function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if target:getActionId() == _Storage['Action_Seeds'] then
        return false
    end
    local tilesIds = {}
    for i, c in pairs(tiles) do
        for v = 1, #tiles[i].transform do
            table.insert(tilesIds, tiles[i].transform[v])
        end
    end
    if not isInArray(tilesIds, target.itemid) then
		return false
    end
    local pos = "x = "..toPosition.x..", y = "..toPosition.y..", z = "..toPosition.z
    Fazenda = Fazenda:new(pos, player:getVocation():getName())
    Fazenda:saveDB(player:getGuid(), "test")
    toPosition:sendMagicEffect(4)
    target:setActionId(_Storage['Action_Seeds'])
end