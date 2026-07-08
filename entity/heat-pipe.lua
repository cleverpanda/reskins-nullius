-- Copyright (c) 2026 Kirazy
-- Part of Artisanal Reskins: Nullius
--
-- See LICENSE in the project directory for license information.

local _lib = require("_lib")

local reskins = {
	lib = {
		icons = require("__reskins-sprite-utils__.icons"),
		sprites = require("__reskins-sprite-utils__.sprites"),
		tiers = require("__reskins-framework__.api.tiers"),
	},
}

local function make_heat_pipe_pictures(path, name_prefix, data)
	local all_pictures = {}
	for key, t in pairs(data) do
		if t.empty then
			all_pictures[key] = { priority = "extra-high", filename = "__core__/graphics/empty.png", width = 1, height = 1 }
		else
			local tile_pictures = {}
			for i = 1, (t.variations or 1) do
				local sprite = {
					priority = "extra-high",
					filename = path
						.. name_prefix
						.. "-"
						.. (t.name or string.gsub(key, "_", "-"))
						.. (t.omit_number and ".png" or ("-" .. tostring(i) .. ".png")),
					width = (t.width or 32) * 2,
					height = (t.height or 32) * 2,
					scale = 0.5,
					shift = t.shift,
				}
				table.insert(tile_pictures, sprite)
			end
			all_pictures[key] = tile_pictures
		end
	end
	return all_pictures
end

-- Set input parameters
local inputs = {
	type = "heat-pipe",
	base_entity_name = "heat-pipe",
	mod = "assets-bobs",
}

local tier_map = {
	["nullius-heat-pipe-1"] = {
		tier = 1,
		prog_tier = 1,
		material = "silver-aluminum",
		particle_colors = { "d4d4d4", "cfd2d4" },
	},
	["nullius-heat-pipe-2"] = {
		tier = 2,
		prog_tier = 2,
		material = "base",
		icon = "__base__/graphics/icons/heat-pipe.png",
	},
	["nullius-heat-pipe-3"] = {
		tier = 3,
		prog_tier = 3,
		material = "gold-copper",
		particle_colors = { "d6b968", "ff7f3f" },
	},
}

-- Reskin entities, create and assign extra details
for name, map in pairs(tier_map) do
	---@type data.HeatPipePrototype
	local entity = data.raw[inputs.type][name]
	if not entity then
		goto continue
	end

	local tier = reskins.lib.tiers.get_tier(map)

	-- Setup icons
	---@type data.IconData[]
	local icon_data = { {
		icon = map.icon or "__reskins-assets-bobs__/graphics/icons/heat-pipe/heat-pipe-" .. map.material .. "-icon-base.png",
		icon_size = 64,
		scale = 0.5,
	} }

	---@type DeferrableIconData
	local deferrable_icon = {
		name = name,
		type_name = "heat-pipe",
		icon_data = _lib.add_tier_labels_to_icons(tier, icon_data) or icon_data,
		pictures = reskins.lib.sprites.create_sprite_from_icons(icon_data, 1.0) or nil,
	}

	reskins.lib.icons.assign_deferrable_icon(deferrable_icon)

	-- Reskin entities
	if map.material == "base" then
		entity.connection_sprites = data.raw["heat-pipe"]["heat-pipe"].connection_sprites
		entity.heat_glow_sprites = data.raw["heat-pipe"]["heat-pipe"].heat_glow_sprites
		goto continue
	end

	-- Create particles and explosions
	_lib.create_explosions_and_particles(name, {
		base_entity_name = inputs.base_entity_name,
		type = inputs.type,
		tint = util.color(map.particle_colors[1]),
		particles = {
			["small"] = 1,
			["medium"] = 2,
		},
	})

	-- Create and skin remnants
	local remnant = _lib.create_remnant(name, inputs)
	remnant.animation = make_rotated_animation_variations_from_sheet(6, {
		filename = "__reskins-assets-bobs__/graphics/entity/heat-pipe/" .. map.material .. "/remnants/heat-pipe-remnants.png",
		width = 122,
		height = 100,
		direction_count = 2,
		shift = util.by_pixel(0.5, -1.5),
		scale = 0.5,
	})

	entity.connection_sprites = make_heat_pipe_pictures(
		"__reskins-assets-bobs__/graphics/entity/heat-pipe/" .. map.material .. "/",
		"heat-pipe",
		{
			single = { name = "straight-vertical-single", omit_number = true },
			straight_vertical = { variations = 6 },
			straight_horizontal = { variations = 6 },
			corner_right_up = { name = "corner-up-right", variations = 6 },
			corner_left_up = { name = "corner-up-left", variations = 6 },
			corner_right_down = { name = "corner-down-right", variations = 6 },
			corner_left_down = { name = "corner-down-left", variations = 6 },
			t_up = {},
			t_down = {},
			t_right = {},
			t_left = {},
			cross = { name = "t" },
			ending_up = {},
			ending_down = {},
			ending_right = {},
			ending_left = {},
		}
	)
	entity.heat_glow_sprites = data.raw["heat-pipe"]["heat-pipe"].heat_glow_sprites

	::continue::
end
