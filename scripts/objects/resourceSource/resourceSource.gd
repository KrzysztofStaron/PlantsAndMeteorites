extends object
class_name resourceSource

export var mainDrop : Resource
export var durability : int
export var dropRadius : float = 8
enum {Drill = 1}
export(int, FLAGS, "Drill") var flags = 0

func hasFlag(flag):
	return bool(flags & flag)

func mine():
	var particle := preload("res://scenes/objects/pebbles/particle.tscn").instance()	
	particle.position = position
	
	get_parent().add_child(particle)

	durability -= 1
	if durability <= 0:
		for item in mainDrop.amount:
			var dropScene : Node = preload("res://scenes/droppedItem.tscn").instance()
			dropScene.position = position + Vector2(int(rand_range(-dropRadius, dropRadius)), int(rand_range(-dropRadius, dropRadius)))
			randomize()
			dropScene.item = mainDrop.item
			get_node("/root/main/items").add_child(dropScene).add_child(dropScene)
			
		queue_free()

func interact_left():
	var item = Inventory.getSelectedItem()
	if item == null:
		pass
	elif item.type != "tool":
		pass
	else:
		match item.toolType:
			item.Drill:
				if hasFlag(Drill):
					mine()
