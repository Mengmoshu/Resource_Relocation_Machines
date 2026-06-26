local Q = require('rmm-queue')

local range_table = {
    ['rrm-range10-building'] = 10,
    ['rrm-range20-building'] = 20,
    ['rrm-range30-building'] = 30
}

local function build_search_position(machine_dir, mpx, mpy, i)
    return {
        x = machine_dir == 4 and mpx + i or machine_dir == 12 and mpx - i or mpx,
        y = machine_dir == 0 and mpy - i or machine_dir == 8 and mpy + i or mpy
    }
end

local function find_closest(machine_dir, machine_pos, machine_name, machine_surface)
    local distance = range_table[machine_name]
    local find = machine_surface.find_entities_filtered
    local mpx, mpy = machine_pos.x, machine_pos.y
    for i = 1, distance do
        local search_position = build_search_position(machine_dir, mpx, mpy, i)
        local resource = find({position = search_position, type = 'resource'})[1]
        if resource then
            return resource
        end
    end
end

local function op_dir(d)
    return (d + 8) % 16
end

local function find_open_position(machine_dir, machine_pos, machine_name, machine_surface, res_name)
    machine_dir = op_dir(machine_dir) --Have to look behind the machine for an open position
    local distance = range_table[machine_name]
    local find = machine_surface.find_non_colliding_position
    local mpx, mpy = machine_pos.x, machine_pos.y
    for i = 1, distance do
        local search_position = build_search_position(machine_dir, mpx, mpy, i)
        local empty_spot = find(res_name, search_position, 0.5, 1, true)
        if empty_spot then
            return empty_spot
        end
    end
end

local function process_queue(q_index, q_bin)
    for i, bin_slot in pairs(q_bin) do --Iterate over every entry in this array.
        local entity = bin_slot.entity
        if entity.valid then --Verify entity is valid or remove it from the queue.
            local entity_dir = entity.direction
            local entity_pos = entity.position
            local entity_name = entity.name
            local entity_surface = entity.surface
            local resource = find_closest(entity_dir, entity_pos, entity_name, entity_surface)
            if resource then
                local closest_position = find_open_position(entity_dir, entity_pos, entity_name, entity_surface, resource.name)
                if closest_position then
                    resource.teleport(closest_position)
                end
            end
        else
            local data = {
                q_index = q_index,
                q_bin_slot = i
            }
            storage.machines[bin_slot.unit_number] = nil
            Q.r(data)
        end
    end
end

local function on_tick()
    local q = storage.queue
    local q_index = (game.tick % 60) + 1
    local q_bin = q[q_index]
    if q_bin and next(q_bin) then --Ensures that the current bin exists and is not empty
        process_queue(q_index, q_bin)
    end
end

local function initialize_rmm_machine(event)
    local entity = event.created_entity or event.entity
    local entity_name = entity.name
    if range_table[entity_name] then --Check if valid entity to work with
        if not storage.running then --Initialize the queue if it's not running already.
            storage.queue = {}
            storage.running = true
            script.on_event(defines.events.on_tick, on_tick)
        end
        local data = Q.a(entity) --Store the entity in the queue
        storage.machines = storage.machines or {}
        storage.machines[entity.unit_number] = data --Table returned from Q.a stores bin/bin_slot under the entities unit number. This allows you to remove it in the event it's invalid later in the script
    end
end
script.on_event(defines.events.on_built_entity, initialize_rmm_machine)
script.on_event(defines.events.on_robot_built_entity, initialize_rmm_machine)

local function on_load()
    if storage.running then
        script.on_event(defines.events.on_tick, on_tick)
    end
end
script.on_load(on_load)
