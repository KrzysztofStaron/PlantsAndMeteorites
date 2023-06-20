extends TextureRect

var item : InventoryItem

func update():
	texture = item.texture

func _process(delta):
	rect_position = get_global_mouse_position()
