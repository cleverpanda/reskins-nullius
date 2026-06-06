local _framework = { tiers = require("__reskins-framework__.api.tiers") }

local boiler = require("base.boiler")

local tier_map = {
	["nullius-boiler-1"] = { tier = 1, prog_tier = 4 },
	["nullius-boiler-2"] = { tier = 2, prog_tier = 5 },
}

for name, map in pairs(tier_map) do
	local tier = _framework.tiers.get_tier(map)
	boiler(name, tier)
end
