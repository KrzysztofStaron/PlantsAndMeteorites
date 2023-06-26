extends Control

func _on_buildingSlot_itemChanged():
	var item : InventoryItem = $CenterContainer/HBoxContainer/buildingSlot.item
	
	if item
