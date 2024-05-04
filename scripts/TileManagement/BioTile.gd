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

func _ready():
	if has_node("Debugger"):
		print("Forest created")
	for subsystem in on_tick_subsystems:
		subsystem.interface = self

func on_placed():
	for subsystem in on_tick_subsystems:
		subsystem.on_placed()

func on_tick ():
	for subsystem in on_tick_subsystems:
		subsystem.on_tick()

