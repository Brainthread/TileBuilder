extends Node2D
class_name PointHolder

signal changed_points(points:int)
signal minimum_set
signal maximum_set

signal value_overloaded
signal value_underloaded

@export var points:int = 0
@export var min:int = 0
@export var max:int = 10

func add_to_point(value:int):
	points += value
	changed_points.emit(points)
	if points > max:
		points = max
		value_overloaded.emit()
	if points < min:
		points = min
		value_underloaded.emit()

func set_min_point(value:int):
	min = value
	minimum_set.emit()

func set_max_point(value:int):
	max = value
	maximum_set.emit()

func get_points() -> int:
	return points
