extends TileMap

var positions : PoolVector2Array

enum {TOP_LEFT, TOP, TOP_RIGHT, LEFT, RIGHT, BOTTOM_LEFT, BOTTOM, BOTTOM_RIGHT}
const offsets := [
	Vector2(-1, -1), Vector2(0, -1), Vector2(1, -1),
	Vector2(-1, 0), Vector2(1, 0),
	Vector2(-1, 1), Vector2(0, 1), Vector2(1, 1)
]

var borderPositions : PoolVector2Array

func water(poss : Vector2):
	set_cellv(world_to_map(poss), 41) 

func getNeighborEmptyTiles(pos : Vector2):
	borderPositions.empty()
	for offset in offsets:
		if !positions.has(pos+offset) and !borderPositions.has(pos+offset):
			borderPositions.append(pos+offset)
	
	
func updateTexture(soil : Vector2, removed := false):
	if !removed:
		set_cellv(world_to_map(soil), 46)
		positions.append(world_to_map(soil))
		getNeighborEmptyTiles(world_to_map(soil))
	else:
		positions.remove(positions.find(world_to_map(soil)))
		getNeighborEmptyTiles(world_to_map(soil))
		borderPositions.append(world_to_map(soil))
		set_cellv(world_to_map(soil), -1)
		
		for offset in 8:
			if !touch(world_to_map(soil), offset):
				set_cellv(world_to_map(soil) + offsets[offset], -1)

	
	var tiles := [
		[BOTTOM_RIGHT],
		[BOTTOM],
		[BOTTOM_LEFT],
		[RIGHT],
		[LEFT],
		[TOP_RIGHT],
		[TOP],
		[TOP_LEFT],
		
		[LEFT, TOP],
		[RIGHT, TOP],
		[LEFT, BOTTOM],
		[RIGHT, BOTTOM],
		
		[TOP, LEFT, RIGHT],
		[TOP, RIGHT, BOTTOM],
		[TOP, LEFT, BOTTOM],
		[LEFT, RIGHT, BOTTOM],
			
		[LEFT, RIGHT],
		[TOP, BOTTOM],
			
		[BOTTOM_LEFT, BOTTOM_RIGHT],
		[TOP_LEFT, BOTTOM_LEFT],
		[TOP_LEFT, TOP_RIGHT],
		[TOP_RIGHT, BOTTOM_RIGHT],
		
		[BOTTOM, LEFT, RIGHT, TOP],
		
		[TOP_LEFT, BOTTOM],
		[TOP_RIGHT, LEFT],
		[BOTTOM_LEFT, RIGHT],
		[BOTTOM_RIGHT, TOP],
		
		[TOP_RIGHT, BOTTOM],
		[BOTTOM_RIGHT, LEFT],
		[TOP_LEFT, RIGHT],
		[BOTTOM_LEFT, TOP],
		
		[TOP_LEFT, TOP_RIGHT, BOTTOM_LEFT, BOTTOM_RIGHT],
		
		[TOP, BOTTOM_LEFT, BOTTOM_RIGHT],
		[RIGHT,TOP_LEFT, BOTTOM_LEFT],
		[BOTTOM ,TOP_LEFT, TOP_RIGHT],
		[LEFT ,TOP_RIGHT, BOTTOM_RIGHT],
		
		[TOP, LEFT, BOTTOM_RIGHT],
		[TOP, RIGHT, BOTTOM_LEFT],
		[BOTTOM, LEFT, TOP_RIGHT],
		[BOTTOM, RIGHT, TOP_LEFT],
		
		[BOTTOM_LEFT, TOP_LEFT, TOP_RIGHT],
		[BOTTOM_RIGHT, TOP_LEFT, TOP_RIGHT],
		[BOTTOM_LEFT, TOP_LEFT, BOTTOM_RIGHT],
		[BOTTOM_RIGHT, BOTTOM_LEFT, TOP_RIGHT],
		
		[TOP_LEFT, BOTTOM_RIGHT],
		[TOP_RIGHT, BOTTOM_LEFT],
	]
	var cant := [
		[BOTTOM, RIGHT],
		[TOP, LEFT, RIGHT],
		[BOTTOM, LEFT],
		[LEFT, TOP, BOTTOM],
		[RIGHT, TOP, BOTTOM],
		[TOP, RIGHT],
		[BOTTOM, LEFT, RIGHT],
		[TOP, LEFT],
		
		[],
		[],
		[],
		[],
		
		[BOTTOM],
		[LEFT],
		[RIGHT],
		[TOP],
		
		[TOP, BOTTOM],
		[LEFT, RIGHT],
		
		[BOTTOM, LEFT, RIGHT, TOP],
		[BOTTOM, LEFT, RIGHT, TOP],
		[BOTTOM, LEFT, RIGHT, TOP],
		[BOTTOM, LEFT, RIGHT, TOP],
		
		[],
	
		[LEFT, RIGHT, TOP],
		[BOTTOM, RIGHT, TOP],
		[BOTTOM, LEFT, TOP],
		[BOTTOM, LEFT, RIGHT],
			
		[LEFT, RIGHT, TOP],
		[BOTTOM, RIGHT, TOP],
		[BOTTOM, LEFT, TOP],
		[BOTTOM, LEFT, RIGHT],
			
		[BOTTOM, LEFT, RIGHT, TOP],
			
		[BOTTOM, LEFT, RIGHT],
		[BOTTOM, LEFT, TOP],
		[LEFT, RIGHT, TOP],
		[BOTTOM, RIGHT, TOP],
			
		[BOTTOM, RIGHT],
		[LEFT, BOTTOM],
		[TOP, RIGHT],
		[LEFT, TOP],
			
		[BOTTOM, LEFT, RIGHT, TOP, BOTTOM_LEFT],
		[BOTTOM, LEFT, RIGHT, TOP, BOTTOM_RIGHT],
		[BOTTOM, LEFT, RIGHT, TOP, TOP_RIGHT],
		[BOTTOM, LEFT, RIGHT, TOP, TOP_LEFT],
			
		[BOTTOM, LEFT, RIGHT, TOP, TOP_RIGHT, BOTTOM_LEFT],
		[BOTTOM, LEFT, RIGHT, TOP, TOP_LEFT, BOTTOM_RIGHT],
	]

	for border in borderPositions:
		if positions.has(border):
			continue

		var index := 0

		# determine what tile to put on "border" position
		for tile in tiles:
			var trueConditions = 0 
			for offset in 8:
				if touch(border, offset):
					if cant[index].has(offset):
						trueConditions = -1
						break
					elif tile.has(offset):
						trueConditions += 1
						
			if trueConditions == tile.size():
				set_cellv(border, index)
	
			index += 1


func touch(pos : Vector2, index : int) -> bool:
	return positions.has(pos + offsets[index])
