extends Node2D

func _ready():
	if len(GameManager.cloningStations) > 0:
		$buttons/clone.self_modulate = Color(1,1,1,1)
		$buttons/clone.disabled = false
	
func _on_clone_pressed():
	pass # Replace with function body.

func _on_menu_pressed():
	pass # Replace with function body.
