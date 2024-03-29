extends Building
var block := true

onready var ui := $ui

func _ready():
	turnAreas(false)

func turnAreas(state : bool):
	for slot in $ui/CenterContainer/GridContainer.get_children():
		slot.get_node("area").monitoring = state
		slot.get_node("area").monitorable = state

func interact_right():
	if GameManager.canPause:
		$AnimationPlayer.play("open")
	
func interact_left():
	var item = Inventory.getSelectedItem()
	
	if item == null:
		return
	if item.type == "tool" and item.toolType == Tool.Hammer:
		instanceLoot(load("res://data/items/buildings/chest.tres"), preload("res://scenes/objects/buildings/IronWall/destroy.tscn"))	
	
func _process(delta):
	if Input.is_action_pressed("pause") and ui.visible:
		turnAreas(false)
		GameManager.canPause = true
		GameManager.player.canMove = true
		print("chest - true")
		ui.hide()
		$AnimationPlayer.play("close")
	

func open():
	turnAreas(true)
	ui.show()
	GameManager.canPause = false
	GameManager.player.canMove = false
	print("chest - false")

func _on_ui_visibility_changed():
	for slot in $ui/CenterContainer/GridContainer.get_children():
		slot.get_node("area").monitoring = ui.visible
		slot.get_node("area").monitorable = ui.visible
