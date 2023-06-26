extends object

func interact_right():
	GameManager.canPause = false
	get_node("../UI/rocketUI").show()

func _ready():
	get_node("../UI/rocketUI").hide()

func _input(event):
	if event.is_action_pressed("pause"):
		GameManager.canPause = true
		get_node("../UI/rocketUI").hide()
		


func _on_rocketUI_lunch():
	hide()
