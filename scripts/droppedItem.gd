extends Area2D

export var item : Resource # InventoryItem

func _ready():
	$Sprite.texture = item.texture

func _on_DroppedItem_body_entered(body):
	if body is Player:
		if Inventory.addToinventory(item):
			queue_free()

