local tiles = _Sistemas[1].config.Fazenda['Tiles']
local check
function checkTile(tile)
    for i, c in ipairs(Tile(toPosition):getItems()) do
        if plants[i] ~= nil then
            check = true
            return true
        end
    end
    check = false
    return false
end

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local tilesIds = {}
    for i, c in pairs(tiles) do
        table.insert(tilesIds, i)
    end
    if not isInArray(tilesIds, target.itemid) then
		return false
    end
    local targetId = target:getId()
    
    target:transform(tiles[targetId].transform[math.random(#tiles[targetId].transform)], 1)
    toPosition:sendMagicEffect(35)
    toPosition:sendMagicEffect(56)
    addEvent(
        function()
            if target.actionid == _Storage['Action_Seeds'] then
                return true
            end
            toPosition:sendMagicEffect(3)
            target:transform(targetId, 1)
            return false
        end
    , 5000)
end

--[[
    Fazer a verificação por actionID, e colocar o item "Seeds" como item para poder plantar, diferenciar elas por descrição e action
]]