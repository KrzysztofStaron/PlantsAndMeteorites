extends Building

func interact_right():
	$AnimationPlayer.play("open")
	
func _input(event):
	if event is InputEventKey:
		if event.is_action_pressed("pause") and $ui.visible:
			$ui.hide()
			$AnimationPlayer.play("close")


func open():
	$ui.show()
	GameManager.canPause = false
