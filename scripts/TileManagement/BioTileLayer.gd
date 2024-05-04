extends Node2D
class_name BioTileLayer

signal tile_added
signal tile_changed
signal tile_removed

@onready var map_handler:BioTileMap = $"../.." as BioTileMap
@onready var my_grid:Grid2D = $Grid2D
var grid = {}

func get_tile(grid_position:Vector2i) -> Array:
	if (grid.has(grid_position)):
		return grid[grid_position]
	return [null, null]

func is_position_in_bounds (grid_position:Vector2i) -> bool:
	return my_grid.is_position_in_bounds(grid_position)

func set_tile(grid_position:Vector2i, world_position:Vector2, tile:SceneTile2D) -> Node2D:
	var former_tile = get_tile(grid_position)
	var tile_instance:BioTile2D = tile.scene.instantiate()
	remove_tile(grid_position)
	grid[grid_position] = [tile, tile_instance]
	add_child(tile_instance)
	tile_instance.global_position = world_position
	tile_instance.grid_position = grid_position
	tile_instance.map_handler = map_handler
	if former_tile[0] == null:
		tile_added.emit()
	else:
		tile_changed.emit()
	return tile_instance

func remove_tile(grid_position:Vector2i) -> bool:
	if not grid.has(grid_position):
		return false
	grid[grid_position][1].queue_free()
	grid.erase(grid_position)
	return true
