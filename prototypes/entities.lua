-- Version for constant-combinator type
-- Already displays nicely, doesn't draw power.
-- Directions in code need to be altered so art and arrows and behaviour align?
function make_rrm(inputs)
return
    {
    type = "constant-combinator",
    name = "rrm-range" .. inputs.range .."-building",
    icon = "__Resource_Relocation_Machines__/graphics/Range" .. inputs.range .. "-Icon.png",
    icon_size = 32,

    flags = {"placeable-neutral", "player-creation"},
    minable = {hardness = 0.2, mining_time = 0.5, result = "rrm-range10"},
    max_health = 50,
    corpse = "small-remnants",

    collision_box = {{-0.4, -0.4}, {0.4, 0.4}},
    selection_box = {{-0.5, -0.5}, {0.5, 0.5}},

    item_slot_count = 1,

    sprites =
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
    },

    activity_led_sprites =
    {
      north =
      {
        filename = "__base__/graphics/entity/combinator/activity-leds/hr-constant-combinator-LED-N.png",
        width = 11,
        height = 10,
        frame_count = 1,
        shift = {0.296875, -0.40625},
      },
      east =
      {
        filename = "__base__/graphics/entity/combinator/activity-leds/hr-constant-combinator-LED-E.png",
        width = 14,
        height = 12,
        frame_count = 1,
        shift = {0.25, -0.03125},
      },
      south =
      {
        filename = "__base__/graphics/entity/combinator/activity-leds/hr-constant-combinator-LED-S.png",
        width = 11,
        height = 11,
        frame_count = 1,
        shift = {-0.296875, -0.078125},
      },
      west =
      {
        filename = "__base__/graphics/entity/combinator/activity-leds/hr-constant-combinator-LED-W.png",
        width = 12,
        height = 12,
        frame_count = 1,
        shift = {-0.21875, -0.46875},
      }
    },

    activity_led_light =
    {
      intensity = 0.8,
      size = 1,
    },

    activity_led_light_offsets =
    {
      {0.296875, -0.40625},
      {0.25, -0.03125},
      {-0.296875, -0.078125},
      {-0.21875, -0.46875}
    },

    circuit_wire_connection_points =
    {
      {
        shadow =
        {
          red = {0.15625, -0.28125},
          green = {0.65625, -0.25}
        },
        wire =
        {
          red = {-0.28125, -0.5625},
          green = {0.21875, -0.5625},
        }
      },
      {
        shadow =
        {
          red = {0.75, -0.15625},
          green = {0.75, 0.25},
        },
        wire =
        {
          red = {0.46875, -0.5},
          green = {0.46875, -0.09375},
        }
      },
      {
        shadow =
        {
          red = {0.75, 0.5625},
          green = {0.21875, 0.5625}
        },
        wire =
        {
          red = {0.28125, 0.15625},
          green = {-0.21875, 0.15625}
        }
      },
      {
        shadow =
        {
          red = {-0.03125, 0.28125},
          green = {-0.03125, -0.125},
        },
        wire =
        {
          red = {-0.46875, 0},
          green = {-0.46875, -0.40625},
        }
      }
    },

    circuit_wire_max_distance = 0
    }
end

data:extend(
{
make_rrm{range = 10},
make_rrm{range = 20},
make_rrm{range = 30}
}
)
