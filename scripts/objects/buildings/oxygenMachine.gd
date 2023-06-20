extends Building

func _on_oxygenMachine_build():
	$AnimationPlayer.play("idle")
	$oxygen.disabled = false

func interact_left():
	var item = Inventory.getSelectedItem()
	if item == null:
		return

	if item.type == "tool" and item.toolType == Tool.Hammer:
		instanceLoot(load("res://data/items/buildings/OxygenMachine.tres"), load("res://scenes/objects/buildings/IronWall/destroy.tscn"))
