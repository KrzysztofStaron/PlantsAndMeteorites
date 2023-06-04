extends TextureButton

var touch := false
var is_dragging := false

func _input(event):
	if is_dragging && event is InputEventMouseMotion:
		# Handle the drag movement here
		# Access the event's position with event.position
		print("Drag: ", name)
		pass
	if event is InputEventMouseButton and touch:
		if Input.is_mouse_button_pressed(BUTTON_LEFT):
			is_dragging = true
		else:
			is_dragging = false

func _on_quickSlot_mouse_entered():
	touch = true

func _on_quickSlot_mouse_exited():
	touch = false
