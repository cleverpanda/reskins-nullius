local _sprites = require("__reskins-sprite-utils__.sprites")
local _framework = { tiers = require("__reskins-framework__.api.tiers") }
local _lib = require("_lib")

local function pipe_overlay(material, direction, width, height, shift)
	if material == "base" then
		return {
			filename = "__core__/graphics/empty.png",
			priority = "extra-high",
			width = 1,
			height = 1,
		}
	end

	return {
		filename = "__reskins-assets-bobs__/graphics/entity/heat-exchanger/heat-pipes/"
			.. material
			.. "/heat-pipe-"
			.. direction
			.. "-idle.png",
		priority = "extra-high",
		width = width,
		height = height,
		shift = shift,
		scale = 0.5,
	}
end

---@param tint data.Color
---@return table animation # [Types/Animation4Way](https://wiki.factorio.com/Types/Animation4Way)
local function entity_animation(tint, material)
	return {
		north = {
			layers = {
				{
					filename = "__base__/graphics/entity/heat-exchanger/heatex-N-idle.png",
					priority = "extra-high",
					width = 269,
					height = 221,
					shift = util.by_pixel(-1.25, 5.25),
					scale = 0.5,
				},
				{
					filename = "__reskins-assets-base__/graphics/entity/heat-exchanger/heat-exchanger-north-idle-mask.png",
					priority = "extra-high",
					width = 269,
					height = 221,
					shift = util.by_pixel(-1.25, 5.25),
					tint = tint,
					scale = 0.5,
				},
				{
					filename = "__reskins-assets-base__/graphics/entity/heat-exchanger/heat-exchanger-north-idle-highlights.png",
					priority = "extra-high",
					width = 269,
					height = 221,
					shift = util.by_pixel(-1.25, 5.25),
					blend_mode = "additive-soft",
					scale = 0.5,
				},
				pipe_overlay(material, "north", 269, 221, util.by_pixel(-1.25, 5.25)),
				{
					filename = "__base__/graphics/entity/boiler/boiler-N-shadow.png",
					priority = "extra-high",
					width = 274,
					height = 164,
					scale = 0.5,
					shift = util.by_pixel(20.5, 9),
					draw_as_shadow = true,
				},
			},
		},
		east = {
			layers = {
				{
					filename = "__base__/graphics/entity/heat-exchanger/heatex-E-idle.png",
					priority = "extra-high",
					width = 211,
					height = 301,
					shift = util.by_pixel(-1.75, 1.25),
					scale = 0.5,
				},
				{
					filename = "__reskins-assets-base__/graphics/entity/heat-exchanger/heat-exchanger-east-idle-mask.png",
					priority = "extra-high",
					width = 211,
					height = 301,
					shift = util.by_pixel(-1.75, 1.25),
					tint = tint,
					scale = 0.5,
				},
				{
					filename = "__reskins-assets-base__/graphics/entity/heat-exchanger/heat-exchanger-east-idle-highlights.png",
					priority = "extra-high",
					width = 211,
					height = 301,
					shift = util.by_pixel(-1.75, 1.25),
					blend_mode = "additive-soft",
					scale = 0.5,
				},
				pipe_overlay(material, "east", 211, 301, util.by_pixel(-1.75, 1.25)),
				{
					filename = "__base__/graphics/entity/boiler/boiler-E-shadow.png",
					priority = "extra-high",
					width = 184,
					height = 194,
					scale = 0.5,
					shift = util.by_pixel(30, 9.5),
					draw_as_shadow = true,
				},
			},
		},
		south = {
			layers = {
				{
					filename = "__base__/graphics/entity/heat-exchanger/heatex-S-idle.png",
					priority = "extra-high",
					width = 260,
					height = 201,
					shift = util.by_pixel(4, 10.75),
					scale = 0.5,
				},
				{
					filename = "__reskins-assets-base__/graphics/entity/heat-exchanger/heat-exchanger-south-idle-mask.png",
					priority = "extra-high",
					width = 260,
					height = 201,
					shift = util.by_pixel(4, 10.75),
					tint = tint,
					scale = 0.5,
				},
				{
					filename = "__reskins-assets-base__/graphics/entity/heat-exchanger/heat-exchanger-south-idle-highlights.png",
					priority = "extra-high",
					width = 260,
					height = 201,
					shift = util.by_pixel(4, 10.75),
					blend_mode = "additive-soft",
					scale = 0.5,
				},
				pipe_overlay(material, "south", 260, 201, util.by_pixel(4, 10.75)),
				{
					filename = "__base__/graphics/entity/boiler/boiler-S-shadow.png",
					priority = "extra-high",
					width = 311,
					height = 131,
					scale = 0.5,
					shift = util.by_pixel(29.75, 15.75),
					draw_as_shadow = true,
				},
			},
		},
		west = {
			layers = {
				{
					filename = "__base__/graphics/entity/heat-exchanger/heatex-W-idle.png",
					priority = "extra-high",
					width = 196,
					height = 273,
					shift = util.by_pixel(1.5, 7.75),
					scale = 0.5,
				},
				{
					filename = "__reskins-assets-base__/graphics/entity/heat-exchanger/heat-exchanger-west-idle-mask.png",
					priority = "extra-high",
					width = 196,
					height = 273,
					shift = util.by_pixel(1.5, 7.75),
					tint = tint,
					scale = 0.5,
				},
				{
					filename = "__reskins-assets-base__/graphics/entity/heat-exchanger/heat-exchanger-west-idle-highlights.png",
					priority = "extra-high",
					width = 196,
					height = 273,
					shift = util.by_pixel(1.5, 7.75),
					blend_mode = "additive-soft",
					scale = 0.5,
				},
				pipe_overlay(material, "west", 196, 273, util.by_pixel(1.5, 7.75)),
				{
					filename = "__base__/graphics/entity/boiler/boiler-W-shadow.png",
					priority = "extra-high",
					width = 206,
					height = 218,
					scale = 0.5,
					shift = util.by_pixel(19.5, 6.5),
					draw_as_shadow = true,
				},
			},
		},
	}
end

---@param tint data.Color
---@return data.RotatedAnimationVariations
local function corpse_animation(tint, material)
	---@type data.RotatedAnimation
	local animation = {
		layers = {
			-- Base
			{
				filename = "__base__/graphics/entity/heat-exchanger/remnants/heat-exchanger-remnants.png",
				line_length = 1,
				width = 272,
				height = 262,
				direction_count = 4,
				shift = util.by_pixel(0.5, 8),
				scale = 0.5,
			},
			-- Mask
			{
				filename = "__reskins-assets-base__/graphics/entity/heat-exchanger/remnants/heat-exchanger-remnants-mask.png",
				line_length = 1,
				width = 272,
				height = 262,
				direction_count = 4,
				shift = util.by_pixel(0.5, 8),
				tint = tint,
				scale = 0.5,
			},
			-- Highlights
			{
				filename = "__reskins-assets-base__/graphics/entity/heat-exchanger/remnants/heat-exchanger-remnants-highlights.png",
				line_length = 1,
				width = 272,
				height = 262,
				direction_count = 4,
				shift = util.by_pixel(0.5, 8),
				blend_mode = "additive-soft",
				scale = 0.5,
			},
		},
	}

	if material ~= "base" then
		table.insert(animation.layers, {
			filename = "__reskins-assets-bobs__/graphics/entity/heat-exchanger/heat-pipes/"
				.. material
				.. "/heat-pipe-remnants-base.png",
			line_length = 1,
			width = 272,
			height = 262,
			direction_count = 4,
			shift = util.by_pixel(0.5, 8),
			scale = 0.5,
		})
	end

	return _sprites.make_rotated_animation_variations_from_spritesheet(1, animation)
end

---@param name string # [Prototype name](https://wiki.factorio.com/PrototypeBase#name)
---@param tier integer # 1-6 are supported, 0 to disable
---@param tint? data.Color
---@param make_tier_labels? boolean
---@param material? string
return function(name, tier, tint, make_tier_labels, material)
	material = material or "base"

	---@type SetupStandardEntityInputs
	local inputs = {
		type = "assembling-machine",
		icon_name = "heat-exchanger",
		icon_base = "heat-exchanger-" .. material,
		base_entity_name = "heat-exchanger",
		graphics_mod = "assets-bobs",
		particles = { ["big"] = 2, ["medium"] = 1 },
		tier_labels = make_tier_labels,
		tint = tint and tint or _framework.tiers.get_tint(tier),
	}

	---@type data.AssemblingMachinePrototype
	local entity = data.raw[inputs.type][name]
	if not entity then
		return
	end

	_lib.setup_standard_entity(name, tier, inputs)

	-- Fetch corpse
	local corpse = data.raw["corpse"][entity.corpse]

	-- Reskin corpse
	corpse.animation = corpse_animation(inputs.tint, material)

	-- Reskin entity
	entity.graphics_set.animation = entity_animation(inputs.tint, material)

	if entity.energy_source and material ~= "base" then
		entity.energy_source.pipe_covers = _sprites.make_4way_animation_from_spritesheet({
			filename = "__reskins-assets-bobs__/graphics/entity/heat-exchanger/heat-pipes/"
				.. material
				.. "/heat-pipe-endings.png",
			width = 64,
			height = 64,
			direction_count = 4,
			scale = 0.5,
		})
	end
end
