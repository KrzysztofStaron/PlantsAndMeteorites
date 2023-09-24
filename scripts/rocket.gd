extends object

func interact_right():
	GameManager.canPause = false
	get_tree().get_root().get_node("main/UI/rocketUI").open()

func _ready():
	get_tree().get_root().get_node("main/UI/rocketUI").hide()

func _input(event):
	if event.is_action_pressed("pause") and get_tree().get_root().get_node("main/UI/rocketUI").visible:
		GameManager.canPause = true
		get_tree().get_root().get_node("main/UI/rocketUI").close()

func _on_rocketUI_lunch():
	hide()
	queue_free()
