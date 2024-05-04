extends AnimationPlayer

@export var animation_name = "marker_tile_glow"

func _ready():
	play(animation_name)
