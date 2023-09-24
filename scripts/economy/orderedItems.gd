extends Panel

var inventory := [
	null,
	null,
	null,
	null,
	null,
	null,
	null,
	null
]

onready var gridContainer := $GridContainer

func order(item : InventoryItem):
	var exist := false
	if item is CountableItem:
		for x in len(inventory):
			if inventory[x] == null:
				pass
			elif inventory[x].name != item.name:
				pass
			else:
				inventory[x].quantity += item.quantity
				update()
				return
		
	
	for x in len(inventory):
		if inventory[x] == null:
			inventory[x] = item.duplicate()
			update()
			return
	
func update():
	for index in len(gridContainer.get_children()):
		gridContainer.get_children()[index].setItem(inventory[index])
