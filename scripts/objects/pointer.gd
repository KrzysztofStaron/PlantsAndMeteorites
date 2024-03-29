extends AnimatedSprite

export var tooFar : Color
export var avalible : Color
export var gridPath : NodePath
export var playerPath : NodePath

onready var grid := get_node(gridPath)
onready var player := get_node(playerPath)

var oldPos : Vector2

var rotationIndex : int

func isInReach() -> bool:
	# Snaping to 0.5
	var playerTile : Vector2 = Vector2(
		((player.position.x / grid.cell_size.x / 0.5) as int) * 0.5 - 0.5, 
		((player.position.y / grid.cell_size.y / 0.5) as int) * 0.5
	)

	var mouseTile : Vector2 = grid.world_to_map(get_global_mouse_position())
	
	return abs(mouseTile.x - playerTile.x) <= 3.5 and abs(mouseTile.y - playerTile.y) <= 3.5

func posToTileCenter(input : Vector2) -> Vector2:
	return grid.map_to_world(grid.world_to_map(input)) + grid.cell_size / 2

func setRotation(building: Node, change := true):
	if Inventory.getSelectedItem() == null or Inventory.getSelectedItem().type != "building":
		return
	
	var rotationType : int = Inventory.getSelectedItem().rotation
	
	match rotationType:
		0:
			rotationIndex = 0
			building.rotation_degrees = 0
			building.scale = Vector2(1, 1)
		1:
			if change:
				rotationIndex += 1
				if rotationIndex >= 2:
					rotationIndex = 0
			
			building.rotation_degrees = rotationIndex * 90
			building.scale = Vector2(1, 1)
		2:
			if change:
				rotationIndex += 1
				if rotationIndex == 3:
					rotationIndex = 0
			
			if rotationIndex > 2:
				rotationIndex = 2
				
			match rotationIndex:
				0:
					building.rotation_degrees = 0
					building.scale.y = 1
					building.scale.x = 1
				1:
					building.rotation_degrees = 90
					building.scale.x = 1
				2:
					building.rotation_degrees = 90
					building.scale.y = -1
					
		3:
			if change:
				rotationIndex += 1
				if rotationIndex == 4:
					rotationIndex = 0
				
			match rotationIndex:
				0:
					building.rotation_degrees = 0
					building.scale.y = 1
					building.scale.x = 1
				1:
					building.rotation_degrees = 90
					building.scale.y = 1
					building.scale.x = 1
				2:
					building.rotation_degrees = 180
					building.scale.x = 1
					building.scale.y = 1
				3:
					building.rotation_degrees = 270
					building.scale.y = 1
					building.scale.x = 1
	
func _physics_process(delta):
	if Input.is_action_just_pressed("rotate"):
		setRotation($showcase)
		setRotation($detector, false)
		setRotation($floorDetector, false)
		setRotation($bodyDetector, false)
		setRotation($playerDetector, false)
		
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
			
	if oldPos != position:
		if !isInReach():
			pass
		elif Input.is_action_just_pressed("interact_left") or Input.is_action_just_pressed("interact_right"):
			pass
		elif Input.is_action_pressed("interact_left"):
			interact(false)
		elif Input.is_action_pressed("interact_right"):
			interact(true)
		
		oldPos = position

	position = posToTileCenter(get_global_mouse_position())

func interact(iType : bool):
	var type : String = Inventory.getSelectedItemType()
	var areas : Array = $detector.get_overlapping_areas()
	var floors : Array = $floorDetector.get_overlapping_areas()
	
	if len(areas) == 0:
		areas.append(null)
	if len(floors) == 0:
		floors.append(null)
	
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
	
	for floorObj in floors:
		var interacted : object
		
		if floorObj is object:
			interacted = floorObj
		elif floorObj != null:
			interacted = floorObj.get_parent()
		else:
			interacted = null
		
		if !iType:
			interact_floor_left(floorObj, type)

func interact_floor_left(interacted : object, type : String):
	match type:
		"building":
			if Inventory.getSelectedItem() != null:
				if interacted == null and Inventory.getSelectedItem().isFloor:
					build()

	if interacted != null:
		interacted.interact_left()

func interact_left(interacted : object, type : String):
	match type:
		"tool":
			match Inventory.getSelectedItem().toolType:
				Tool.WateringCan:
					var water : Node = preload("res://scenes/objects/buildings/soil/water.tscn").instance()
					water.position = position
					get_parent().add_child(water)
		"building":
			if interacted == null and !Inventory.getSelectedItem().isFloor:
				build()

	if interacted != null:
		interacted.interact_left()

func interact_right(interacted : object, type : String):
	if interacted == null:
		pass
	
	if interacted != null:
		interacted.interact_right()

func build():
	if len($playerDetector.get_overlapping_bodies()) != 0 and !Inventory.getSelectedItem().isFloor:
		return
	
	# Using GameManager.canPuse in not safe way
	if !GameManager.canPause:
		return
		
	var building : Node = Inventory.getSelectedItem().scene.instance()
	building.position = position
	setRotation(building, false)
	setRotation($detector, false)
	setRotation($floorDetector, false)
	setRotation($bodyDetector, false)
	setRotation($playerDetector, false)
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


func _on_quickInventory_ItemChanged():
	print("changed")
	if Inventory.getSelectedItemType() == "building":
		play("no")
		var showcase := $showcase
		
		setRotation(showcase, Input.is_action_just_pressed("rotate"))
		
		
		
		showcase.show()
		showcase.offset = Inventory.getSelectedItem().showcaseOffset
		showcase.texture = Inventory.getSelectedItem().showcaseTexture
		
		var itemScene : Building = Inventory.getSelectedItem().scene.instance()
		var collisionNode : Node = itemScene.get_node_or_null(itemScene.collisionPath)
		if collisionNode != null:
			collisionNode = collisionNode.duplicate()
		itemScene.queue_free()
		
		removeCollisions($detector)
		removeCollisions($floorDetector)
		removeCollisions($bodyDetector)
		removeCollisions($playerDetector)
		
		if collisionNode != null:
			$detector.add_child(collisionNode.duplicate())
			$floorDetector.add_child(collisionNode.duplicate())
			$bodyDetector.add_child(collisionNode.duplicate())
			$playerDetector.add_child(collisionNode.duplicate())
			
			$detector/CollisionShape2D.disabled = true
			$floorDetector/CollisionShape2D.disabled = true
			$bodyDetector/CollisionShape2D.disabled = true
			$playerDetector/CollisionShape2D.disabled = true
		else:
			$detector/CollisionShape2D.disabled = false
			$floorDetector/CollisionShape2D.disabled = false
			$bodyDetector/CollisionShape2D.disabled = false
			$playerDetector/CollisionShape2D.disabled = false
	else:
		play("default")
		$showcase.hide()
		
		$detector/CollisionShape2D.disabled = false
		$floorDetector/CollisionShape2D.disabled = false
		$bodyDetector/CollisionShape2D.disabled = false
		$playerDetector/CollisionShape2D.disabled = false

		removeCollisions($detector)
		removeCollisions($floorDetector)
		removeCollisions($bodyDetector)
		removeCollisions($playerDetector)

func removeCollisions(from : Node) -> void:
	for x in len(from.get_children()):
		if x == 0:
			pass
		else:
			from.get_children()[x].queue_free()
