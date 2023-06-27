extends TextureRect

export var index : int

func _ready():
	setItem(null)

func setItem(item : InventoryItem):
	if item == null:
		$icon.texture = null
		$amount.text = ""
		$remove.hide()
		$sub.hide()
	else:
		$remove.show()
		$sub.show()
		$icon.texture = item.texture
		$amount.text = str(item.quantity)

func sub():
	var item : InventoryItem = $"../..".inventory[index]
	item.quantity -= 1
	
	if item.quantity <= 0:
		$"../..".inventory[index] = null
		$icon.texture = null
		$amount.text = ""
		
		$remove.hide()
		$sub.hide()
	else:	
		$amount.text = str(item.quantity)
		
	

func remove():
	$"../..".inventory[index] = null
	$remove.hide()
	$sub.hide()
	
	$icon.texture = null
	$amount.text = ""
