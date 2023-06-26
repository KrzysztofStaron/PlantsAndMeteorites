extends Control
signal lunch 


func _on_soldSlot_priceChanged():
	var sum := 0
	for slot in $Panel/sold/sold.get_children():
		sum += slot.price
	
	$Panel/sold/sum/sum.text = str(sum)


func _on_lunch_pressed():
	var sum := 0
	
	for slot in $Panel/sold/sold.get_children():
		sum += slot.price
		slot.get_node("buildingSlot").setItem(null)
	
	GameManager.money += sum
	
	print("lunch")
	# lunch logic
	hide()
	
	emit_signal("lunch")
