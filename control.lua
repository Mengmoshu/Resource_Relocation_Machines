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
function ticker()
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
