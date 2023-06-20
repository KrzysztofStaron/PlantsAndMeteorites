extends TextureRect

export var procesing := false
export var makingTime := 6
var makingCounter := 0
var used := false

var selected : Resource
func _on_craft_pressed():
	for item in $items.get_children():
		if item.pressed:
			selected = item.recipe.item.duplicate()
			makingTime = item.recipe.time * $amountSlider.value
	
			var failed := false
			for i in len(item.recipe.require):
				if not Inventory.hasItem(item.recipe.require[i].name, item.recipe.amounts[i]):
					failed = true
				
			
			if !failed:
				for i in len(item.recipe.require):
					Inventory.removeAmountByName(item.recipe.require[i].name, item.recipe.amounts[i] * $amountSlider.value)
				
				$craft.hide()
				$hammer.show()
				$require.hide()
				$hammer.frame = 0
				$hammer.playing = true
				$amountSlider.hide()
				procesing = true
	
	for child in $items.get_children():
		child.pressed = false

func _process(delta):
	if Input.is_action_just_pressed("pause"):
		$back.hide()
		$require.hide()
		$amountSlider.hide()
		$items.show()
		for child in $items.get_children():
			child.pressed = false
		procesing = true
		GameManager.canPause = true
		get_parent().hide()

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
		var oldSelected := selected.duplicate()
		oldSelected.quantity = $amountSlider.value
		if $"../addictionalSlot/buildingSlot".item == null:
			pass
		if $"../addictionalSlot/buildingSlot".item.name == oldSelected.name:
			oldSelected.quantity += $"../addictionalSlot/buildingSlot".item.quantity
		
		$"../addictionalSlot/buildingSlot".setItem(oldSelected)
		
		procesing = false
		$hammer.frame = 9
		$hammer.playing = false
		$hammer.hide()
		$items.show()
		$amountSlider.hide()
		$amountSlider/number.text = ""
		makingCounter = 0
		$slider/fill.get_material().set_shader_param("persent", 0.0)


func _on_amountSlider_value_changed(value):
	$amountSlider/number.text = str(value)
	for require in len($require.get_children()):
		if not $require.get_children()[require].visible:
			break
		else:
			for itemIndex in len($items.get_children()):
				var item : Node = $items.get_children()[itemIndex]
				if item.pressed:
					$require.get_children()[require].get_node("amount").text = str(item.recipe.amounts[require] * value)


func _on_back_pressed():
	$items.show()
	$require.hide()
	$back.hide()
	$craft.hide()
	$amountSlider.hide()
	
	for child in $items.get_children():
		child.pressed = false
