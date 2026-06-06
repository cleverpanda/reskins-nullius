local _framework = { tiers = require("__reskins-framework__.api.tiers") }

local boiler = require("base.boiler")

local tier_map = {
	["nullius-combustion-chamber-1"] = { tier = 1, prog_tier = 1 },
	["nullius-combustion-chamber-2"] = { tier = 2, prog_tier = 2 },
	["nullius-combustion-chamber-3"] = { tier = 3, prog_tier = 3 },
}

for name, map in pairs(tier_map) do
	local tier = _framework.tiers.get_tier(map)
	boiler(name, tier)
end
