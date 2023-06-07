extends TextureButton

func _pressed():
	for child in get_parent().get_children():
		if child != self:
			child.pressed = false
			child.disabled = false
		else:
			child.disabled = true
