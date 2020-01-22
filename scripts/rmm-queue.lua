local queue = {}

function queue.a(entity)
    local q = global.queue
    local q_index = (game.tick % 60) + 1    --Grab the index from 1-60 based on game tick
    local q_data = {                        --Build the queue entry
        entity = entity,
        unit_number = entity.unit_number,
    }
    q[q_index] = q[q_index] or {}           --Ensure there's a "bin" at this queue index
    local q_bin = q[q_index]
    local q_bin_slot = #q_bin + 1           --Each bin is an array.
    q_bin[q_bin_slot] = q_data
    return {q_index, q_bin_slot}            --Return the index and bin slot for reverse reference later for removal from the queue
end

function queue.r(data)
    local q = global.queue
    q[data.q_index][data.q_bin_slot] = nil              --data -> {q_index, q_bin_slot} gained from earlier
    if not next(q[data.q_index]) then                   --Check if the current "bin" is empty
        q[data.q_index] = nil                           --Nil the bin entry so it doesn't get iterated with pairs()
    end
    if not next(q) then                                 --Check if global.queue is empty
        global.running = false                          --Set running to false. Running is for on_load conditional registry
        script.on_event(defines.events.on_tick, nil)
    end
end

return queue
