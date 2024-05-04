extends Node
class_name FiniteStateMachine

@export var current_state: State
@export var states : Array[State]
@export var root: Node2D

func _ready():
	states.resize(get_child_count())
	var array_size = 0
	for state in get_children():
		if not state is State:
			continue
		if current_state == null:
			current_state = state #if no base state is set, pick first possible
		states[array_size] = state
		array_size += 1
		state._initialize_state(self, root)
	states.resize(array_size)
	if not current_state:
		current_state = get_child(0)
		if not get_child(0):
			push_error("State machine has no states!")
	_change_state(current_state)

func _change_state(new_state: State):
	if new_state == current_state:
		push_warning("Attempting to set state to current state.")
	if current_state is State:
		current_state._exit_state()
	print("Current state is " + str(current_state) + " | " + "Changing to " + str(new_state))
	current_state = new_state
	current_state._enter_state()

func _process(delta):
	current_state._state_update(delta)

func _physics_process(delta):
	current_state._state_physics_update(delta)

