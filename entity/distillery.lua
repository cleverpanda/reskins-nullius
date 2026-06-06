local _framework = { tiers = require("__reskins-framework__.api.tiers") }

local oil_refinery = require("base.oil-refinery")

local tier_map = {
	["nullius-distillery-1"] = { tier = 1, prog_tier = 1 },
	["nullius-distillery-2"] = { tier = 2, prog_tier = 2 },
	["nullius-distillery-3"] = { tier = 3, prog_tier = 3 },
}

for name, map in pairs(tier_map) do
	local tier = _framework.tiers.get_tier(map)
	oil_refinery(name, tier)
end
