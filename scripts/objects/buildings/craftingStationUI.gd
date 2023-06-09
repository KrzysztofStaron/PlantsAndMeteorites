extends TextureRect

export var procesing := false
export var makingTime := 6
var makingCounter := 0
var used := false

var selected : Resource
var stationPos : Vector2

func _on_craft_pressed():
	for item in $items.get_children():
		if item.pressed:
			selected = item.recipe.item
			makingTime = item.recipe.time
	
			var failed := false
			for i in len(item.recipe.require):
				if not Inventory.hasItem(item.recipe.require[i].name, item.recipe.amounts[i]):
					failed = true
			
			if !failed:
				for i in len(item.recipe.require):
					Inventory.removeAmountByName(item.recipe.require[i].name, item.recipe.amounts[i])
				
				$craft.hide()
				$hammer.show()
				$require.hide()
				$hammer.frame = 0
				$hammer.playing = true
				
				procesing = true
	
	for child in $items.get_children():
		child.pressed = false

func _process(delta):
	if Input.is_action_just_pressed("pause"):
		GameManager.canPause = true
		hide()
		get_tree().paused = false

	if procesing:
		if $hammer.frame == 3:
			if !used:
				used = true
				print(makingCounter)
				var percent := 1.0/makingTime
				var tween : Tween = get_node("processTween")
				tween.interpolate_property($slider/fill.get_material(), "shader_param/persent", percent * makingCounter, percent * (makingCounter+1), 0.3, Tween.TRANS_EXPO, Tween.EASE_OUT)
				tween.start()
				makingCounter += 1
		else:
			used = false

		if makingCounter == makingTime:
			procesing = false


func _on_hammer_animation_finished():
	if makingCounter == makingTime:
		if not Inventory.addToinventory(selected, true):
			var dropScene : Node = preload("res://scenes/droppedItem.tscn").instance()
			dropScene.position = stationPos
			dropScene.item = selected.duplicate()
			get_tree().get_root().get_node("main").add_child(dropScene)
		
		procesing = false
		$hammer.frame = 9
		$hammer.playing = false
		$hammer.hide()
		$items.show()
		makingCounter = 0
		$slider/fill.get_material().set_shader_param("persent", 0.0)
