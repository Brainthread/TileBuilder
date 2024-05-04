extends Resource
class_name TilePackage

@export var background_tile:SceneTile2D
@export var front_tiles:Array[SceneTile2D]


func rotate_elements ():
	var temp_element = front_tiles[0]
	for i in 3:
		front_tiles[i-1] = front_tiles[i]
	front_tiles[3] = temp_element
	
