extends Node

onready var inventory := [
	null,
	preload("res://data/items/tools/drill.tres"),
	preload("res://data/items/tools/wateringCan.tres"),
	preload("res://data/items/tools/hoe.tres"),
]

var selectedItemIndex := 0

func countShit(shitName : String) -> int:
	var shitCount := 0 
	for item in inventory:
		if item.name == shitName:
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

func addToinventory(item : InventoryItem, update := false) -> bool:
	var exist := false
	if item is CountableItem:
		for x in len(inventory):
			if inventory[x] != null:
				if inventory[x].name == item.name:
					inventory[x].quantity += item.quantity
					if update:
						if inventory[x].quantity > 1:
							get_tree().get_root().get_node("main/UI/quickInventory/VContainer/slot"+str(x)+"/amount").text = str(inventory[x].quantity)
						else:
							get_tree().get_root().get_node("main/UI/quickInventory/VContainer/slot"+str(x)+"/amount").text = ""
				
					return true
	
	for x in len(inventory):
		if inventory[x] == null:
			inventory[x] = item.duplicate()
			if update:
				get_tree().get_root().get_node("main/UI/quickInventory/VContainer/slot"+str(x)+"/icon").texture = item.texture	
				if inventory[x].quantity > 1:
					get_tree().get_root().get_node("main/UI/quickInventory/VContainer/slot"+str(x)+"/amount").text = str(inventory[x].quantity)
				else:
					get_tree().get_root().get_node("main/UI/quickInventory/VContainer/slot"+str(x)+"/amount").text = ""
					
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
			get_tree().get_root().get_node("main/UI/quickInventory/VContainer/slot"+str(index)+"/amount").text = str(inventory[index].quantity)
			
			if inventory[index].quantity <= 0:
				get_tree().get_root().get_node("main/UI/quickInventory/VContainer/slot"+str(index)+"/icon").texture = null	
				get_tree().get_root().get_node("main/UI/quickInventory/VContainer/slot"+str(index)+"/amount").text = ""	
				inventory[index] = null

func removeAmount(amount := 1, index := selectedItemIndex):
	inventory[index].quantity -= amount
	if inventory[index].quantity <= 0:
		inventory[index] = null
