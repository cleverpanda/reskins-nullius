local _framework = { tiers = require("__reskins-framework__.api.tiers") }
local _lib = require("_lib")
local _assets = {
	defines = require("__reskins-assets-api__.api.defines"),
	icons = require("__reskins-assets-api__.api.icons"),
	create_icon = require("__reskins-assets-api__.assets.base.base-icons"),
}

local entities = {
	["nullius-locomotive-1"] = { type = "locomotive", tier = 1, prog_tier = 1 },
	["nullius-locomotive-2"] = { type = "locomotive", tier = 2, prog_tier = 2 },
	["nullius-locomotive-3"] = { type = "locomotive", tier = 3, prog_tier = 3 },
}

for name, options in pairs(entities) do
	local entity = data.raw[options.type][name]
	if not entity then
		goto continue
	end

	local tier = _framework.tiers.get_tier(options)
	local tint = _framework.tiers.get_tint(tier)

	local icon = _assets.create_icon.train_locomotive(tint)
	---@type DeferrableIconData
	local deferrable_icon = {
		name = name,
		type_name = entity.type,
		icon_data = _lib.add_tier_labels_to_icons(tier, icon),
	}

	_assets.icons.assign_deferrable_icon(deferrable_icon)

	::continue::
end

-- Solar locomotive is outside the tier system.
