local _lib = require("_lib")
local _framework = {
	tiers = require("__reskins-framework__.api.tiers"),
}
local _assets = {
	defines = require("__reskins-assets-api__.api.defines"),
	icons = require("__reskins-assets-api__.api.icons"),
	create_icon = require("__reskins-assets-api__.assets.base.base-icons"),
}

local StorageTankGraphicsPack =
	require("__reskins-assets-api__.graphics-packs.base.storage-tank-graphics-pack")

local pipe_material_tints = {
	[_assets.defines.pipe_material.aluminum] = util.color("#ffffff"),
	[_assets.defines.pipe_material.copper] = util.color("#d45539"),
	[_assets.defines.pipe_material.stone] = util.color("#cfcfcf"),
	[_assets.defines.pipe_material.bronze] = util.color("#b09954"),
	[_assets.defines.pipe_material.steel] = util.color("#877c76"),
	[_assets.defines.pipe_material.plastic] = util.color("#0078ff"),
	[_assets.defines.pipe_material.brass] = util.color("#f9c854"),
	[_assets.defines.pipe_material.titanium] = util.color("#adadb2"),
	[_assets.defines.pipe_material.ceramic] = util.color("#8f7967"),
	[_assets.defines.pipe_material.tungsten] = util.color("#3b3b3b"),
	[_assets.defines.pipe_material.nitinol] = util.color("#706f6b"),
	[_assets.defines.pipe_material.copper_tungsten] = util.color("#99593d"),
	[_assets.defines.pipe_material.titanium_angels] = util.color("#995f92"),
	[_assets.defines.pipe_material.ceramic_angels] = util.color("#ffffff"),
	[_assets.defines.pipe_material.tungsten_angels] = util.color("#7e5f45"),
	[_assets.defines.pipe_material.nitinol_angels] = util.color("#7664a9"),
}
	
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

	---@type DeferrableIconData
	local deferrable_icon = {
		name = name,
		type_name = options.type,
		icon_data = _framework.tiers.add_tier_labels_to_icons(tier, icon),
	}

	_assets.icons.assign_deferrable_icon(deferrable_icon)

	::continue::
end


-- ============================================================================
-- Nullius large tanks
-- ============================================================================

local MOD_PATH = "__reskins-nullius__"

local LARGE_TANK_PATH =
	MOD_PATH .. "/graphics/entity/large_tank/"

local LARGE_TANK_ICON_PATH =
	MOD_PATH .. "/graphics/icons/large_tank/"

local large_tanks = {
	["nullius-large-tank-1"] = {
		type = "storage-tank",
		tier = 2,
		prog_tier = 2,
		nullius_tint = util.color("#D9E6FF")--{0.85, 0.9, 1} --pipe_material_tints[_assets.defines.pipe_material.aluminum]
	},
	["nullius-large-tank-2"] = {
		type = "storage-tank",
		tier = 3,
		prog_tier = 3,
		nullius_tint = util.color("#B3B3D9") --pipe_material_tints[_assets.defines.pipe_material.plastic]
	},
	["nullius-large-tank-3"] = {
		type = "storage-tank",
		tier = 4,
		prog_tier = 4,
		nullius_tint = util.color("#6D6D6D") --pipe_material_tints[_assets.defines.pipe_material.tungsten]tint = {0.85, 0.9, 1},tint = {0.8, 0.8, 0.4}tint = {0.7, 0.7, 0.85}
	},
}

local function make_large_tank_sheets(tint, nullius_tint)
	return {
		{
			filename =
				"__angelspetrochemgraphics__/graphics/entity/"
				.. "petrochem-gas-tank/petrochem-gas-tank.png",
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
			tint = nullius_tint,
			scale = 0.5,
		},

		-- Mask 2 uses Reskins tier tint
		{
			filename = LARGE_TANK_PATH .. "large-tank-mask-2.png",
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
			filename =
				"__angelspetrochemgraphics__/graphics/entity/"
				.. "petrochem-gas-tank/petrochem-gas-tank-shadow.png",
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

local function make_large_tank_icon(tint, nullius_tint)
	return {
		-- Neutralized icon base
		{
			icon = "__angelspetrochemgraphics__/graphics/icons/"
				.. "/petrochem-gas-tank.png",
			icon_size = 64,
			mipmap_count = 4
		},

		-- Main Reskins tier-color mask
		{
			icon = LARGE_TANK_ICON_PATH .. "large-tank-mask.png",
			icon_size = 64,
			tint = tint,
			mipmap_count = 4
		},

		-- Secondary Nullius tint mask
		{
			icon = LARGE_TANK_ICON_PATH .. "large-tank-mask-2.png",
			icon_size = 64,
			tint = nullius_tint,
			mipmap_count = 4
		}
	}
end

for name, options in pairs(large_tanks) do
	local entity =
		data.raw[options.type]
		and data.raw[options.type][name]

	local item =
		data.raw.item
		and data.raw.item[name]

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
		sheets = make_large_tank_sheets(
			tint,
			options.nullius_tint
		),
	}

	local icon =
		_framework.tiers.add_tier_labels_to_icons(
			tier,
			make_large_tank_icon(
				tint,
				options.nullius_tint
			)
		)

	-- Storage-tank entity icon
	_assets.icons.assign_deferrable_icon({
		name = name,
		type_name = options.type,
		icon_data = table.deepcopy(icon),
	})

	-- Corresponding placeable item icon
	if item then
		_assets.icons.assign_deferrable_icon({
			name = name,
			type_name = "item",
			icon_data = table.deepcopy(icon),
		})
	end

	::continue::
end

-- ============================================================================
-- Nullius small tanks
-- ============================================================================

local SMALL_TANK_PATH =
	MOD_PATH .. "/graphics/entity/small-tank/"

local SMALL_TANK_ICON_PATH =
	MOD_PATH .. "/graphics/icons/small-tank/"

local small_tanks = {
	["nullius-small-tank-1"] = {
		type = "storage-tank",
		tier = 2,
		prog_tier = 2,
		nullius_tint = util.color("#D9E6FF") --pipe_material_tints[_assets.defines.pipe_material.aluminum],
	},
	["nullius-small-tank-2"] = {
		type = "storage-tank",
		tier = 3,
		prog_tier = 3,
		nullius_tint = util.color("#B3B3D9") --pipe_material_tints[_assets.defines.pipe_material.plastic],
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


local function make_small_tank_direction(direction, tint, nullius_tint)
	local layers = {}

	for _, geometry in ipairs(small_tank_geometry[direction]) do
		-- Neutralized base
		layers[#layers + 1] = make_small_tank_layer(
			"__angelspetrochemgraphics__/graphics/entity/petrochem-inline-tank/petrochem-inline-tank.png",
			geometry
		)

		-- Main Reskins tier mask
		layers[#layers + 1] = make_small_tank_layer(
			SMALL_TANK_PATH .. "small-tank-mask.png",
			geometry,
			tint
		)
		layers[#layers + 1] = make_small_tank_layer(
			SMALL_TANK_PATH .. "small-tank-mask-2.png",
			geometry,
			nullius_tint
		)
	end

	local shadow = small_tank_shadow_geometry[direction]

	layers[#layers + 1] = {
		filename =
			"__angelspetrochemgraphics__/graphics/entity/petrochem-inline-tank/petrochem-inline-tank-shadow.png",
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


local function make_small_tank_pictures(tint, nullius_tint)
	return {
		picture = {
			north = make_small_tank_direction(
				"north",
				tint,
				nullius_tint
			),
			east = make_small_tank_direction(
				"east",
				tint,
				nullius_tint
			),
			south = make_small_tank_direction(
				"south",
				tint,
				nullius_tint
			),
			west = make_small_tank_direction(
				"west",
				tint,
				nullius_tint
			),
		},

		fluid_background = {
			filename =
				"__angelspetrochemgraphics__/graphics/entity/"
				.. "electrolyser/blank.png",
			priority = "extra-high",
			width = 1,
			height = 1,
		},

		window_background = {
			filename =
				"__angelspetrochemgraphics__/graphics/entity/"
				.. "electrolyser/blank.png",
			priority = "extra-high",
			width = 1,
			height = 1,
		},

		flow_sprite = {
			filename =
				"__angelspetrochemgraphics__/graphics/entity/"
				.. "electrolyser/blank.png",
			priority = "extra-high",
			width = 1,
			height = 1,
		},

		gas_flow = {
			filename =
				"__angelspetrochemgraphics__/graphics/entity/"
				.. "electrolyser/blank.png",
			priority = "extra-high",
			width = 1,
			height = 1,
			frame_count = 1,
			animation_speed = 0.25,
		},
	}
end


local function make_small_tank_icon(tint, nullius_tint)
	return {
		{
			icon = "__angelspetrochemgraphics__/graphics/icons/petrochem-inline-tank.png",
			icon_size = 64,
		},
		{
			icon = SMALL_TANK_ICON_PATH .. "small-tank-mask.png",
			icon_size = 64,
			tint = tint,
		},
		{
			icon = SMALL_TANK_ICON_PATH .. "small-tank-mask-2.png",
			icon_size = 64,
			tint = nullius_tint,
		}
	}
end


for name, options in pairs(small_tanks) do
	local entity =
		data.raw[options.type]
		and data.raw[options.type][name]

	local item =
		data.raw.item
		and data.raw.item[name]

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

	entity.pictures = make_small_tank_pictures(
		tint,
		options.nullius_tint
	)

	local icon =
		_framework.tiers.add_tier_labels_to_icons(
			tier,
			make_small_tank_icon(
				tint,
				options.nullius_tint
			)
		)

	-- Storage-tank prototype icon
	_assets.icons.assign_deferrable_icon({
		name = name,
		type_name = options.type,
		icon_data = table.deepcopy(icon),
	})

	-- Placeable item icon
	if item then
		_assets.icons.assign_deferrable_icon({
			name = name,
			type_name = "item",
			icon_data = table.deepcopy(icon),
		})
	end

	-- Normal recipe icon
	if data.raw.recipe and data.raw.recipe[name] then
		_assets.icons.assign_deferrable_icon({
			name = name,
			type_name = "recipe",
			icon_data = table.deepcopy(icon),
		})
	end

	::continue::
end