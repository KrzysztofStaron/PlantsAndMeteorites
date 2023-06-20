extends AnimatedSprite

export var tooFar : Color
export var avalible : Color
export var gridPath : NodePath
export var playerPath : NodePath

onready var grid := get_node(gridPath)
onready var player := get_node(playerPath)


func isInReach() -> bool:
	# Snaping to 0.5
	var playerTile : Vector2 = Vector2(
		((player.position.x / grid.cell_size.x / 0.5) as int) * 0.5 - 0.5, 
		((player.position.y / grid.cell_size.y / 0.5) as int) * 0.5
	)

	var mouseTile : Vector2 = grid.world_to_map(get_global_mouse_position())
	
	return abs(mouseTile.x - playerTile.x) <= 3 and abs(mouseTile.y - playerTile.y) <= 3

func posToTileCenter(input : Vector2) -> Vector2:
	return grid.map_to_world(grid.world_to_map(input)) + grid.cell_size / 2

func _physics_process(delta):
	if 	!isInReach():
		frame = 0
		playing = false
		modulate = tooFar
	else:
		playing = true
		modulate = avalible
		
		if Input.is_action_just_pressed("interact_left"):
			interact(false)
		elif Input.is_action_just_pressed("interact_right"):
			interact(true)
	position = posToTileCenter(get_global_mouse_position())

func interact(iType : bool):
	var type : String = Inventory.getSelectedItemType()
	var areas : Array = $detector.get_overlapping_areas()
	
	if len(areas) == 0:
		areas.append(null)
	
	for area in areas:
		var interacted : object

		if area is object:
			interacted = area
		elif area != null:
			interacted = area.get_parent()
		else:
			interacted = null
			
		if iType:
			interact_right(interacted, type)
		else:
			interact_left(interacted, type)

func interact_left(interacted : object, type : String):
	match type:
		"tool":
			match Inventory.getSelectedItem().toolType:
				Tool.WateringCan:
					var water : Node = preload("res://scenes/objects/buildings/soil/water.tscn").instance()
					water.position = position
					get_parent().add_child(water)
		"building":
			if interacted == null:
				build()

	if interacted != null:
		interacted.interact_left()

func interact_right(interacted : object, type : String):
	if interacted == null:
		pass
	
	if interacted != null:
		interacted.interact_right()

func build():
	# Using GameManager.canPuse in not safe way
	if !GameManager.canPause:
		return
	var building : Node = Inventory.getSelectedItem().scene.instance()
	building.position = position + Vector2(Inventory.getSelectedItem().offset, Inventory.getSelectedItem().offset)
	get_node(building.path).add_child(building)
	building.startBuilding(Inventory.getSelectedItem().buildingTime)
	Inventory.removeAmount()


func _on_detector_area_entered(area):
	if area.get_parent().has_method("outline"):
		area.get_parent().outline(true)
	elif area.has_method("outline"):
		area.outline(true)


func _on_detector_area_exited(area):
	if area.get_parent().has_method("outline"):
		area.get_parent().outline(false)
	elif area.has_method("outline"):
		area.outline(false)
