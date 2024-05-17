extends State

var carried_node
@onready var scene_tile_2d_manager = $"../../TileSystem/SceneTile2DManager"
@onready var build_manager = $"../../TileSystem/BuildManager"
@onready var tile_generator = $"../../TileSystem/TileGenerator"
@onready var preview_manager = $"../../TileSystem/PreviewManager"
@onready var point_manager = $"../../PointManager"
@export var sub_tile_chance:float = 0.9
@export var point_requirement_growth = 1.2
var points_until_next_lodestone = 80
@export var base_point_requirements = 80
var level = 1
var lodestones = 0

func _initialize_state(state_machine_node:FiniteStateMachine, root_node:Node2D):
	super._initialize_state(state_machine_node, root_node)
	point_manager.increased_points.connect(_on_score_increase)
	

func _enter_state():
	points_until_next_lodestone = base_point_requirements
	carried_node = tile_generator.generate_beacon_tile()
	build_manager.update_preview(carried_node)
	_set_starter_tile()

func _set_starter_tile():
	build_manager.set_starter_tile(Vector2i(808,808))

func _exit_state():
	pass

func _state_update(_delta: float):
	handle_building()
	pass

func _state_physics_update(_delta: float):
	pass

func _on_score_increase(increase:int):
	while increase > 0:
		var diff = points_until_next_lodestone - increase
		if diff > 0:
			points_until_next_lodestone -= increase
			break
		elif diff <= 0:
			increase = -diff
			level += 1
			points_until_next_lodestone = base_point_requirements * pow(point_requirement_growth, level)
			lodestones += 1
			print("points_until_next_lodestone")

func _draw_tile():
	var tile_data = null
	if lodestones > 0:
		tile_data = tile_generator.generate_beacon_tile()
		lodestones -= 1
	else:
		tile_data = tile_generator.generate_random_tile(sub_tile_chance)	
	carried_node = tile_data
	build_manager.update_preview(carried_node)


func handle_building():
	var mouse_position = build_manager.get_global_mouse_position()
	var grid_position = scene_tile_2d_manager.world_to_grid_position(0, mouse_position)
	var currently_targeted_tile = scene_tile_2d_manager.get_tile_on_layer(0, grid_position)[1]
	
	var placement_legality = build_manager.is_valid_placement(grid_position, null, false) #FIX NULL
	
	preview_manager.set_grid_dependency(placement_legality)
	preview_manager.set_legality(placement_legality)
	if Input.is_action_just_pressed("Build") && placement_legality && carried_node:
		var built_tile = build_manager._build_tile(grid_position, carried_node)
		if built_tile[0] != null:
			set_up_tile(built_tile[0])
			for subtile in built_tile[1]:
				if subtile != null:
					set_up_tile(subtile)
		_draw_tile()
	if Input.is_action_just_pressed("Rotate"):
		carried_node = build_manager.rotate_tile(carried_node)


func set_up_tile(tile:Node2D):
	var point_holder = tile.get_node("PointHolder")
	point_manager.on_score_increase(point_holder.points)
	point_holder.changed_points.connect(point_manager.on_score_increase)
	
