extends Control

func _process(delta):
	if Input.is_action_just_pressed("debug_shop"):
		visible = !visible
		
	$money.text = str(GameManager.money)

func _on_buildingSlot_itemChanged():
	var item : InventoryItem = $CenterContainer/HBoxContainer/buildingSlot.item
	
	if item == null:
		$CenterContainer/HBoxContainer/Label.text = "0"
	elif item is CountableItem:
		$CenterContainer/HBoxContainer/Label.text = str(item.price * item.quantity)
	else:
		$CenterContainer/HBoxContainer/Label.text = str(item.price)


func _on_sell_pressed():
	var item : InventoryItem = $CenterContainer/HBoxContainer/buildingSlot.item
	
	if item == null:
		pass
	elif item is CountableItem:
		GameManager.money += item.price * item.quantity
	else:
		GameManager.money += item.price

	$CenterContainer/HBoxContainer/buildingSlot.setItem(null)


func _on_Button_pressed():
	visible = !visible
