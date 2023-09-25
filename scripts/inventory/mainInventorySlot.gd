extends buildingSlot

func getItem() -> InventoryItem:
	return Inventory.inventory[index]
	update()

func setItem(_item : InventoryItem):
	Inventory.inventory[index] = _item
	update()

func _ready():
	setItem(getItem())
	update()

func update():
	if Inventory.inventory[index] == null:
		get_node("icon").texture = Texture
	else:
		get_node("icon").texture = getItem().texture

	if getItem() is CountableItem and getItem().quantity > 1:
		get_node("amount").text = str(getItem().quantity)
	else:
		get_node("amount").text = ""
