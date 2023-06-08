extends TextureRect

export var procesing := false
export var makingTime := 6
var makingCounter := 0 
var used := false

func _on_craft_pressed():
	$hammer.show()
	$items.hide()
	$hammer.frame = 0
	$hammer.playing = true
	
	procesing = true

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
		procesing = false
		$hammer.frame = 9
		$hammer.playing = false
		$hammer.hide()
		$items.show()
		makingCounter = 0
		$slider/fill.get_material().set_shader_param("persent", 0.0)
