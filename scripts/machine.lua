local helper = require "helper"

local m = {}
local typeJump = {
    -- key = entity.name, value = function
    "rrm-range10-building" = ResourceRelocationMachine,
    "rrm-range20-building" = ResourceRelocationMachine,
    "rrm-range30-building" = ResourceRelocationMachine
}

function ResourceRelocationMachine(entity) -- RRM specific ticking

end

function m.tick(bucket)
    for k, v in pairs(bucket) do
        local name = v.name
        -- Function table magic?
        typeJump.[name](v)
    end
end

-- Performance Queue Notes:
-- Write new version of this function to take a Bucket table, named m.tick()
-- Refactor machine class specific stuff into seperate function
-- Rename this function to processMachines(bucket)
function m.processRRMs()
    for k, RRM in pairs(global.RRMs) do
    
        if RRM.valid then -- Check to see if the RRM is there
            local range = machine.setRange(RRM.name)
            local infront = RRM.direction
            local behind = (RRM.direction + 4) % 8
            local signal = nil
            
            if myDebug == true then
                RRM.surface.print("processRRMs fired, RRM.valid true")
                RRM.surface.print(RRM.direction)
            end
            
            -- Search behind RRM for ore
            for k = 1, range + 1 do
                test = RRM.surface.find_entities_filtered({area = {helper.searchArea(RRM, behind, k)}, type = "resource"}) -- Tile for ore
                if test ~= nil then -- If the list is not empty something was found, time to work
                    for k, xx in pairs(test) do -- Iterate over the (Hopefully small) list of found resources
                        if xx.name ~= "crude-oil" then -- We don't relocate oil patches
                            signal = xx
                            break
                        end
                    end
                end
                if signal ~= nil then
                    break -- Drop out of search loop to let teleport loop have its turn
                end
            end
            
            -- Only do this if signal is found and/or there's an ore entity to work with
            if signal ~= nil then
                -- Find suitable destination
                for n = 1, range + 1 do
                    dest = RRM.surface.find_entities_filtered({area = {helper.searchArea(RRM, infront, n)}, type = "resource"}) -- We only need there to be no entities of type "resource"
                    if next(dest) == nil then
                        signal.teleport({helper.searchDirection(RRM, infront, n).x, helper.searchDirection(RRM, infront, n).y})
                        -- Set signal variable to successful ore move
                        break -- Goes out one for loop
                    end
                end
            end
        else
            table.remove(global.RRMs, k) -- Remove missing RRM
            if #global.RRMs == 0 then
                global.RRMs = nil -- Nil the table so ticker will stop
            end
        end
    
    end
end


function m.setRange(name) -- Done AFAIK
    if name == "rrm-range10-building" then
        return 10
    elseif name == "rrm-range20-building" then
        return 20
    elseif name == "rrm-range30-building" then
        return 30
    else
        return "Wat!?"
    end
end

return m
