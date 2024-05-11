extends Node2D

signal tile_placed (tile:Node2D, subtiles:Array[Node2D])

@onready var scene_tile_2d_manager:BioTileMap = $"../SceneTile2DManager"
@onready var preview_manager = $"../PreviewManager"
@onready var validator = $Validator
@onready var tick_handler = $"../TickHandler"

@export var sample_tile:SceneTile2D
@export var start_tile:SceneTile2D

@export var tile_types:Array[SceneTile2D]
@export var subtile_types:Array[SceneTile2D]

@export var carried_node:BioTileData
@export var created_node:BioTileData
@export var reserved_node:BioTileData

@export var reserved_pile:Node2D

@export var subtile_probability = 0.2
var placement_is_legal = false

func _process(delta):
	pass

#This stays
func _build_tile(grid_position:Vector2i, tile_data:BioTileData) -> Array:
	var node = scene_tile_2d_manager.set_tile_on_layer(0, grid_position, tile_data.main_tile)
	print(node as Node2D)
	node.on_placed()
	tick_handler.ticked.connect(node.on_tick)
	var sub_directions = [Vector2i(0, 0), Vector2i(1, 0), Vector2i(1, 1), Vector2i(0, 1)]
	var sub_nodes = [null, null, null, null]
	for n in 4:
		if tile_data.sub_tiles[n] != null:
			var sub_node = scene_tile_2d_manager.set_tile_on_layer(1, grid_position*2 + sub_directions[n], tile_data.sub_tiles[n])
			sub_node.on_placed()
			tick_handler.ticked.connect(sub_node.on_tick)
			sub_nodes[n] = sub_node
	tile_placed.emit(node, sub_nodes)
	return [node, sub_nodes]

#This stays
func set_starter_tile(position:Vector2i):
		scene_tile_2d_manager.set_tile_on_layer(0, scene_tile_2d_manager.world_to_grid_position(0, Vector2(808,808)), sample_tile)

#This stays
func rotate_tile (tile_data:BioTileData) -> BioTileData:
	var rotated_tile = BioTileData.new()
	rotated_tile.main_tile = tile_data.main_tile
	rotated_tile.sub_tiles[0] = tile_data.sub_tiles[1]
	rotated_tile.sub_tiles[1] = tile_data.sub_tiles[2]
	rotated_tile.sub_tiles[2] = tile_data.sub_tiles[3]
	rotated_tile.sub_tiles[3] = tile_data.sub_tiles[0]
	return rotated_tile

#This stays
func is_valid_placement (grid_position:Vector2i, tile_data:BioTileData, marker_override:bool):
	var currently_targeted_tile = scene_tile_2d_manager.get_tile_on_layer(0, grid_position)[1]
	if currently_targeted_tile != null && !marker_override:
		return currently_targeted_tile.is_template
	elif marker_override && currently_targeted_tile == null:
		return true
	return false

#This stays
func _attempt_to_build_marker_tile(grid_position:Vector2i, tile_data:BioTileData):
	if is_valid_placement(grid_position, tile_data, true):
		scene_tile_2d_manager.set_tile_on_layer(0, grid_position, tile_data.main_tile)

#This stays?
func update_preview(tile_data:BioTileData):
	var sub_tile_textures:Array[Texture2D] = [null, null, null, null]
	for n in 4:
		if tile_data.sub_tiles[n]:
			sub_tile_textures[n] = tile_data.sub_tiles[n].preview
	preview_manager.set_new_preview_item (tile_data.main_tile.preview, sub_tile_textures)

