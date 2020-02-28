local guard = Guard:new()


function onCreatureAppear(cid)

    if cid == npc:isNpc() then
        print(cid)
        print(cid)
        print(cid)
        print(cid)
        print(cid)
        print(cid)
        print(cid)
        print(cid)
        guard.id = cid

        guard.target = 0

        guard.position = cid:getPosition()
        
    end

end


function onCreatureDisappear(cid)

    if cid == guard.target then

        guard:reset()

    end

end


function onCreatureSay(cid, type, msg)

    return false

end


function onThink()

    guard:updateTarget()

    if guard.target ~= 0 then

        if isCreature(guard.target) then

            guard:attack()

        else

            guard:reset()

        end

    else

        guard:reset()

    end

end