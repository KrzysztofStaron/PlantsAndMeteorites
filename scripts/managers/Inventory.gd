extends Node

onready var inventory := [
	# Quick
	null,
	preload("res://data/items/tools/drill.tres"),
	preload("res://data/items/tools/wateringCan.tres"),
	preload("res://data/items/tools/hoe.tres"),
	# Main
	null,
	null,
	preload("res://data/items/buildings/lightCable.tres"),
	preload("res://data/items/buildings/soil.tres"),
	null,
	null
]

var selectedItemIndex := 0

func countShit(shitName : String) -> int:
	var shitCount := 0 
	for item in inventory:
		if item == null:
			pass
		elif item.name == shitName:
			shitCount += item.quantity
			
	return shitCount
	
func hasItem(name : String, amount := 1) -> bool:
	for item in inventory:
		if item == null:
			pass
		elif item.name == name:
			if item.quantity >= amount:
				return true
	
	return false

func swap(firstIndex : int, secIndex : int):
	var copyOfFirst : InventoryItem = inventory[firstIndex]
	inventory[firstIndex] = inventory[secIndex]
	inventory[secIndex] = copyOfFirst

func addToinventory(item : InventoryItem, update := true) -> bool:
	var exist := false
	if item is CountableItem:
		for x in len(inventory):
			if inventory[x] == null:
				pass
			elif inventory[x].name != item.name:
				pass
			else:
				inventory[x].quantity += item.quantity
				if !update:
					pass
				elif x < 4:
					get_tree().get_root().get_node("main/UI/quickInventory/VContainer/slot"+str(x)).update()
				elif x >= 4:
					get_tree().get_root().get_node("main/UI/mainInventory/slots/slot"+str(x)).update()

				return true
	
	for x in len(inventory):
		if inventory[x] == null:
			inventory[x] = item.duplicate()
			if !update:
				pass
			elif x < 4:
				get_tree().get_root().get_node("main/UI/quickInventory/VContainer/slot"+str(x)).update()
			elif x >= 4:
				get_tree().get_root().get_node("main/UI/mainInventory/slots/slot"+str(x)).update()
			return true
	
	return false

func getSelectedItemType() -> String:
	if inventory[selectedItemIndex] == null:
		return ""
	return inventory[selectedItemIndex].type

func getSelectedItem() -> InventoryItem:
	return inventory[selectedItemIndex]

func removeAmountByName(itemName : String, amount := 1):
	for index in len(inventory):
		if inventory[index] == null:
			pass
		elif inventory[index].name == itemName:
			inventory[index].quantity -= amount
			if index < 4:
				if inventory[index].quantity <= 0:
					inventory[index] = null
				get_tree().get_root().get_node("main/UI/quickInventory/VContainer/slot"+str(index)).update()
			elif index >= 4:
				if inventory[index].quantity <= 0:
					inventory[index] = null
				get_tree().get_root().get_node("main/UI/mainInventory/slots/slot"+str(index)).update()

func removeAmount(amount := 1, index := selectedItemIndex):
	inventory[index].quantity -= amount
	if inventory[index].quantity <= 0:
		inventory[index] = null
