data:extend({

	-- RRM Range 10
	{
    type = "recipe",
    name = "rrm-range10",
    enabled = "true",
    ingredients = 
    {
      {"iron-gear-wheel", 5},
      {"copper-cable", 2},
      {"iron-plate", 4}
    },
    result = "rrm-range10"
	},
    
    -- RRM Range 20
    {
    type = "recipe",
    name = "rrm-range20",
    enabled = "true",
    ingredients = 
    {
      {"rrm-range10",1},
    },
    result = "rrm-range20"
	},
    
    -- RRM Range 30
    {
    type = "recipe",
    name = "rrm-range30",
    enabled = "true",
    ingredients = 
    {
      {"rrm-range20",1},
    },
    result = "rrm-range30"
	},
    
})