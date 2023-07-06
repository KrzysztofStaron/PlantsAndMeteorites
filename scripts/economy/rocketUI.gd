extends Control
signal lunch 

func sumUp() -> int:
	var sum := 0
	for slot in $Panel/sold/sold.get_children():
		if slot.get_node("buildingSlot").item != null:
			if slot.get_node("buildingSlot").item is CountableItem:
				sum += slot.get_node("buildingSlot").item.sell_price * slot.get_node("buildingSlot").item.quantity
			else:
				sum += slot.get_node("buildingSlot").item.sell_price
	return sum

func _on_soldSlot_priceChanged():
	$Panel/sold/sum/sum.text = str(sumUp())

func _on_lunch_pressed():
	GameManager.money += sumUp()
	for slot in $Panel/sold/sold.get_children():
		slot.get_node("buildingSlot").setItem(null)
	
	print("lunch")
	# lunch logic
	hide()
	
	emit_signal("lunch")


func _on_rocketUI_visibility_changed():
	GameManager.canPause = visible
