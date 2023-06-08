extends Building

func interact_left():
	print("left")

func interact_right():
	GameManager.canPause = false
	get_tree().get_root().get_node("main/UI/craftingStationUI").show()
	get_tree().paused = true


