extends Building
var block := true

func interact_right():
	$AnimationPlayer.play("open")
	
func interact_left():
	var item = Inventory.getSelectedItem()
	
	if item == null:
		return
	if item.type == "tool" and item.toolType == Tool.Hammer:
		instanceLoot(load("res://data/items/buildings/chest.tres"), preload("res://scenes/objects/buildings/IronWall/destroy.tscn"))	
	
func _process(delta):
	if Input.is_action_pressed("pause") and $ui.visible:
		GameManager.canPause = true
		$ui.hide()
		$AnimationPlayer.play("close")

func open():
	$ui.show()
	GameManager.canPause = false