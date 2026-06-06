---@type ConstructIconInputsOld
local inputs = {
	type = "assembling-machine",
	icon_name = "thermal-extractor",
	mod = "angels",
	group = "refining",
}

-- Setup defaults.
reskins.lib.set_inputs_defaults(inputs)

local tier_map = {
	["nullius-compressor-1"] = { tier = 1, prog_tier = 1 },
	["nullius-compressor-2"] = { tier = 2, prog_tier = 2 },
	["nullius-compressor-3"] = { tier = 3, prog_tier = 3 },
}

for name, map in pairs(tier_map) do
	local tier = reskins.lib.tiers.get_tier(map)
	inputs.tint = map.tint or reskins.lib.tiers.get_tint(tier)

	reskins.lib.construct_icon(name, tier, inputs)
end
