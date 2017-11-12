-- Pulled from Item Collectors
-- Reinitialize ticker when game loads (Does this also run on a fresh game?)

myDebug = false

script.on_load(function() -- Done AFAIK
    if global.RRMs ~= nil then -- Guard against empty/missing table
        script.on_event(defines.events.on_tick, ticker)
    end
end)

-- Pulled from Item Collectors
-- Count down a delay for processing RRMs
function ticker() -- Done AFAIK
  if global.RRMs ~= nil then
    if global.ticks == 0 or global.ticks == nil then
      global.ticks = 29 -- Created here
      processRRMs()
    else
      global.ticks = global.ticks - 1
    end
  else
    script.on_event(defines.events.on_tick, nil) -- Completely stop ticker when there are no buildings to process
  end
end

-- Do "sensible things" about newly placed RRMs
function builtEntity(event) -- Done AFAIK
    if event.created_entity.name == "rrm-range10-building" or event.created_entity.name == "rrm-range20-building" or event.created_entity.name == "rrm-range30-building" then
        if myDebug == true then event.created_entity.surface.print("builtEntity fired") end
        if global.RRMs == nil then -- Guard against empty/missing table
          global.RRMs = {} -- Create the table (Only place this happens)
          script.on_event(defines.events.on_tick, ticker)
          if myDebug == true then
            event.created_entity.surface.print("global.RRMs created and ticker registered")
          end
        end
        
        table.insert(global.RRMs, event.created_entity)
        if myDebug == true then
            event.created_entity.surface.print("new RRM inserted to global.RRMs")
        end
    end
end

script.on_event(defines.events.on_built_entity, builtEntity)
script.on_event(defines.events.on_robot_built_entity, builtEntity)


function print_resource(RRM, x)
   RRM.surface.print("resource(" .. x.name .. ", " .. x.type .. ")")
   control = RRM.get_control_behavior()
   if control ~= nil then
      parameters = control.parameters
      if parameters ~= nil then
	 parameters = parameters.parameters
	 input = parameters[1]
	 output = parameters[2]
	 in_count = input.count
	 in_name = input.signal.name
	 if in_name == nil then
	    in_name = "<NIL>"
	 end
	 out_count = output.count
	 out_name = output.signal.name
	 if out_name == nil then
	    out_name = "<NIL>"
	 end
	 RRM.surface.print("  " .. in_name .. ":" .. in_count .. " -> " .. out_name .. ":" .. out_count)
      end
   end
end

function RRMOptions(RRM)
    -- set maximum range according to name
    local range = 1
    if RRM.name == "rrm-range10-building" then
        range = 10
    elseif RRM.name == "rrm-range20-building" then
        range = 20
    elseif RRM.name == "rrm-range30-building" then
        range = 30
    end
    -- check combinator settings
    local control = RRM.get_control_behavior()
    local parameters = control.parameters
    parameters = parameters.parameters
    local input = parameters[1]
    local output = parameters[2]
    local in_range = input.count
    local in_name = input.signal.name
    if in_name == nil then
       in_range = range
    elseif in_range < 0 then
    -- negative in_range filters for infinite ores
        in_name = "infinite-" .. in_name
        in_range = -in_range
    end
    if in_range > range then
        in_range = range
    end
    local out_range = output.count
    local out_name = output.signal.name
    if out_name == nil then
        out_range = range
    elseif out_range < 0 then
    -- negative out_range filters for infinite ores
        out_name = "infinite-" .. in_name
        out_range = -out_range
    end
    if out_range > range then
        out_range = range
    end
    return in_name, in_range, out_name, out_range
end

function processRRMs()
    for k, RRM in pairs(global.RRMs) do

        if RRM.valid then -- Check to see if the RRM is there
	    local in_name = nil
	    local in_range = 0
	    local out_name = nil
	    local out_range = 1
	    in_name, in_range, out_name, out_range = RRMOptions(RRM)
            local infront = RRM.direction
            local behind = (RRM.direction + 4) % 8
            local signal = nil
            
            if myDebug == true then
                RRM.surface.print("processRRMs fired, RRM.valid true")
                RRM.surface.print(RRM.direction)
            end
            
            -- Search under and behind RRM for ore
            for k = 0, in_range - 1 do
                test = RRM.surface.find_entities_filtered({area = {searchArea(RRM, behind, k)}, type = "resource"}) -- Tile for ore
                if test ~= nil then -- If the list is not empty something was found, time to work
                    for k, xx in pairs(test) do -- Iterate over the (Hopefully small) list of found resources
		        if in_name == nil and out_name == nil then
			    if xx.name ~= "crude-oil" then -- We don't relocate oil patches
			        signal = xx
			        break
			    end
			elseif in_name == xx.name or out_name == xx.name then
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
                for n = 1, out_range do
                    dest = RRM.surface.find_entities_filtered({area = {searchArea(RRM, infront, n)}, type = "resource"}) -- We only need there to be no entities of type "resource"
                    if next(dest) == nil then
                        signal.teleport({searchDirection(RRM, infront, n).x, searchDirection(RRM, infront, n).y})
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

-- Returns 2 position tables
-- takes the RRM, a direction, and an offset
-- Gets the Position from the passed RRM
-- Uses a hard coded 1 tile-ish area size (for now)
function searchArea(RRM, direction, offset)
    local areaMod = 0.4 -- Because positions are centers
    
    local temp = {x = searchDirection(RRM, direction, offset).x, y = searchDirection(RRM, direction, offset).y}
    if temp.x ~= nil then -- By string label
        tx = temp.x
        ty = temp.y
    elseif temp[0] ~= nil then -- By numerical key
        tx = temp[0]
        ty = temp[1]
    end
    
    return {x = tx - areaMod, y = ty - areaMod}, {x = tx + areaMod, y = ty + areaMod}
end

function searchDirection(RRM, direction, offset) -- Done AFAIK
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
