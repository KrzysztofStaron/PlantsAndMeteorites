extends Control

func _input(event):
	if event is InputEventKey:
		if event.is_action_pressed("inventory"):
			if visible:
				close()
			else:
				show()

func _ready():
	hide()

func open():
	show()
	GameManager.canPause = false

func close():
	hide()
	GameManager.canPause = true

func itemChanged():
	pass


