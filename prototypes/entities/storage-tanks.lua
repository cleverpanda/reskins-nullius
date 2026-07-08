local _lib = require("_lib")
local _framework = {
	tiers = require("__reskins-framework__.api.tiers"),
}
local _icons = require("__reskins-sprite-utils__.icons")
local _assets = {
	defines = require("__reskins-assets-api__.api.defines"),
	create_icon = require("__reskins-assets-api__.assets.base.base-icons"),
}

local StorageTankGraphicsPack = require("__reskins-assets-api__.graphics-packs.base.storage-tank-graphics-pack")
local ANGELS_PETRO_GRAPHICS_PATH = "__angelspetrochemgraphics__/graphics/"
-- ============================================================================
-- Medium storage tanks
-- ============================================================================

local medium_tanks = {
	["storage-tank"] = {
		type = "storage-tank",
		tier = 1,
		prog_tier = 1,
	},
	["nullius-medium-tank-2"] = {
		type = "storage-tank",
		tier = 2,
		prog_tier = 2,
	},
	["nullius-medium-tank-3"] = {
		type = "storage-tank",
		tier = 3,
		prog_tier = 3,
	},
}

for name, options in pairs(medium_tanks) do
	local entity = data.raw[options.type] and data.raw[options.type][name]
	if not entity then
		goto continue
	end

	local tier = _framework.tiers.get_tier(options)
	local tint = _framework.tiers.get_tint(tier)

	_lib.create_explosions_and_particles(name, {
		base_entity_name = "storage-tank",
		type = options.type,
		tint = tint,
		particles = {
			["big"] = 1,
		},
	})

	local corpse = _lib.create_remnant(name, {
		base_entity_name = "storage-tank",
		type = options.type,
	})

	local graphics_pack = StorageTankGraphicsPack:configure({
		tint = tint,
		variant = "large",
	})

	graphics_pack:apply_to_entity(entity)
	graphics_pack:apply_to_corpse(corpse)

	local icon = _assets.create_icon.storage_tank(tint)

	icon = _lib.add_tier_labels_to_icons(tier, icon)

	_icons.assign_icons_to_prototype_and_related_prototypes(
		name,
		options.type,
		icon
	)

	::continue::
end


-- ============================================================================
-- Nullius large tanks
-- ============================================================================

local MOD_PATH = "__reskins-nullius__/graphics"

local LARGE_TANK_PATH = MOD_PATH .. "/entity/large-tank/"

local LARGE_TANK_ICON_PATH = MOD_PATH .. "/icons/large-tank/"

local large_tanks = {
	["nullius-large-tank-1"] = {
		type = "storage-tank",
		tier = 2,
		prog_tier = 2,
		--nullius_tint = util.color("#877c76")--{0.85, 0.9, 1} --pipe_material_tints[_assets.defines.pipe_material.aluminum]
	},
	["nullius-large-tank-2"] = {
		type = "storage-tank",
		tier = 3,
		prog_tier = 3,
		--nullius_tint = util.color("#877c76") --pipe_material_tints[_assets.defines.pipe_material.plastic]
	},
	["nullius-large-tank-3"] = {
		type = "storage-tank",
		tier = 4,
		prog_tier = 4,
		--nullius_tint = util.color("#877c76") --pipe_material_tints[_assets.defines.pipe_material.tungsten]tint = {0.85, 0.9, 1},tint = {0.8, 0.8, 0.4}tint = {0.7, 0.7, 0.85}
	},
}

local function make_large_tank_sheets(tint)
	return {
		{
			filename = LARGE_TANK_PATH .. "large-tank-base.png",
			priority = "extra-high",
			frames = 1,
			width = 334,
			height = 387,
			shift = util.by_pixel(-0.5, -6),
			scale = 0.5,
		},

		-- Mask 1 uses Nullius tint
		{
			filename = LARGE_TANK_PATH .. "large-tank-mask.png",
			priority = "extra-high",
			frames = 1,
			width = 334,
			height = 387,
			shift = util.by_pixel(-0.5, -6),
			tint = tint,
			scale = 0.5,
		},

		{
			filename = LARGE_TANK_PATH .. "large-tank-highlights.png",
			priority = "extra-high",
			frames = 1,
			width = 334,
			height = 387,
			shift = util.by_pixel(-0.5, -6),
			blend_mode = "additive",
			scale = 0.5,
		},

		{
			filename = ANGELS_PETRO_GRAPHICS_PATH .. "entity/petrochem-gas-tank/petrochem-gas-tank-shadow.png",
			priority = "extra-high",
			frames = 1,
			width = 437,
			height = 237,
			shift = util.by_pixel(26, 32),
			draw_as_shadow = true,
			scale = 0.5,
		},
	}
end

local function make_large_tank_icon(tint)
	return {
		-- Neutralized icon base
		{
			icon = LARGE_TANK_ICON_PATH .. "large-tank-base.png",
			icon_size = 64,
			mipmap_count = 4
		},

		-- Mask 1 uses Nullius tint
		{
			icon = LARGE_TANK_ICON_PATH .. "large-tank-mask.png",
			icon_size = 64,
			tint = tint,
			mipmap_count = 4
		}
	}
end

for name, options in pairs(large_tanks) do
	local entity =
		data.raw[options.type]
		and data.raw[options.type][name]


	if not entity then
		goto continue
	end

	local tier = _framework.tiers.get_tier(options)
	local tint = _framework.tiers.get_tint(tier)

	_lib.create_explosions_and_particles(name, {
		base_entity_name = "storage-tank",
		type = options.type,
		tint = tint,
		particles = {
			["big"] = 1,
		},
	})

	entity.pictures.picture = {
		sheets = make_large_tank_sheets(tint),
	}

	local icon =
		_lib.add_tier_labels_to_icons(
			tier,
			make_large_tank_icon(tint)
		)

	_icons.assign_icons_to_prototype_and_related_prototypes(
		name,
		options.type,
		icon
	)

	::continue::
end

-- ============================================================================
-- Nullius small tanks
-- ============================================================================

local SMALL_TANK_PATH = MOD_PATH .. "/entity/small-tank/"

local SMALL_TANK_ICON_PATH = MOD_PATH .. "/icons/small-tank/"

local small_tanks = {
	["nullius-small-tank-1"] = {
		type = "storage-tank",
		tier = 2,
		prog_tier = 2,
	},
	["nullius-small-tank-2"] = {
		type = "storage-tank",
		tier = 3,
		prog_tier = 3,
	},
}


-- Each entry matches one visible section of the original Angel's sprite sheet.
local small_tank_geometry = {
	north = {
		{
			x = 0,
			y = 0,
			width = 142,
			height = 199,
			shift = { 0, -0.24 },
		},
		{
			x = 142,
			y = 117,
			width = 29,
			height = 62,
			shift = { -0.88, 0.52 },
		},
		{
			x = 171,
			y = 141,
			width = 11,
			height = 38,
			shift = { -0.57, 0.705 },
		},
	},

	east = {
		{
			x = 142,
			y = 0,
			width = 142,
			height = 199,
			shift = { 0, -0.24 },
		},
	},

	south = {
		{
			x = 284,
			y = 0,
			width = 142,
			height = 199,
			shift = { 0, -0.24 },
		},
		{
			x = 559,
			y = 48,
			width = 9,
			height = 62,
			shift = { 1, -0.58 },
		},
	},

	west = {
		{
			x = 426,
			y = 0,
			width = 142,
			height = 199,
			shift = { 0, -0.24 },
		},
		{
			x = 74,
			y = 136,
			width = 62,
			height = 63,
			shift = { 0.55, 0.82 },
		},
	},
}

local small_tank_shadow_geometry = {
	north = {
		x = 0,
		width = 207,
		height = 199,
		shift = { 0.52, 0.28 },
	},
	east = {
		x = 207,
		width = 207,
		height = 199,
		shift = { 0.52, 0.28 },
	},
	south = {
		x = 414,
		width = 207,
		height = 199,
		shift = { 0.52, 0.28 },
	},
	west = {
		x = 621,
		width = 207,
		height = 199,
		shift = { 0.52, 0.28 },
	},
}


local function make_small_tank_layer(filename, geometry, tint, blend_mode)
	local layer = {
		filename = filename,
		priority = "extra-high",
		x = geometry.x,
		y = geometry.y or 0,
		width = geometry.width,
		height = geometry.height,
		scale = 0.5,
		shift = geometry.shift,
	}

	if tint then
		layer.tint = tint
	end

	if blend_mode then
		layer.blend_mode = blend_mode
	end

	return layer
end


local function make_small_tank_direction(direction, tint)
	local layers = {}

	for _, geometry in ipairs(small_tank_geometry[direction]) do
		-- Neutralized base
		layers[#layers + 1] = make_small_tank_layer(
			ANGELS_PETRO_GRAPHICS_PATH .. "entity/petrochem-inline-tank/petrochem-inline-tank.png",
			geometry
		)

		-- Main Reskins tier mask
		layers[#layers + 1] = make_small_tank_layer(
			SMALL_TANK_PATH .. "small-tank-mask.png",
			geometry,
			tint
		)

		layers[#layers + 1] = make_small_tank_layer(
			SMALL_TANK_PATH .. "small-tank-highlights.png",
			geometry,
			nil,
			"additive"
		)

	end

	local shadow = small_tank_shadow_geometry[direction]

	layers[#layers + 1] = {
		filename = ANGELS_PETRO_GRAPHICS_PATH .. "entity/petrochem-inline-tank/petrochem-inline-tank-shadow.png",
		priority = "extra-high",
		x = shadow.x,
		y = 0,
		width = shadow.width,
		height = shadow.height,
		shift = shadow.shift,
		draw_as_shadow = true,
		scale = 0.5,
	}

	return {
		layers = layers,
	}
end


local function make_small_tank_pictures(tint)
	return {
		picture = {
			north = make_small_tank_direction( "north", tint),
			east = make_small_tank_direction("east", tint),
			south = make_small_tank_direction("south", tint),
			west = make_small_tank_direction("west", tint),
		},

		fluid_background = {
			filename = ANGELS_PETRO_GRAPHICS_PATH .. "entity/electrolyser/blank.png",
			priority = "extra-high",
			width = 1,
			height = 1,
		},

		window_background = {
			filename = ANGELS_PETRO_GRAPHICS_PATH .. "entity/electrolyser/blank.png",
			priority = "extra-high",
			width = 1,
			height = 1,
		},

		flow_sprite = {
			filename = ANGELS_PETRO_GRAPHICS_PATH .. "entity/electrolyser/blank.png",
			priority = "extra-high",
			width = 1,
			height = 1,
		},

		gas_flow = {
			filename = ANGELS_PETRO_GRAPHICS_PATH .. "entity/electrolyser/blank.png",
			priority = "extra-high",
			width = 1,
			height = 1,
			frame_count = 1,
			animation_speed = 0.25,
		},
	}
end


local function make_small_tank_icon(tint)
	return {
		{
			icon = ANGELS_PETRO_GRAPHICS_PATH .. "icons/petrochem-inline-tank.png",
			icon_size = 64,
		},
		{
			icon = SMALL_TANK_ICON_PATH .. "small-tank-mask.png",
			icon_size = 64,
			tint = tint,
		}
	}
end


for name, options in pairs(small_tanks) do
	local entity =
		data.raw[options.type]
		and data.raw[options.type][name]


	if not entity then
		goto continue
	end

	local tier = _framework.tiers.get_tier(options)
	local tint = _framework.tiers.get_tint(tier)

	_lib.create_explosions_and_particles(name, {
		base_entity_name = "storage-tank",
		type = options.type,
		tint = tint,
		particles = {
			["medium"] = 1,
		},
	})

	entity.pictures = make_small_tank_pictures(tint)

	local icon =
		_lib.add_tier_labels_to_icons(
			tier,
			make_small_tank_icon(tint)
		)

	_icons.assign_icons_to_prototype_and_related_prototypes(
		name,
		options.type,
		icon
	)

	::continue::
end
