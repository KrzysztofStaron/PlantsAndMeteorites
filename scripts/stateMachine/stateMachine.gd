class_name StateMachine
extends Node

# Emitted when transitioning to a new state.
signal transitioned(state_name)

# Path to the initial active state. We export it to be able to pick the initial state in the inspector.
export var initial_state : NodePath = "Idle"

# The current active state. At the start of the game, we get the `initial_state`.
onready var state : State = get_node(initial_state)


func _ready() -> void:
	yield(owner, "ready")
	# The state machine assigns itself to the State objects' state_machine property.
	for child in get_children():
		child.state_machine = self
	
	state.enter()


# The state machine subscribes to node callbacks and delegates them to the state objects.
func _input(event: InputEvent) -> void:
	state.handle_input(event)


func _process(delta: float) -> void:
	state.update(delta)


func _physics_process(delta: float) -> void:
	state.physics_update(delta)


# This function calls the current state's exit() function, then changes the active state,
# and calls its enter function.
# It optionally takes a `msg` dictionary to pass to the next state's enter() function.
func transition_to(target_state_name: String, msg: Dictionary = {}) -> void:
	if owner.get_node("debug").visible:
		owner.get_node("debug").text = target_state_name

	if not has_node(target_state_name):
		push_error(target_state_name + " don't exist")
		return

	state.exit()
	state = get_node(target_state_name)
	state.enter(msg)

	emit_signal("transitioned", state.name)
	
