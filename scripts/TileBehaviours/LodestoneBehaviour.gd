extends TileBehaviour

@export var build_tile:SceneTile2D
@export var radius = 2

func on_placed():
	_try_to_place_markers()

	
func _try_to_place_markers():
	var width = 1 + 2 * radius
	var start_position = interface.grid_position - Vector2i(radius, radius)
	for x in width:
		for y in width:
			var new_position = start_position + Vector2i(x, y)
			if interface.map_handler.is_position_in_bounds(0, new_position) and \
					interface.map_handler.get_tile_on_layer(0, new_position)[1] == null:
				interface.map_handler.set_tile_on_layer(0, new_position, build_tile)
				

func on_tick():
	pass
