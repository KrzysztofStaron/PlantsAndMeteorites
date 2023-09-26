extends Building

func interact_left():
	var item = Inventory.getSelectedItem()
	if item == null:
		return

	if item.type == "tool" and item.toolType == Tool.Hammer:
		instanceLoot(load("res://data/items/buildings/CraftingStation.tres"), preload("res://scenes/objects/buildings/IronWall/destroy.tscn"))

func interact_right():
	if builded and GameManager.canPause:
		GameManager.canPause = false
		print("crafting - false")
		get_node("ui").show()
		get_node("ui/craftingStationUI").start()
