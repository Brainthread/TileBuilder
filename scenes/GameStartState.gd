extends State

func _enter_state():
	print("Start state")
	state_machine._change_state($"../GameState")

func _exit_state():
	pass

func _state_update(_delta: float):
	pass

func _state_physics_update(_delta: float):
	pass
