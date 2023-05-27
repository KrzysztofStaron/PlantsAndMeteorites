extends State

export var speed := 50.0

enum {DOWN, RIGHT, UP, LEFT}

func handle_input(_event: InputEvent) -> void:
	pass

func exit() -> void:
	pass

func enter(_data := {}) -> void:
	pass

func update(_delta : float) -> void:
	var dir : Vector2 = InputManager.vector("move_left", "move_right", "move_up", "move_down")

	if dir:
		if dir.x < 0:
			owner.get_node("Sprite").frame = LEFT
		elif dir.x > 0:
			owner.get_node("Sprite").frame = RIGHT
		elif dir.y < 0:
			owner.get_node("Sprite").frame = UP
		else:
			owner.get_node("Sprite").frame = DOWN

		(owner as KinematicBody2D).move_and_slide(dir * speed)
	else:
		state_machine.transition_to("Idle")
