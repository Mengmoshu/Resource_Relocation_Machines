-- Pulled from Item Collectors
-- Reinitialize ticker when game loads (Does this also run on a fresh game?)

myDebug = false
MAX_PER_TICK = 10
LEVELS = 8
TICKS_PER_RRM = 30
allowed_rrms = 0

function debug(text)
   if myDebug then
      log(text)
   end
end

function init()
   local rrms = global.rrms
   if rrms == nil then
      rrms = {}
      global.rrms = rrms
      global.num_rrms = 0
      global.current_loop = 1
      global.current_level = 0
      global.current_rrms = {}
      global.block_loop = true
      global.ticks = TICKS_PER_RRM
   end
   for i = 1, LEVELS do
      if rrms[i] == nil then
	 rrms[i] = {}
      end
   end
   if global.num_rrms > 0 then
      script.on_event(defines.events.on_tick, ticker)
   end
   debug("global data = " .. serpent.block(global))
end

script.on_init(init)
script.on_load(init)

-- Pulled from Item Collectors
-- Count down a delay for processing RRMs
function ticker()
   if global.block_loop then
      if global.ticks <= 0 then
	 global.ticks = TICKS_PER_RRM
	 global.block_loop = false
      else
	 global.ticks = global.ticks - 1
      end
   end
   if global.num_rrms == 0 then
      script.on_event(defines.events.on_tick, nil)
   else
      allowed_rrms = math.min(allowed_rrms + global.num_rrms / TICKS_PER_RRM,
			      MAX_PER_TICK,
			      global.num_rrms)
      processRRMs()
   end
end

-- Do "sensible things" about newly placed RRMs
function builtEntity(event) -- Done AFAIK
   if event.created_entity.name == "rrm-range10-building" or event.created_entity.name == "rrm-range20-building" or event.created_entity.name == "rrm-range30-building" then
      if myDebug == true then event.created_entity.surface.print("builtEntity fired") end
      if global.num_rrms then
	 script.on_event(defines.events.on_tick, ticker)
	 if myDebug == true then
            event.created_entity.surface.print("ticker registered")
	 end
      end
      global.num_rrms = global.num_rrms + 1
      table.insert(global.rrms[1], event.created_entity)
      if myDebug == true then
	 event.created_entity.surface.print("new RRM inserted")
      end
   end
end

script.on_event(defines.events.on_built_entity, builtEntity)
script.on_event(defines.events.on_robot_built_entity, builtEntity)

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
    local inverted = false
    if in_name == nil then
       in_range = range
       out_name = in_name
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
        -- negative out_range means filter is inverted
        inverted = true
        out_range = -out_range
    end
    if out_range > range then
        out_range = range
    end
    return in_name, in_range, out_name, out_range, inverted
end

function processRRMs()
   log("processing " .. allowed_rrms)
   while allowed_rrms >= 1 do
      -- grab next slize to work on
      while #global.current_rrms == 0 do
	 global.current_level = global.current_level + 1
	 if global.current_level > LEVELS then
	    global.current_level = 1
	    global.current_loop = global.current_loop + 2
	    if global.block_loop then
	       return
	    else
	       global.block_loop = true
	    end
	 end
	 if bit32.extract(global.current_loop, (global.current_level - 1)) ~= 0 then
	    global.current_rrms = global.rrms[global.current_level]
	    global.rrms[global.current_level] = {}
	 end
      end

      debug("current_loop = " .. global.current_loop .. ", current_level = " .. global.current_level)
      debug("current_rrms = " .. serpent.block(global.current_rrms))
      if allowed_rrms >= #global.current_rrms then
	 debug("  taking")
	 rrms = global.current_rrms
	 global.current_rrms = {}
      else
	 debug("  splitting at " .. allowed_rrms)
	 rrms = table.pack(table.unpack(global.current_rrms, 1, allowed_rrms))
	 global.current_rrms = table.pack(table.unpack(global.current_rrms, allowed_rrms + 1))
      end

      debug("rrms = " .. serpent.block(rrms) .. ", current_rrms = " .. serpent.block(global.current_rrms))
      allowed_rrms = allowed_rrms - #rrms
      for i, rrm in ipairs(rrms) do
	 if rrm.valid then -- Check to see if the RRM is there
	    local in_name = nil
	    local in_range = 0
	    local out_name = nil
	    local out_range = 1
	    in_name, in_range, out_name, out_range, inverted = RRMOptions(rrm)
            local infront = rrm.direction
            local behind = (rrm.direction + 4) % 8
            local signal = nil
            
            --if myDebug == true then
	    --   rrm.surface.print("processRRMs fired, RRM.valid true")
	    --   rrm.surface.print(rrm.direction)
            --end
            
            -- Search under and behind RRM for ore
            for k = 0, in_range - 1 do
                test = rrm.surface.find_entities_filtered({area = {searchArea(rrm, behind, k)}, type = "resource"}) -- Tile for ore
                if test ~= nil then -- If the list is not empty something was found, time to work
                    for k, xx in pairs(test) do -- Iterate over the (Hopefully small) list of found resources
		        if in_name == nil then
			    if xx.name ~= "crude-oil" then -- We don't relocate oil patches
			        signal = xx
			        break
			    end
			elseif inverted then
			    if in_name ~= xx.name and out_name ~= xx.name then
			        signal = xx
			        break
			    end
			else
			    if in_name == xx.name or out_name == xx.name then
			        signal = xx
			        break
			    end
			end
                    end
                end
                if signal ~= nil then
                    break -- Drop out of search loop to let teleport loop have its turn
                end
            end
            
            -- Only do this if signal is found and/or there's an ore entity to work with
	    local moved = false
            if signal ~= nil then
                -- Find suitable destination
                for n = 1, out_range do
                    dest = rrm.surface.find_entities_filtered({area = {searchArea(rrm, infront, n)}, type = "resource"}) -- We only need there to be no entities of type "resource"
                    if next(dest) == nil then
                        signal.teleport({searchDirection(rrm, infront, n).x, searchDirection(rrm, infront, n).y})
                        -- Set signal variable to successful ore move
			moved = true
                        break -- Goes out one for loop
                    end
                end
	    end
	    if moved then
	       table.insert(global.rrms[1], rrm)
	       debug("  moving to 1")
	    else
	       local next_level = math.min(global.current_level + 1, LEVELS)
	       table.insert(global.rrms[next_level], rrm)
	       debug("  moving to " .. next_level)
	    end
	 else
	    -- rrm not valid, remove it
	    global.num_rrms = global.num_rrms - 1
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
