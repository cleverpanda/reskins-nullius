local _framework = { tiers = require("__reskins-framework__.api.tiers") }

local chemical_plant = require("base.chemical-plant")

local tier_map = {
	["nullius-chemical-plant-1"] = { tier = 1, prog_tier = 1 },
	["nullius-chemical-plant-2"] = { tier = 2, prog_tier = 2 },
	["nullius-chemical-plant-3"] = { tier = 3, prog_tier = 3 },
}

for name, map in pairs(tier_map) do
	local tier = _framework.tiers.get_tier(map)
	chemical_plant(name, tier)
end
