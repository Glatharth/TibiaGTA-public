local talk = TalkAction("/attr")

local itemFunctions = {
    ['actionid'] = { isActive = true, targetFunction = function (item, target) return item:setActionId(target) end },
    ['description'] = { isActive = true, targetFunction = function (item, target) return item:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, target) end },
    ['desc'] = { isActive = true, targetFunction = function (item, target) return item:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, target) end },
    ['remove'] = { isActive = true, targetFunction = function (item, target) return item:remove() end },
    ['decay'] = { isActive = true, targetFunction = function (item, target) return item:decay() end },
    ['transform'] = { isActive = true, targetFunction = function (item, target) return item:transform(target) end },
    ['clone'] = { isActive = true, targetFunction = function (item, target) return item:clone() end },
    ['attack'] = { isActive = true, targetFunction = function (item, target) return item:setAttribute(ITEM_ATTRIBUTE_ATTACK, target) end },
    ['defense'] = { isActive = true, targetFunction = function (item, target) return item:setAttribute(ITEM_ATTRIBUTE_DEFENSE, target) end },
    ['armor'] = { isActive = true, targetFunction = function (item, target) return item:setAttribute(ITEM_ATTRIBUTE_ARMOR, target) end },
    ['name'] = { isActive = true, targetFunction = function (item, target) return item:setAttribute(ITEM_ATTRIBUTE_NAME, target) end },
    ['extradefense'] = { isActive = true, targetFunction = function (item, target) return item:setAttribute(ITEM_ATTRIBUTE_EXTRADEFENSE, target) end },
    ['range'] = { isActive = true, targetFunction = function (item, target) return item:setAttribute(ITEM_ATTRIBUTE_SHOOTRANGE, target) end },
    ['charges'] = { isActive = true, targetFunction = function (item, target) return item:setAttribute(ITEM_ATTRIBUTE_CHARGES, target) end }
}

local creatureFunctions = {
    ['health'] = { isActive = true, targetFunction = function (creature, target) return creature:addHealth(target) end },
    ['setHealth'] = { isActive = true, targetFunction = function (creature, target) return creature:setHealth(target) end },
    ['mana'] = { isActive = true, targetFunction = function (creature, target) return creature:addMana(target) end },
    ['speed'] = { isActive = true, targetFunction = function (creature, target) return creature:changeSpeed(target) end },
    ['droploot'] = { isActive = true, targetFunction = function (creature, target) return creature:setDropLoot(target) end },
    ['skull'] = { isActive = true, targetFunction = function (creature, target) return creature:setSkull(target) end },
    ['direction'] = { isActive = true, targetFunction = function (creature, target) return creature:setDirection(target) end },
    ['maxHealth'] = { isActive = true, targetFunction = function (creature, target) return creature:setMaxHealth(target) and creature:addHealth(creature:getMaxHealth() - creature:getHealth()) end },
    ['say'] = { isActive = true, targetFunction = function (creature, target) creature:say(target, TALKTYPE_SAY) end },
    ['startPos'] = { isActive = true, targetFunction = function (creature, target) if creature:isNpc() then return false end return creature:teleportTo(creature:getSpawnPosition(), true) end }
}

local playerFunctions = {
    ['fyi'] = { isActive = true, targetFunction = function (player, target) return player:popupFYI(target) end },
    ['tutorial'] = { isActive = true, targetFunction = function (player, target) return player:sendTutorial(target) end },
    ['guildnick'] = { isActive = true, targetFunction = function (player, target) return player:setGuildNick(target) end },
    ['group'] = { isActive = true, targetFunction = function (player, target) player:setGroup(Group(target)) return player:remove() end },
    ['vocation'] = { isActive = true, targetFunction = function (player, target) return player:setVocation(tonumber(target) or 0) end },
    ['stamina'] = { isActive = true, targetFunction = function (player, target) return player:setStamina(target) end },
    ['town'] = { isActive = true, targetFunction = function (player, target) return player:setTown(Town(target)) end },
    ['balance'] = { isActive = true, targetFunction = function (player, target) return player:setBankBalance(target + player:getBankBalance()) end },
    ['save'] = { isActive = true, targetFunction = function (player, target) return target:save() end },
    ['type'] = { isActive = true, targetFunction = function (player, target) return player:setAccountType(target) end },
    ['skullTime'] = { isActive = true, targetFunction = function (player, target) return player:setSkullTime(target) end },
    ['maxMana'] = { isActive = true, targetFunction = function (player, target) return player:setMaxMana(target) end },
    ['addItem'] = { isActive = true, targetFunction = function (player, target, count) return player:addItem(target, tonumber(count) or 1) end },
    ['removeItem'] = { isActive = true, targetFunction = function (player, target, count) return player:removeItem(target, tonumber(count) or 1) end },
    ['premium'] = { isActive = true, targetFunction = function (player, target) return player:addPremiumDays(target) end }
}

function talk.onSay(player, words, param)
    if player:getGroup():getAccess() and param ~= "" then
        local position = player:getPosition()
        position:getNextPosition(player:getDirection(), 1)
        local split = param:split(",")
        local itemFunction = itemFunctions[split[1]]
        local creatureFunction = creatureFunctions[split[1]]
        local playerFunction = playerFunctions[split[1]]
        if itemFunction and itemFunction.isActive then
            local item = Tile(position):getTopVisibleThing(player)
            if not item or not item:isItem() then
                return not player:sendCancelMessage("Object not found, you may not be in front of an object.")
            end
            if itemFunction.targetFunction(item, split[2]) then
                position:sendMagicEffect(CONST_ME_MAGIC_GREEN)
            else
                player:sendCancelMessage("The attribute you want to add is not supported or does not exist.")
            end
        elseif creatureFunction and creatureFunction.isActive then
            local creature = Tile(position):getTopCreature()
            if not creature or not creature:isCreature() then
                return not player:sendCancelMessage("Creature not found or maybe not in front of a creature.")
            end
            if creatureFunction.targetFunction(creature, split[2]) then
                position:sendMagicEffect(CONST_ME_MAGIC_GREEN)
            else
                player:sendCancelMessage("The attribute you want to add is not supported or does not exist.")
            end
        elseif playerFunction and playerFunction.isActive then
            local targetPlayer = Tile(position):getTopCreature()
            if not targetPlayer or not targetPlayer:getPlayer() then
                return not player:sendCancelMessage("Player not found or maybe not in front of a player.")
            end
            if playerFunction.targetFunction(targetPlayer, split[2]) then
                position:sendMagicEffect(CONST_ME_MAGIC_GREEN)
            else
                player:sendCancelMessage("The attribute you want to add is not supported or does not exist.")
            end
        else
            player:sendCancelMessage("The attribute you want to add is not supported or does not exist.")
        end
           return false
    end
    return true
end

talk:separator(" ")
talk:register()