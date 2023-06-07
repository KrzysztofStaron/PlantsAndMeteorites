extends Node

export var canPause = true
export var day : int
var player : Player

func _process(delta):
	for slot in range(1,len(Inventory.inventory)+1):
		if Input.is_action_just_pressed("slot"+str(slot)):
			Inventory.selectedItemIndex = slot - 1

	if Input.is_action_just_pressed("debug"):
		for tile in get_tree().get_nodes_in_group("crop_spot"):
			tile.nextDay()
			
	if Input.is_action_just_pressed("waterAll"):
		for tile in get_tree().get_nodes_in_group("crop_spot"):
			tile.watered  = true
