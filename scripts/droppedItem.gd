extends Area2D

export var item : Resource # InventoryItem
export var pickable := false

func _ready():
	$Sprite.texture = item.texture

func _on_DroppedItem_body_entered(body):
	if body is Player and pickable:
		if Inventory.addToinventory(item):
			queue_free()

func _on_Timer_timeout():
	if len(get_overlapping_bodies()) != 0:
		if Inventory.addToinventory(item):
			queue_free()

	pickable = true
