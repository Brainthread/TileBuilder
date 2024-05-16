extends TileBehaviour

@export var subtile_neighbors = [null, null, null, null]
@export var neighbor_value = 2

func on_placed():
	check_neighbors()

func on_tick():
	check_neighbors()

func check_neighbors():
	var directions = [Vector2i(-1, 0), Vector2i(0, -1), Vector2i(1, 0), Vector2i(0, 1)]
	for n in directions.size():
		var tile_at_position = interface.access_tile_position(interface.grid_position + directions[n], 1)[0]
		if subtile_neighbors[n] == null and tile_at_position != null:
			subtile_neighbors[n] = tile_at_position
			print (tile_at_position)
			$"../PointHolder".add_to_point(neighbor_value)

