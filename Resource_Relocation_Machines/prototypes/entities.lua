--[[
RRM Differences:
Inserter:
    - name
    - icon
    - platform_picture
--]]

-- Version for inserter type
-- Just feed it the numerical range desired.
--[[
function make_rrm(inputs)
return
    {
        type = "inserter",
        name = "rrm-range" .. inputs.range .."-building",
        icon = "__Resource_Relocation_Machine__/graphics/Range" .. inputs.range .. "-Icon.png",
        flags = {"placeable-neutral", "placeable-player", "player-creation"},
        minable = {hardness = 0.2, mining_time = 0.5, result = "rrm-range10"},
        max_health = 250,
        corpse = "small-remnants",
        dying_explosion = "medium-explosion",
        resistances = {{type = "fire", percent = 70}},
        collision_box = {{-0.4, -0.4}, {0.4, 0.4}},
        selection_box = {{-0.5, -0.5}, {0.5, 0.5}},


        energy_per_movement = 1,
        energy_per_rotation = 1,
        extension_speed = 0.01,
        rotation_speed = 0.01,
        pickup_position = {0, -1},
        insert_position = {0, 1.2},
        platform_picture =
        {
            north = {
                filename = "__Resource_Relocation_Machine__/graphics/Range" .. inputs.range .. "-Active-N.png",
                priority = "high",
                width = 32,
                height = 32,
                frame_count = 1,
                shift = {0, 0},
            },
            east = {
                filename = "__Resource_Relocation_Machine__/graphics/Range" .. inputs.range .. "-Active-E.png",
                priority = "high",
                width = 32,
                height = 32,
                frame_count = 1,
                shift = {0, 0},
            },
            south = {
                filename = "__Resource_Relocation_Machine__/graphics/Range" .. inputs.range .. "-Active-S.png",
                priority = "high",
                width = 32,
                height = 32,
                frame_count = 1,
                shift = {0, 0},
            },
            west = {
                filename = "__Resource_Relocation_Machine__/graphics/Range" .. inputs.range .. "-Active-W.png",
                priority = "high",
                width = 32,
                height = 32,
                frame_count = 1,
                shift = {0, 0},
            },
        },
        hand_base_picture =
        {
            filename = "__base__/graphics/entity/inserter/inserter-hand-base.png",
            priority = "extra-high",
            width = 8,
            height = 33
        },
        hand_closed_picture =
        {
            filename = "__base__/graphics/entity/inserter/inserter-hand-closed.png",
            priority = "extra-high",
            width = 18,
            height = 41
        },
        hand_open_picture =
        {
            filename = "__base__/graphics/entity/inserter/inserter-hand-open.png",
            priority = "extra-high",
            width = 18,
            height = 41
        },
        hand_base_shadow =
        {
            filename = "__base__/graphics/entity/burner-inserter/burner-inserter-hand-base-shadow.png",
            priority = "extra-high",
            width = 8,
            height = 34
        },
        hand_closed_shadow =
        {
            filename = "__base__/graphics/entity/burner-inserter/burner-inserter-hand-closed-shadow.png",
            priority = "extra-high",
            width = 18,
            height = 41
        },
        hand_open_shadow =
        {
            filename = "__base__/graphics/entity/burner-inserter/burner-inserter-hand-open-shadow.png",
            priority = "extra-high",
            width = 18,
            height = 41
        },

        energy_source =
        {
            type = "electric",
            usage_priority = "secondary-input",
            drain = "10kW",
            emissions = 10,
        },	

        energy_usage = "1kW",
        module_slots = 0,
        rotatable = true,
        operable = false,
        open_sound = { filename = "__base__/sound/machine-open.ogg", volume = 0.85 },
        close_sound = { filename = "__base__/sound/machine-close.ogg", volume = 0.75 },
        vehicle_impact_sound =  { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },

    }
end
--]]

-- Version for constant-combinator type
-- Already displays nicely, but doesn't draw power.
-- Directions in code need to be altered so art and arrows and behaviour align.
function make_rrm(inputs)
return
    {
    type = "constant-combinator",
    name = "rrm-range" .. inputs.range .."-building",
    icon = "__Resource_Relocation_Machine__/graphics/Range" .. inputs.range .. "-Icon.png",
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
            filename = "__Resource_Relocation_Machine__/graphics/Range" .. inputs.range .. "-Active-S.png",
            priority = "high",
            width = 32,
            height = 32,
            frame_count = 1,
            shift = {0, 0},
        },
        east = {
            filename = "__Resource_Relocation_Machine__/graphics/Range" .. inputs.range .. "-Active-W.png",
            priority = "high",
            width = 32,
            height = 32,
            frame_count = 1,
            shift = {0, 0},
        },
        south = {
            filename = "__Resource_Relocation_Machine__/graphics/Range" .. inputs.range .. "-Active-N.png",
            priority = "high",
            width = 32,
            height = 32,
            frame_count = 1,
            shift = {0, 0},
        },
        west = {
            filename = "__Resource_Relocation_Machine__/graphics/Range" .. inputs.range .. "-Active-E.png",
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
        filename = "__base__/graphics/entity/combinator/activity-leds/combinator-led-constant-north.png",
        width = 11,
        height = 10,
        frame_count = 1,
        shift = {0.296875, -0.40625},
      },
      east =
      {
        filename = "__base__/graphics/entity/combinator/activity-leds/combinator-led-constant-east.png",
        width = 14,
        height = 12,
        frame_count = 1,
        shift = {0.25, -0.03125},
      },
      south =
      {
        filename = "__base__/graphics/entity/combinator/activity-leds/combinator-led-constant-south.png",
        width = 11,
        height = 11,
        frame_count = 1,
        shift = {-0.296875, -0.078125},
      },
      west =
      {
        filename = "__base__/graphics/entity/combinator/activity-leds/combinator-led-constant-west.png",
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

-- Version for constant-combinator type
-- Draws power, and I like having the arrow stickers, native GUI is useless.
-- Directions in code need to be altered so art and arrows and behaviour align.
--[[
function make_rrm(inputs)
return
  {
    type = "decider-combinator",
    name = "rrm-range" .. inputs.range .."-building",
    icon = "__Resource_Relocation_Machine__/graphics/Range" .. inputs.range .. "-Icon.png",
    flags = {"placeable-neutral", "player-creation"},
    minable = {hardness = 0.2, mining_time = 0.5, result = "rrm-range10"},
    max_health = 50,
    corpse = "small-remnants",
    collision_box = {{-0.4, -0.4}, {0.4, 0.4}},
    selection_box = {{-0.5, -0.5}, {0.5, 0.5}},

    energy_source =
    {
      type = "electric",
      usage_priority = "secondary-input"
    },
    active_energy_usage = "1KW",

    sprites =
    {   -- Note that this version inverts the directions.
        north = {
            filename = "__Resource_Relocation_Machine__/graphics/Range" .. inputs.range .. "-Active-S.png",
            priority = "high",
            width = 32,
            height = 32,
            frame_count = 1,
            shift = {0, 0},
        },
        east = {
            filename = "__Resource_Relocation_Machine__/graphics/Range" .. inputs.range .. "-Active-W.png",
            priority = "high",
            width = 32,
            height = 32,
            frame_count = 1,
            shift = {0, 0},
        },
        south = {
            filename = "__Resource_Relocation_Machine__/graphics/Range" .. inputs.range .. "-Active-N.png",
            priority = "high",
            width = 32,
            height = 32,
            frame_count = 1,
            shift = {0, 0},
        },
        west = {
            filename = "__Resource_Relocation_Machine__/graphics/Range" .. inputs.range .. "-Active-E.png",
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
        filename = "__base__/graphics/entity/combinator/activity-leds/combinator-led-decider-north.png",
        width = 11,
        height = 12,
        frame_count = 1,
        shift = {0.265625, -0.53125},
      },
      east =
      {
        filename = "__base__/graphics/entity/combinator/activity-leds/combinator-led-decider-east.png",
        width = 11,
        height = 11,
        frame_count = 1,
        shift = {0.515625, -0.078125},
      },
      south =
      {
        filename = "__base__/graphics/entity/combinator/activity-leds/combinator-led-decider-south.png",
        width = 12,
        height = 12,
        frame_count = 1,
        shift = {-0.25, 0.03125},
      },
      west =
      {
        filename = "__base__/graphics/entity/combinator/activity-leds/combinator-led-decider-west.png",
        width = 12,
        height = 12,
        frame_count = 1,
        shift = {-0.46875, -0.5},
      }
    },

    activity_led_light =
    {
      intensity = 0.8,
      size = 1,
    },

    activity_led_light_offsets =
    {
      {0.265625, -0.53125},
      {0.515625, -0.078125},
      {-0.25, 0.03125},
      {-0.46875, -0.5}
    },

    screen_light =
    {
      intensity = 0.3,
      size = 0.6,
    },

    screen_light_offsets =
    {
      {0.015625, -0.265625},
      {0.015625, -0.359375},
      {0.015625, -0.265625},
      {0.015625, -0.359375}
    },

    equal_symbol_sprites =
    {
      north =
      {
        filename = "__base__/graphics/entity/combinator/combinator-displays.png",
        x = 15,
        y = 11,
        width = 15,
        height = 11,
        frame_count = 1,
        shift = {0.015625, -0.265625}
      },
      east =
      {
        filename = "__base__/graphics/entity/combinator/combinator-displays.png",
        x = 15,
        y = 11,
        width = 15,
        height = 11,
        frame_count = 1,
        shift = {0.015625, -0.359375}
      },
      south =
      {
        filename = "__base__/graphics/entity/combinator/combinator-displays.png",
        x = 15,
        y = 11,
        width = 15,
        height = 11,
        frame_count = 1,
        shift = {0.015625, -0.265625}
      },
      west =
      {
        filename = "__base__/graphics/entity/combinator/combinator-displays.png",
        x = 15,
        y = 11,
        width = 15,
        height = 11,
        frame_count = 1,
        shift = {0.015625, -0.359375}
      }
    },
    greater_symbol_sprites =
    {
      north =
      {
        filename = "__base__/graphics/entity/combinator/combinator-displays.png",
        x = 30,
        y = 11,
        width = 15,
        height = 11,
        frame_count = 1,
        shift = {0.015625, -0.265625}
      },
      east =
      {
        filename = "__base__/graphics/entity/combinator/combinator-displays.png",
        x = 30,
        y = 11,
        width = 15,
        height = 11,
        frame_count = 1,
        shift = {0.015625, -0.359375}
      },
      south =
      {
        filename = "__base__/graphics/entity/combinator/combinator-displays.png",
        x = 30,
        y = 11,
        width = 15,
        height = 11,
        frame_count = 1,
        shift = {0.015625, -0.265625}
      },
      west =
      {
        filename = "__base__/graphics/entity/combinator/combinator-displays.png",
        x = 30,
        y = 11,
        width = 15,
        height = 11,
        frame_count = 1,
        shift = {0.015625, -0.359375}
      }
    },
    less_symbol_sprites =
    {
      north =
      {
        filename = "__base__/graphics/entity/combinator/combinator-displays.png",
        x = 45,
        y = 11,
        width = 15,
        height = 11,
        frame_count = 1,
        shift = {0.015625, -0.265625}
      },
      east =
      {
        filename = "__base__/graphics/entity/combinator/combinator-displays.png",
        x = 45,
        y = 11,
        width = 15,
        height = 11,
        frame_count = 1,
        shift = {0.015625, -0.359375}
      },
      south =
      {
        filename = "__base__/graphics/entity/combinator/combinator-displays.png",
        x = 45,
        y = 11,
        width = 15,
        height = 11,
        frame_count = 1,
        shift = {0.015625, -0.265625}
      },
      west =
      {
        filename = "__base__/graphics/entity/combinator/combinator-displays.png",
        x = 45,
        y = 11,
        width = 15,
        height = 11,
        frame_count = 1,
        shift = {0.015625, -0.359375}
      }
    },

    input_connection_bounding_box = {{-0.5, 0}, {0.5, 1}},
    output_connection_bounding_box = {{-0.5, -1}, {0.5, 0}},

    input_connection_points =
    {
      {
        shadow =
        {
          red = {0.328125, 0.703125},
          green = {0.859375, 0.703125}
        },
        wire =
        {
          red = {-0.28125, 0.34375},
          green = {0.25, 0.34375},
        }
      },
      {
        shadow =
        {
          red = {-0.265625, -0.171875},
          green = {-0.296875, 0.296875},
        },
        wire =
        {
          red = {-0.75, -0.5},
          green = {-0.75, -0.0625},
        }
      },
      {
        shadow =
        {
          red = {0.828125, -0.359375},
          green = {0.234375, -0.359375}
        },
        wire =
        {
          red = {0.25, -0.71875},
          green = {-0.28125, -0.71875}
        }
      },
      {
        shadow =
        {
          red = {1.29688, 0.328125},
          green = {1.29688, -0.140625},
        },
        wire =
        {
          red = {0.75, -0.0625},
          green = {0.75, -0.53125},
        }
      }
    },

    output_connection_points =
    {
      {
        shadow =
        {
          red = {0.234375, -0.453125},
          green = {0.828125, -0.453125}
        },
        wire =
        {
          red = {-0.3125, -0.78125},
          green = {0.28125, -0.78125},
        }
      },
      {
        shadow =
        {
          red = {1.17188, -0.109375},
          green = {1.17188, 0.296875},
        },
        wire =
        {
          red = {0.65625, -0.4375},
          green = {0.65625, -0.03125},
        }
      },
      {
        shadow =
        {
          red = {0.828125, 0.765625},
          green = {0.234375, 0.765625}
        },
        wire =
        {
          red = {0.28125, 0.40625},
          green = {-0.3125, 0.40625}
        }
      },
      {
        shadow =
        {
          red = {-0.140625, 0.328125},
          green = {-0.140625, -0.078125},
        },
        wire =
        {
          red = {-0.6875, -0.03125},
          green = {-0.6875, -0.4375},
        }
      }
    },
    circuit_wire_max_distance = 0
  }
end
--]]

data:extend(
{
make_rrm{range = 10},
make_rrm{range = 20},
make_rrm{range = 30}
}
)