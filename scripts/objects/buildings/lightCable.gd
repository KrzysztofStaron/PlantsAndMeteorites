extends Building

export var powered := false
export var powerCables : Array
export var generatorCable := false
export var level : int = -1
onready var tile : TileMap = get_parent()

func _ready():
	var pos := tile.world_to_map(position)
	tile.setCell(pos)

func _process(delta):
	if powered:
		tile.set_cellv(tile.world_to_map(position), 1)
	else:
		getPower()
		tile.set_cellv(tile.world_to_map(position), 0)

func getPower():
	var pos := tile.world_to_map(position)
	var cablesToFind : PoolVector2Array

	for offset in [Vector2(0, -1), Vector2(1, 0), Vector2(0, 1), Vector2(-1, 0)]:
		if tile.get_cellv(pos + offset) == 0:
			cablesToFind.append(pos + offset)
	
	for cable in tile.get_children():
		if cablesToFind.has(tile.world_to_map(cable.position)):
			if not cable.powered:
				pass
			elif cable.level > level:
				print("level")
			else:
				print("ahh")
				level = cable.level+1
				powered = true
