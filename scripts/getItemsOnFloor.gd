extends Node

func getData() -> Array:
	var data := []
	for child in get_children():
		data.append([child.item, child.position])
	
	return data
