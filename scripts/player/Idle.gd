extends State

func handle_input(event: InputEvent) -> void:
	if event is InputEventKey:
		if InputManager.vector("move_left", "move_right", "move_up", "move_down"):
			state_machine.transition_to("Walking")
