extends Building

export var powered := false

onready var tile : TileMap = get_parent()

func _ready():
	var pos := tile.world_to_map(position)
	tile.setCell(pos)

func update():
	if powered:
		powerNerby()
		tile.set_cellv(tile.world_to_map(position), 1)
	else:
		tile.set_cellv(tile.world_to_map(position), 0)

func powerNerby():
	if not powered:
		return
	
	var pos := tile.world_to_map(position)
	var cablesToFind : PoolVector2Array

	for offset in [Vector2(0, -1), Vector2(1, 0), Vector2(0, 1), Vector2(-1, 0)]:
		if tile.get_cellv(pos + offset) == 0:
			print("powered: " + str(offset))
			cablesToFind.append(pos + offset)
	
	for cable in tile.get_children():
		if cable.powered:
			continue
		elif cablesToFind.has(tile.world_to_map(cable.position)):
			cable.powered = true
			cable.update()
