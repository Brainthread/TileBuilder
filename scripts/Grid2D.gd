@tool
extends Node2D
class_name Grid2D

@export var show_in_editor = false
@export var in_editor_color = Color.WHITE_SMOKE

@export var cell_size = 32
@export var size:Vector2i = Vector2i(100, 100)
@export var offset:Vector2 = Vector2(0, 0)
@export var center_on_zero:bool = true


var drawn = false

func _ready():
	if center_on_zero:
		offset = -cell_size*size/2

func _process(_delta):
	pass

func is_position_in_bounds (grid_position:Vector2i) -> bool:
	if grid_position.x < 0 or grid_position.y < 0:
		return false
	if grid_position.x > size.x or grid_position.y>size.y:
		return false
	return true

func world_to_grid_position(world_position:Vector2) -> Vector2i:
	var pos = world_position - offset
	if pos.x < 0 or pos.y < 0:
		return Vector2i(NAN, NAN)
	pos.x /= cell_size
	pos.y /= cell_size
	pos.x = floori(pos.x)
	pos.y = floori(pos.y)
	var grid_position = Vector2i(pos.x, pos.y)
	return grid_position

func grid_to_world_position(grid_position:Vector2i) -> Vector2:
	var real_position = grid_position as Vector2
	if real_position.x < 0 or real_position.y < 0:
		return Vector2i(NAN, NAN)
	real_position.x *= cell_size
	real_position.y *= cell_size
	real_position.x += cell_size as float/2
	real_position.y += cell_size as float/2
	real_position += offset
	return real_position

#TODO
func _draw():
	if show_in_editor:
		for y in size.y:
			var v_line_start = offset + y * cell_size * Vector2.RIGHT
			var v_line_end = v_line_start + Vector2.DOWN * size.y * cell_size
			draw_line(v_line_start, v_line_end, in_editor_color, 0.5, true)
			for x in size.x:
				var h_line_start = offset + x * cell_size * Vector2.DOWN
				var h_line_end = h_line_start + Vector2.RIGHT * size.x * cell_size
				draw_line(h_line_start, h_line_end, in_editor_color, 0.5, true)

#TODO
func draw_only_in_view():
	pass
