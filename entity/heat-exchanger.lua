local _framework = { tiers = require("__reskins-framework__.api.tiers") }

local heat_exchanger = require("base.heat-exchanger")

local tier_map = {
	["nullius-heat-exchanger-1"] = { tier = 1, prog_tier = 1, material = "silver-aluminum" },
	["nullius-heat-exchanger-2"] = { tier = 2, prog_tier = 2, material = "base" },
	["nullius-heat-exchanger-3"] = { tier = 3, prog_tier = 3, material = "gold-copper" },
}

for name, map in pairs(tier_map) do
	local tier = _framework.tiers.get_tier(map)
	heat_exchanger(name, tier, nil, nil, map.material)
end
