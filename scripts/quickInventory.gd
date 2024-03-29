extends TextureRect
signal ItemChanged

var inv : Array
var dropping := false

var oldSelected : Resource

func drop(num := 0):
	if len(get_tree().get_root().get_node("main/pointer/bodyDetector").get_overlapping_bodies()) != 0:
		$Label.visible = false
	elif get_tree().get_root().get_node("main/pointer").isInReach():
		dropping = false
		$Label.visible = dropping
		
		var dropScene : Node = preload("res://scenes/droppedItem.tscn").instance()
		dropScene.position = get_tree().get_root().get_node("main/pointer").position
		dropScene.item = Inventory.getSelectedItem().duplicate()
		
		if not dropScene.item is CountableItem:
			Inventory.inventory[Inventory.selectedItemIndex] = null
			emit_signal("ItemChanged")
		else:
			dropScene.item.quantity = num
			Inventory.removeAmount(num)
		
		get_tree().get_root().get_node("main/items").add_child(dropScene)
		
func _ready():
	inv = Inventory.inventory
	if Inventory.getSelectedItem() == null:
		oldSelected = null
	else:
		oldSelected = Inventory.getSelectedItem().duplicate()
	updateSelection(0)

func _input(event):
	if event is InputEventKey:
		for slot in range(1,5):
			if event.is_action_pressed("slot"+str(slot)):
				updateSelection(slot - 1)
				# Label Position
				$Label.rect_position.y = get_node("VContainer/slot"+str(slot-1)).rect_position.y - 4
		# Dropping
		if event.is_action_pressed("dropItem") and Inventory.getSelectedItemType() and get_tree().get_root().get_node("main/pointer").isInReach():
			if len(get_tree().get_root().get_node("main/pointer/bodyDetector").get_overlapping_bodies()) != 0:
				pass
			elif Inventory.getSelectedItem() is CountableItem:		
				$Timer.start(1.0)
				dropping = true
				$Label.visible = true
			else:
				drop()

func timeToInt() -> int:
	return int((Inventory.getSelectedItem().quantity-1) * (1-$Timer.time_left)) + 1

func _process(delta):
	if Inventory.getSelectedItem() != null:
		if oldSelected == null:
			emit_signal("ItemChanged")
			oldSelected = Inventory.getSelectedItem().duplicate()
		elif oldSelected.name != Inventory.getSelectedItem().name:
			emit_signal("ItemChanged")
			oldSelected = Inventory.getSelectedItem().duplicate()
	else:
		if oldSelected != null:
			emit_signal("ItemChanged")
			oldSelected = null

	for slot in range(1,5):
		if Input.is_action_just_pressed("slot"+str(slot)):
			Inventory.selectedItemIndex = slot - 1

	if dropping:
		if Input.is_action_just_pressed("cancelDrop"):
			dropping = false
			$Label.hide()
		else:
			$Label.text = str(timeToInt()) + "/" + str(Inventory.getSelectedItem().quantity)
			$Label.rect_position.y = get_node("VContainer/slot"+str(Inventory.selectedItemIndex)).rect_position.y
			if timeToInt() == Inventory.getSelectedItem().quantity:
				drop(Inventory.getSelectedItem().quantity)
	
	if Input.is_action_just_released("dropItem") and dropping:
		drop(timeToInt())
		dropping = false
		
	for slotIndex in range(0, 4):
		var slot : Node = get_node("VContainer/slot"+str(slotIndex))
		if inv[slotIndex] == null:
			slot.get_node("icon").texture = Texture
		else:
			slot.get_node("icon").texture = inv[slotIndex].texture

		if inv[slotIndex] is CountableItem and inv[slotIndex].quantity > 1:
			slot.get_node("amount").text = str(inv[slotIndex].quantity)
		else:
			slot.get_node("amount").text = ""


func _on_slot_pressed(slotId):
	updateSelection(slotId)
	
func updateSelection(id : int):
	Inventory.selectedItemIndex = id
	for slotIndex in range(0, 4):
		get_node("VContainer/slot"+str(slotIndex)).disabled = slotIndex == id
