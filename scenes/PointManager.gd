extends Node2D

var score = 0

func on_score_increase (increase:int):
	score += increase
	
#TODO: MIGRATE
func _process(_delta):
	$"../Camera2D/CanvasLayer/Control/Label".text = "Score: " + str(score)
