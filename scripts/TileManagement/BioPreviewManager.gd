extends Node2D

@onready var tile_manager = $"../SceneTile2DManager"
@onready var preview = $Preview
@onready var preview_tiles = [$"Preview/Icon/Part 1", $"Preview/Icon/Part 2", $"Preview/Icon/Part 3", $"Preview/Icon/Part 4"]

@export var valid_color = Color.GREEN_YELLOW
@export var invalid_color = Color.MEDIUM_VIOLET_RED

var tile_rotation: = 0
var grid_dependent = false
var position_is_valid = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	update_preview_position()
	pass

func update_preview_position ():
	var mousePos = get_global_mouse_position()
	var preview_position = Vector2.ZERO
	if grid_dependent:
		preview_position = tile_manager.world_position_to_gridified_world_position(0, mousePos)
	else:
		preview_position = mousePos
	preview.global_position = preview_position

func set_grid_dependency (value:bool):
	grid_dependent = value

func set_legality (value:bool):
	position_is_valid = value
	if position_is_valid:
		preview.get_child(0).self_modulate = valid_color
	else:
		preview.get_child(0).self_modulate = invalid_color

func set_new_preview_item (main_image:Texture2D, sub_images:Array[Texture2D]):
	preview.get_child(0).texture = main_image
	for n in 4:
		if sub_images[n] != null:
			preview_tiles[n].texture = sub_images[n]
	

func rotate_preview ():
	pass
