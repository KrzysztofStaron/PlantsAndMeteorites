extends TextureRect

var inv : Array

func drop():
	var dropScene : Node = preload("res://scenes/droppedItem.tscn").instance()
	dropScene.position = GameManager.player.position + Vector2(0, 18)
	dropScene.item = Inventory.getSelectedItem()
	Inventory.inventory[Inventory.selectedItemIndex] = null
	get_tree().get_root().get_node("main").add_child(dropScene)

func _ready():
	inv = Inventory.inventory

func _input(event):
	if event is InputEventKey:
		for slot in range(1,len(Inventory.inventory)+1):
			if event.is_action_pressed("slot"+str(slot)):
				updateSelection(slot - 1)
		if event.is_action_pressed("dropItem"):
			drop()
		
func _process(delta):
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
		get_node("VContainer/slot"+str(slotIndex)).pressed = slotIndex == id
