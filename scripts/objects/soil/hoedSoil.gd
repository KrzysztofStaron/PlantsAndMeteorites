extends Building
class_name Soil

export var crop : Resource
export var growthDays : int
export var watered : bool

func _ready():
	show()
	if crop != null:
		$crop.texture = crop.textures[growthDays]
		if crop.specialNode:
			add_child(crop.specialNode.instance())
	
func updateTexture():
	$appear.queue_free()
	get_parent().updateTexture(position)
	
func interact_right():
	harvest()
	
func interact_left():
	var item = Inventory.getSelectedItem()
	if item == null:
		return

	match item.type:
		"seed":
			if plantCrop(item.crop):
				Inventory.removeAmount()
		"tool":
			match item.toolType:
				Tool.Hammer:
					digUp()
				Tool.Drill:
					destroy()
				Tool.WateringCan:
					water()
					
func nextDay():
	$watered.hide()
	if watered and crop:
		if !isFullyGrown():
			growthDays += 1

		$crop.texture = crop.textures[growthDays]
		watered = false
	
	# print("GrowthDays: " + str(growthDays) + " isFullyGrown: " + str(isFullyGrown()))

func plantCrop(cropToPlant : Plant) -> bool:
	if crop == null:
		crop = cropToPlant
		$crop.texture = crop.textures[0]
		if crop.specialNode:
			add_child(crop.specialNode.instance())

		return true
	else:
		return false

func water():
	$watered.show()
	watered = true

func digUp():
	destroySpecial()
	crop = null
	growthDays = 0
	$crop.texture = null

func isFullyGrown() -> bool:
	if crop:
		return growthDays >= crop.growthTime
	else:
		return false

func destroy():
	var destroy : Node = preload("res://scenes/objects/buildings/soil/destroy.tscn").instance()
	destroy.position = position
	destroy.emitting = true
	get_parent().add_child(destroy)

	var dropScene : Node = preload("res://scenes/droppedItem.tscn").instance()
	dropScene.position = position
	dropScene.item = load("res://data/items/buildings/soil.tres")
	get_node("/root/main/items").add_child(dropScene).add_child(dropScene)

	get_parent().updateTexture(position, true)
	queue_free()

func harvest():
	if crop == null:
		pass
	elif !isFullyGrown():
		pass
	else:
		for i in crop.specialHarvests:
			if randf() < i[1]:
				if Inventory.addToinventory(load(i[0])):
					pass
				else:
					var dropScene : Node = preload("res://scenes/droppedItem.tscn").instance()
					dropScene.position = position
					dropScene.item = load(i[0])
					get_node("/root/main/items").add_child(dropScene).add_child(dropScene)
		
		var newItem : CountableItem = crop.harvest
		newItem.quantity = crop.harvestAmount
		if Inventory.addToinventory(newItem):
			var pickup : Node = preload("res://scenes/objects/buildings/soil/pickup.tscn").instance()
			pickup.position = position
			get_parent().add_child(pickup)
			
			growthDays = 0
			crop = null
			$crop.texture = null
		else:
			pass
		
	destroySpecial()

func destroySpecial():
	var special : Node = get_node_or_null("special")
	if special != null:
		special.queue_free()
