extends buildingSlot
	
func setItem(_item : InventoryItem):
	Inventory.inventory[index] = _item
	item = _item
	update()
