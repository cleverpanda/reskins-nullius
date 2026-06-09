-- cspell: words togglable
local _lib = require("_lib")
local _framework = { tiers = require("__reskins-framework__.api.tiers") }
local _assets = {
	defines = require("__reskins-assets-api__.api.defines"),
	icons = require("__reskins-assets-api__.api.icons"),
	create_icon = require("__reskins-assets-api__.assets.base.base-icons"),
}

local PumpGraphicsPack = require("__reskins-assets-api__.graphics-packs.base.pump-graphics-pack")

local entities = {
	["nullius-pump-1"] = {
		type = "pump",
		tier = 1,
		prog_tier = 1,
	},
	["nullius-pump-2"] = {
		type = "pump",
		tier = 2,
		prog_tier = 2,
	},
	["pump"] = {
		type = "pump",
		tier = 3,
		prog_tier = 3,
	},
	["nullius-togglable-pump-1"] = {
		type = "pump",
		tier = 1,
		prog_tier = 1,
	},
	["nullius-togglable-pump-2"] = {
		type = "pump",
		tier = 2,
		prog_tier = 2,
	},
	["nullius-togglable-pump-3"] = {
		type = "pump",
		tier = 3,
		prog_tier = 3,
	},
}

for name, options in pairs(entities) do
	local entity = data.raw[options.type][name]
	if not entity then
		goto continue
	end

	local tier = _framework.tiers.get_tier(options)
	local tint = _framework.tiers.get_tint(tier)

	_lib.create_explosions_and_particles(name, {
		base_entity_name = "pump",
		type = "pump",
		tint = tint,
		particles = {
			["medium"] = 2,
		},
	})

	local corpse = _lib.create_remnant(name, {
		base_entity_name = "pump",
		type = "pump",
	})

	local graphics_pack = PumpGraphicsPack:configure({
		tint = tint,
	})

	graphics_pack:apply_to_entity(entity)
	graphics_pack:apply_to_corpse(corpse)

	local icon = _assets.create_icon.pump(tint)
	---@type DeferrableIconData
	local deferrable_icon = {
		name = name,
		type_name = options.type,
		icon_data = _framework.tiers.add_tier_labels_to_icons(tier, icon),
	}

	_assets.icons.assign_deferrable_icon(deferrable_icon)

	::continue::
end
