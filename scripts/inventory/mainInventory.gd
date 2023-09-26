extends Control

signal opened
signal closed

func _input(event):
	if event is InputEventKey:
		if event.is_action_pressed("inventory"):
			if visible:
				emit_signal("closed")
				close()
			elif GameManager.canPause:
				emit_signal("opened")
				open()

func _process(delta):
	#print(GameManager.canPause)
	pass

func _ready():
	hide()

func open():
	GameManager.player.canMove = false
	show()
	GameManager.canPause = false
	print("inv - false")

func close():
	GameManager.player.canMove = true
	hide()
	GameManager.canPause = true
	print("inv - true")

func itemChanged():
	pass
