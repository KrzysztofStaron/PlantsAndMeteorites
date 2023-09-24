extends Node2D

func _ready():
	if len(GameManager.cloningStations) > 0:
		$buttons/clone.self_modulate = Color(1,1,1,1)
		$buttons/clone.disabled = false
	
func _on_clone_pressed():
	# load game save
	# give GameManger info that it should start respawning
	pass

func _on_menu_pressed():
	$buttons/clone.disabled = true
	$buttons/menu.disabled = true
	$AnimationPlayer.play("hide")

func loadGame():
	get_tree().change_scene("res://scenes/screens/menu/menu.tscn")
