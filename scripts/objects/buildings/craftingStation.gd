extends Building

func interact_left():
	print("left")

func interact_right():
	if builded:
		GameManager.canPause = false
		get_tree().get_root().get_node("main/UI/craftingStationUI").show()
		get_tree().get_root().get_node("main/UI/craftingStationUI").stationPos = position + Vector2(0, 8)
		get_tree().paused = true
