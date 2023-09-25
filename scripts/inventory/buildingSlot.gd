extends quickInventorySlot
class_name buildingSlot
signal itemChanged

export var item : Resource

func _ready():
	update()

func update():
	emit_signal("itemChanged")
	if getItem() == null:
		get_node("icon").texture = Texture
	else:
		print(getItem().name)
		get_node("icon").texture = item.texture

	if item is CountableItem and item.quantity > 1:
		get_node("amount").text = str(item.quantity)
	else:
		get_node("amount").text = ""


func getItem() -> InventoryItem:
	return (item as InventoryItem)
	
func setItem(_item : InventoryItem):
	item = _item
	update()
