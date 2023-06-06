extends Area2D

export var item : Resource # InventoryItem

var spawnDate : int

func _ready():
	spawnDate = OS.get_unix_time()
	$Sprite.texture = item.texture

func _on_DroppedItem_body_entered(body):
	if body is Player:
		if Inventory.addToinventory(item):
			queue_free()

func _on_DroppedItem_area_entered(area):
	if area.item.name == item.name and area.spawnDate < spawnDate and position.distance_to(area.position) < 2:
		item.quantity += area.item.quantity
		print("free")
		area.queue_free()
