extends Building

func build():
	var tileMap : TileMap = get_parent()
	var tilePosition : Vector2 = tileMap.world_to_map(position)
	
	tileMap.set_cellv(tilePosition, 0)
	tileMap.update_bitmask_area(tilePosition)
