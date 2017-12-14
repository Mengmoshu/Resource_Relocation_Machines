-- Version for constant-combinator type
-- Already displays nicely, doesn't draw power.
-- Directions in code need to be altered so art and arrows and behaviour align?
function make_rrm(inputs)
    local temp = util.table.deepcopy(data.raw["constant-combinator"]["constant-combinator"])

    temp.name = "rrm-range" .. inputs.range .. "-building"
    temp.icon = "__Resource_Relocation_Machines__/graphics/Range" .. inputs.range .. "-Icon.png"
    temp.icon_size = 32
    temp.minable = {hardness = 0.1, mining_time = 0.1, result = "rrm-range10"}
    temp.max_health = 50
    temp.item_slot_count = 1
    temp.sprites =
        {   -- Note that this version inverts the directions.
            north = {
                filename = "__Resource_Relocation_Machines__/graphics/Range" .. inputs.range .. "-Active-S.png",
                priority = "high",
                width = 32,
                height = 32,
                frame_count = 1,
                shift = {0, 0},
            },
            east = {
                filename = "__Resource_Relocation_Machines__/graphics/Range" .. inputs.range .. "-Active-W.png",
                priority = "high",
                width = 32,
                height = 32,
                frame_count = 1,
                shift = {0, 0},
            },
            south = {
                filename = "__Resource_Relocation_Machines__/graphics/Range" .. inputs.range .. "-Active-N.png",
                priority = "high",
                width = 32,
                height = 32,
                frame_count = 1,
                shift = {0, 0},
            },
            west = {
                filename = "__Resource_Relocation_Machines__/graphics/Range" .. inputs.range .. "-Active-E.png",
                priority = "high",
                width = 32,
                height = 32,
                frame_count = 1,
                shift = {0, 0},
            },
        }
    temp.circuit_wire_max_distance = 0

    return temp
end

data:extend(
{
make_rrm{range = 10},
make_rrm{range = 20},
make_rrm{range = 30}
}
)
