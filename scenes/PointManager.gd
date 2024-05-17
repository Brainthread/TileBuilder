extends Node2D

var score = 0
signal increased_points (increase:int)

func on_score_increase (increase:int):
	score += increase
	increased_points.emit(increase)
	
#TODO: MIGRATE
func _process(_delta):
	$"../Camera2D/CanvasLayer/Control/Label".text = "Score: " + str(score)
