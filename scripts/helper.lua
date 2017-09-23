local helper = {}

-- Returns 2 position tables
-- takes the RRM, a direction, and an offset
-- Gets the Position from the passed RRM
-- Uses a hard coded 1 tile-ish area size (for now)
function helper.searchArea(RRM, direction, offset)
    local areaMod = 0.4 -- Because positions are centers
    
    local temp = helper.searchDirection(RRM, direction, offset)
    if temp.x ~= nil then -- By string label
        tx = temp.x
        ty = temp.y
    elseif temp[0] ~= nil then -- By numerical key
        tx = temp[0]
        ty = temp[1]
    end
    
    return {x = tx - areaMod, y = ty - areaMod}, {x = tx + areaMod, y = ty + areaMod}
end

function helper.searchDirection(RRM, direction, offset) -- Done AFAIK
    if direction == 0 then     -- South Y+
        return {x = RRM.position.x, y = RRM.position.y + offset}
    elseif direction == 2 then -- West  X-
        return {x = RRM.position.x - offset, y= RRM.position.y}
    elseif direction == 4 then -- North Y-
        return {x = RRM.position.x, y = RRM.position.y - offset}
    elseif direction == 6 then -- East  X+
        return {x = RRM.position.x + offset, y = RRM.position.y}
    else                       -- Broken!
        return "Wat!?"
    end
end

return helper
