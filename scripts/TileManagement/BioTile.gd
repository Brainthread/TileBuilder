extends Node2D
class_name BioTile2D

@export var is_template:bool = false
@export var is_active:bool = false
@export var can_have_subtiles = true
@export var subtiles = [null, null, null, null] 
@export var on_tick_subsystems:Array[Node2D]

var grid_position:Vector2i
var map_handler:BioTileMap
var neighbours:Array

@export var fadein = false
var startsize

func _ready():
	startsize = scale
	if fadein:
		scale = Vector2(0.7, 0.7)
	for subsystem in on_tick_subsystems:
		subsystem.interface = self

func _process(delta):
	if scale.x < 1:
		scale += Vector2(delta, delta)
	

func on_placed():
	for subsystem in on_tick_subsystems:
		subsystem.on_placed()

func on_tick ():
	for subsystem in on_tick_subsystems:
		subsystem.on_tick()

func access_tile_position (grid_position: Vector2i, layer:int):
	return map_handler.get_tile_on_layer(layer, grid_position)
