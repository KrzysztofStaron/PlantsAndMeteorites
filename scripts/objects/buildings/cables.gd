extends TileMap

func setCell(pos : Vector2):
	set_cellv(pos, 0)

	for cable in get_children():
		cable.update()

func _process(delta):
	if Input.is_action_just_pressed("rotate"):
		get_children()[0].powered = true
		get_children()[0].update()
