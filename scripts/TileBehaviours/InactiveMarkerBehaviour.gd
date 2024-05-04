extends TileBehaviour

@export var active_tile:SceneTile2D

func on_tick():
	_neighbor_check()
	
func on_placed():
	pass

func _process(delta):
	if interface:
		_neighbor_check()
	
func _neighbor_check():
	var switch = false
	if _is_valid_neighbour(interface.grid_position-Vector2i(1, 0)):
		switch = true
	if _is_valid_neighbour(interface.grid_position-Vector2i(0, 1)):
		switch = true
	if _is_valid_neighbour(interface.grid_position+Vector2i(1, 0)):
		switch = true
	if _is_valid_neighbour(interface.grid_position+Vector2i(0, 1)):
		switch = true
	if switch:
		interface.map_handler.set_tile_on_layer(0, interface.grid_position, active_tile)

func _is_valid_neighbour (grid_position:Vector2i) -> bool:
	var neighbor = interface.map_handler.get_tile_on_layer(0, grid_position)[1]
	if neighbor != null && (not neighbor.is_active and not neighbor.is_template):
		return true
	return false
		
	#var width = 1 + 2 * radius
	#var start_position = interface.grid_position - Vector2i(radius, radius)
	#for x in width:
		#for y in width:
			#var new_position = start_position + Vector2i(x, y)
			#if interface.map_handler.is_position_in_bounds(0, new_position) and \
					#interface.map_handler.get_tile_on_layer(0, new_position)[1] == null:
				#interface.map_handler.set_tile_on_layer(0, new_position, build_tile)
