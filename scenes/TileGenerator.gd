extends Node2D

@export var tile_types:Array[SceneTile2D]
@export var subtile_types:Array[SceneTile2D]
@export var beacon_tile:SceneTile2D

func generate_beacon_tile() -> BioTileData:
	var tile_data = BioTileData.new()
	tile_data.main_tile = beacon_tile
	var subtiles:Array[SceneTile2D] = [null, null, null, null]
	tile_data.sub_tiles = subtiles
	return tile_data

func generate_random_tile() -> BioTileData:
	var tile_data = BioTileData.new()
	tile_data.main_tile = tile_types.pick_random()
	var subtiles:Array[SceneTile2D] = [null, null, null, null]
	if tile_data.main_tile.can_have_sub_tiles:
		for n in 4:
			if n==1:
				subtiles[n] = subtile_types.pick_random()
	tile_data.sub_tiles = subtiles
	return tile_data
