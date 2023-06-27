extends TextureRect

func setItem(item : InventoryItem):
	if item == null:
		$icon.texture = null
		$amount.text = ""
	else:
		$icon.texture = item.texture
		$amount.text = str(item.quantity)
