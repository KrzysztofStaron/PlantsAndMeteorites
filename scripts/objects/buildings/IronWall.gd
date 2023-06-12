extends Building

func build():
	var tileMap : TileMap = get_parent()
	var tilePosition : Vector2 = tileMap.world_to_map(position)
	
	tileMap.set_cellv(tilePosition, 0)
	tileMap.update_bitmask_area(tilePosition)

func interact_left():
	var item = Inventory.getSelectedItem()
	if item == null:
		return

	if item.type == "tool" and item.toolType == Tool.Hammer:
		destroy()
		
func destroy():
	var tileMap : TileMap = get_parent()
	var tilePosition : Vector2 = tileMap.world_to_map(position)
	
	var destroy : Node = preload("res://scenes/objects/buildings/IronWall/destroy.tscn").instance()
	destroy.position = position
	destroy.emitting = true
	get_parent().add_child(destroy)

	var dropScene : Node = preload("res://scenes/droppedItem.tscn").instance()
	dropScene.position = position
	dropScene.item = load("res://data/items/buildings/IronWall.tres")
	
	get_parent().add_child(dropScene)
	tileMap.set_cellv(tilePosition, -1)
	tileMap.update_bitmask_area(tilePosition)
	
	queue_free()

