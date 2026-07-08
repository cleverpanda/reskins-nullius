local _lib = require("_lib")

local do_entities = _lib.is_scope_enabled("entities")
local do_equipment = _lib.is_scope_enabled("equipment")
local do_items = _lib.is_scope_enabled("items-and-fluids")
local do_technologies = _lib.is_scope_enabled("technologies")

if do_entities then
	require("prototypes.entities.pipes")
	require("prototypes.entities.pumps")
	require("prototypes.entities.pylons")
	require("prototypes.entities.sensor-nodes")
	require("prototypes.entities.substations")
	require("prototypes.entities.storage-tanks")
	require("entity.thermal-tank")
	require("prototypes.entities.drone-launchers")
	require("prototypes.entities.inserters")
	require("prototypes.entities.inserters-bulk")
end

if do_technologies or do_items then
	require("prototypes.technology")
end

if do_equipment or do_items or do_technologies then
	require("prototypes.equipment")
end

-- After all entity updates.
if do_items then
	require("prototypes.items.robot-frames")
	require("prototypes.items.broken")
end
