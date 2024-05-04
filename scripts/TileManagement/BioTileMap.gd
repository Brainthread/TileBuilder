extends Node2D
class_name BioTileMap

@onready var layers = $Tile2DLayers

@export var test_tile:SceneTile2D

func _ready():
	pass

func is_position_in_bounds (layer_index:int, grid_position:Vector2i) -> bool:
	return layers.get_child(layer_index).is_position_in_bounds(grid_position)
	
func get_tile_on_layer(layer_index:int, grid_position:Vector2i) -> Array:
	return layers.get_child(layer_index).get_tile(grid_position)

func set_tile_on_layer(layer_index:int, grid_position:Vector2i, tile:SceneTile2D) -> Node2D:
	var grid_2d = layers.get_child(layer_index).get_child(0)
	var world_position = grid_2d.grid_to_world_position(grid_position)
	return layers.get_child(layer_index).set_tile(grid_position, world_position, tile)

func remove_tile_on_layer(layer_index:int, grid_position:Vector2i) -> bool:
	return layers.get_child(layer_index).remove_tile(grid_position)

func world_to_grid_position(layer_index:int, world_position:Vector2) -> Vector2i:
	var grid_2d = layers.get_child(layer_index).get_child(0)
	return grid_2d.world_to_grid_position(world_position)

func grid_to_world_position(layer_index:int, grid_position:Vector2i) -> Vector2:
	var grid_2d = layers.get_child(layer_index).get_child(0)
	return grid_2d.grid_to_world_position(grid_position)

func world_position_to_gridified_world_position(layer_index:int, world_position:Vector2) -> Vector2:
	var grid_2d = layers.get_child(layer_index).get_child(0)
	return grid_2d.grid_to_world_position(grid_2d.world_to_grid_position(world_position))



