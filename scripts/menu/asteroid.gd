extends RigidBody2D

func _input(event):
	if event is InputEventMouseButton:
		if event.is_action_pressed("interact_left") and isTouchingMouse():
#			 destroy()
			pass

func isTouchingMouse() -> bool:
	return get_global_mouse_position().distance_to(global_position) < 5

func destroy():
	get_node("../../").updateAsteroids()
	var par := preload("res://scenes/screens/particle.tscn").instance()
	get_node("../../").add_child(par)
	par.position = position
	par.scale = Vector2(mass / 5.0, mass / 5.0)
	queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	print("left")
	get_node("../../").updateAsteroids()
	queue_free()

func hasObjectLeftScreen(object_position: Vector2) -> bool:
	var screenWidth = 320
	var screenHeight = 180

	if object_position.x < -5 or object_position.x > screenWidth + 5 or object_position.y < -5 or object_position.y > screenHeight + 5:
		return true

	return false
	
func _on_Timer_timeout():
	if hasObjectLeftScreen(position):
		get_node("../../").updateAsteroids()
		queue_free()


func _on_Timer2_timeout():
	$Timer.start(0.2)
