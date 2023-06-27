extends Control

signal priceChanged

var price : int

func _on_buildingSlot_itemChanged():
	var item : InventoryItem = $buildingSlot.item
	if item == null:
		$Label.text = "0"
	else:
		if item is CountableItem:
			$Label.text = str(item.sell_price * item.quantity)
		else:
			$Label.text = str(item.sell_price)
	
	price = int($Label.text)
	
	emit_signal("priceChanged")
