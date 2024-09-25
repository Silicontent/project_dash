class_name StateMachine
extends Node

@export var initial_state: State = null

# reference to the current state
# starts as initial_state or first child state
@onready var state: State = (func get_initial_state() -> State:
	return initial_state if initial_state != null else get_child(0)
).call()	


func _ready() -> void:
	# connect every state to this state machine
	for state_node: State in find_children("*", "State"):
		state_node.finished.connect(_transition_to_next_state)
	
	# wait for the root node to fully initialize
	await owner.ready
	# enter the initial state
	state.enter("")


func _transition_to_next_state(target_state_path: String, data: Dictionary = {}) -> void:
	# ensure the state exists, else throw an error
	if not has_node(target_state_path):
		printerr(owner.name + ": tried to transition to state " + target_state_path + " but it does not exist.")
		return
	
	# get the previous state's name and exit it
	var previous_state_path := state.name
	state.exit()
	# enter the new state
	state = get_node(target_state_path)
	state.enter(previous_state_path, data)


func _unhandled_input(event: InputEvent) -> void:
	state.handle_input(event)


func _process(delta: float) -> void:
	state.update(delta)


func _physics_process(delta: float) -> void:
	state.physics_update(delta)
