extends Node

onready var inventory := [
	null,
	preload("res://data/items/tools/drill.tres"),
	preload("res://data/items/tools/wateringCan.tres"),
	preload("res://data/items/tools/hoe.tres"),
]

var selectedItemIndex := 0

func swap(firstIndex : int, secIndex : int):
	var copyOfFirst : InventoryItem = inventory[firstIndex]
	inventory[firstIndex] = inventory[secIndex]
	inventory[secIndex] = copyOfFirst

func addToinventory(item : InventoryItem) -> bool:
	var exist := false
	if item is CountableItem:
		for x in len(inventory):
			if inventory[x] != null:
				if inventory[x].name == item.name:
					inventory[x].quantity += item.quantity
					print(item.quantity)
					return true
	
	for x in len(inventory):
		if inventory[x] == null:
			inventory[x] = item.duplicate()
			return true
	
	return false
			
func getSelectedItemType() -> String:
	if inventory[selectedItemIndex] == null:
		return ""
	return inventory[selectedItemIndex].type

func getSelectedItem() -> InventoryItem:
	return inventory[selectedItemIndex]

func removeAmount(amount := 1, index := selectedItemIndex):
	inventory[index].quantity -= amount
	if inventory[index].quantity <= 0:
		inventory[index] = null
