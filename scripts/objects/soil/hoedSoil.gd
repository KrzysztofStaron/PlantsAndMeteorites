extends Building
class_name Soil

export var crop : Resource
export var growthDays : int
export var watered : bool

func _ready():
	show()
	
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
				Tool.Hoe:
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
	
	print("GrowthDays: " + str(growthDays) + " isFullyGrown: " + str(isFullyGrown()))

func plantCrop(cropToPlant : Plant) -> bool:
	if crop == null:
		crop = cropToPlant
		$crop.texture = crop.textures[0]
		print("planted")
		return true
	else:
		print("crop_slot has already a seed inside")
		return false

func water():
	$watered.show()
	watered = true
	print("water")

func digUp():
	print("diged up")
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

	if not Inventory.addToinventory(load("res://data/items/buildings/soil.tres")):
		var dropScene : Node = preload("res://scenes/droppedItem.tscn").instance()
		dropScene.position = position
		dropScene.item = load("res://data/items/buildings/soil.tres")
		get_parent().add_child(dropScene)

	get_parent().updateTexture(position, true)
	queue_free()

func harvest():
	if crop == null:
		print("this object( crop_spot ) does not contain any plant")
	elif !isFullyGrown():
		print("crop isn't fully grown")
	else:
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
			print("inventoery full")
