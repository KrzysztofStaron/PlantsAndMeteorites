extends TextureRect

func _input(event):
	if event is InputEventKey:
		if event.is_action_pressed("pause"):
			if GameManager.canPause:
				visible = !visible
				get_tree().paused = visible
				$"../../pointer".visible = !visible

func _on_resume_pressed():
	visible = false
	get_tree().paused = false
	$"../../pointer".visible = true

func _on_settings_pressed():
	print("settings")

func _on_home_pressed():
	print("home")
