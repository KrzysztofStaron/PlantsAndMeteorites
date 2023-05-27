extends Node2D

export var yOffset : float

func _process(delta):
	if GameManager.player == null:
		return 
	else:
		if GameManager.player.get_global_position().y+yOffset < get_global_position().y:
			z_index = GameManager.player.z_index + 1
		else:
			z_index = GameManager.player.z_index - 1
