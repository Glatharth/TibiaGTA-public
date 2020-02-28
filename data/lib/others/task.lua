------------------------------------------------------
--                   Firestorm by rwxsu             --
------------------------------------------------------
--               License: do as you please          --
------------------------------------------------------

debug = true -- Debug mode for developers
reset = true -- Reset tasks by saying 'reset' to npc


task = {
    storage = {
        onTask       = 6522000,
        monstersLeft = 6522001,
        completed    = 6522002,
        getFinished  = 6522003,
    },
    tasks = { -- You can add as many tasks as you want
        [1] = {
            name = "Lobizomens", -- Name of Task
            description = "Os Lobizomens estão fora de controle.", -- What the NPC tells the player to do
            monsters = { -- You can add as many monsters as you want
                "Lobizomen"
            },
            toKill = 50, -- How many monsters the player needs to kill
            rewards = {    -- You can add as many rewards as you want
                [1] = {
                    name = "platinum coin",
                    itemid = 2152,
                    count = 35,
                },
                [2] = {
                    name = "task bronze coin",
                    itemid = 13382,
                    count = 5,
                }
            }
        },
        [2] = {
            name = "Morto Vivo", -- Name of Task
            description = "Há relatos de mortos estarem voltando a vida.", -- What the NPC tells the player to do
            monsters = { -- You can add as many monsters as you want
                "Morto Vivo"
            },
            toKill = 100, -- How many monsters the player needs to kill
            rewards = {    -- You can add as many rewards as you want
                [1] = {
                    name = "platinum coin",
                    itemid = 2152,
                    count = 60,
                },
                [2] = {
                    name = "task bronze coin",
                    itemid = 13382,
                    count = 5,
                }
            }
        },
        [3] = {
            name = "Mutante", -- Name of Task
            description = "Parece que alguem está fazendo experimentos humanos, você precisa exterminar o virus.", -- What the NPC tells the player to do
            monsters = { -- You can add as many monsters as you want
                "Mutante"
            },
            toKill = 300, -- How many monsters the player needs to kill
            rewards = {    -- You can add as many rewards as you want
                [1] = {
                    name = "crystal coin",
                    itemid = 2160,
                    count = 3,
                },
                [2] = {
                    name = "task bronze coin",
                    itemid = 13382,
                    count = 40,
                }
            }
        },
        [4] = {
            name = "Ninnja", -- Name of Task
            description = "Mate os Ninnjas, parece que eles estão tramando alguma coisa.", -- What the NPC tells the player to do
            monsters = { -- You can add as many monsters as you want
                "Ninnja"
            },
            toKill = 500, -- How many monsters the player needs to kill
            rewards = {    -- You can add as many rewards as you want
                [1] = {
                    name = "crystal coin",
                    itemid = 2160,
                    count = 10,
                },
                [2] = {
                    name = "task bronze coin",
                    itemid = 13382,
                    count = 75,
                }
            }
        },
        [4] = {
            name = "Androide", -- Name of Task
            description = "Extermine os Androides antes que aconteça a botnet.", -- What the NPC tells the player to do
            monsters = { -- You can add as many monsters as you want
                "Androide"
            },
            toKill = 1000, -- How many monsters the player needs to kill
            rewards = {    -- You can add as many rewards as you want
                [1] = {
                    name = "crystal coin",
                    itemid = 2160,
                    count = 15,
                },
                [2] = {
                    name = "task bronze coin",
                    itemid = 13383,
                    count = 1,
                }
            }
        }
    },
}

task.__index = task

-- Finds out what the last task the player did was, if any,
-- and gives the player a new task
function task:new(player, npcHandler) 
    if task:getCompleted(player) > 0 then
        task:reward(player, npcHandler)
        task:set(player, 0)
        return false
    end

    if task:onTask(player) > 0 then
        npcHandler:say("You already have a task.", player:getId())
        task:debug(player:getName() .. " is already on a task " .. task.tasks[task:onTask(player)].name  .. ".")
        return false
    end

    local lastFinished = task:getFinished(player)
    if lastFinished == #task.tasks then
        npcHandler:say("You have completed all the tasks!", player:getId())
        return false
    end

    local newTask = lastFinished + 1
    task:set(player, newTask)
    npcHandler:say(task.tasks[newTask].description, player:getId())
    return true
end

-- Sets the task provided 't' to the player provided
function task:set(player, t)
    if player:setStorageValue(task.storage.onTask, t) then       
        if t == 0 then
            task:debug(player:getName() .. " is no longer on task.")
            return false
        end
        task:debug(player:getName() .. " started task " .. task.tasks[t].name .. ".")
       
        if player:setStorageValue(task.storage.monstersLeft, task.tasks[t].toKill) then
            return true
        end
    end   
    return false
end

function task:setCompleted(player, t)
    if player:setStorageValue(task.storage.completed, t) then
        if t == 0 then
            return true
        end
        return true
    end
    return false
end

function task:getCompleted(player)
    return player:getStorageValue(task.storage.completed)
end

function task:getMonstersLeft(player)
    return player:getStorageValue(task.storage.monstersLeft)
end

-- Checks if the player is currently doing a task
-- And returns the task the player is doing
function task:onTask(player)
    for i = 1, #task.tasks do
        if player:getStorageValue(task.storage.onTask) == i then
            return i
        end
    end
    return 0
end

function task:setFinished(player, t)
    if player:setStorageValue(task.storage.getFinished, t) then
        task:debug(player:getName() .. " finished task " .. task.tasks[t].name)
        return true
    end
    return false
end

-- Checks if the player has finished a task
-- And returns the task that is finished
function task:getFinished(player)
    for i = 1, #task.tasks do
        if player:getStorageValue(task.storage.getFinished) == i then
            return i
        end
    end
    return 0
end

-- Checks if the monster killed was a task monster
function task:onKill(player, target)
    currentTask = task:onTask(player)
    for i = 1, #task.tasks[currentTask].monsters do
        if string.lower(target:getName()) == string.lower(task.tasks[currentTask].monsters[i]) then
           
            if task:getMonstersLeft(player) < 1 then
                return false
            end

            player:setStorageValue(task.storage.monstersLeft, task:getMonstersLeft(player) - 1)
            if task:getMonstersLeft(player) == 0 then
                if task:setCompleted(player, currentTask) then
                    player:sendTextMessage(MESSAGE_STATUS_WARNING, "You have completed your task.")
                    task:debug(string.format("%s has completed %s.", player:getName(), task.tasks[currentTask].name))
                    return true
                end
            end

            player:sendTextMessage(MESSAGE_STATUS_WARNING, "You killed a " .. string.lower(target:getName()) .. ". Only " .. task:getMonstersLeft(player) .. " left to kill!")
            task:debug(player:getName() .. " killed a " .. string.lower(target:getName()) .. ". " .. task:getMonstersLeft(player) .. " monsters left.") 
            return true
        end
    end
    return false
end

function task:reward(player, npcHandler)
    local t = task:onTask(player)
    for i = 1, #task.tasks[t].rewards do
        player:addItem(task.tasks[t].rewards[i].itemid, task.tasks[t].rewards[i].count)
        player:sendTextMessage(MESSAGE_STATUS_WARNING, string.format("You received %dx %s(s).", task.tasks[t].rewards[i].count, task.tasks[t].rewards[i].name))
        task:debug(string.format(player:getName() .. " received %dx %s(s).", task.tasks[t].rewards[i].count, task.tasks[t].rewards[i].name))
    end

    npcHandler:say("Here you go!", player:getId())

    task:onTask(player, 0)
    task:setCompleted(player, 0)
    task:setFinished(player, t)
    return true
end

-- Toggle true/false at the top of this lua file
-- Resets the tasks for the provided player
function task:reset(player, npcHandler)
    if reset then
        player:setStorageValue(task.storage.onTask, 0)
        player:setStorageValue(task.storage.monstersLeft, 0)
        player:setStorageValue(task.storage.completed, 0)
        player:setStorageValue(task.storage.getFinished, 0)
        npcHandler:say("You have reseted all the tasks.", player:getId())
        task:debug(player:getName() .. " reseted his tasks.")
    end
end

-- Toggle true/false at the top of this lua file
function task:debug(string)
    if debug then
        string = "[TASK] " .. string
    end
end