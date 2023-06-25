extends Node2D

class_name object

export var objectName : String
export var drawOutline : bool
var outlineEnabled := false
export var outlineWidth := 0.5

func outline(flag : bool):
	if !drawOutline:
		return
	if flag:
		$Sprite.material.set_shader_param("width", outlineWidth)
	else:
		$Sprite.material.set_shader_param("width", 0)

func interact_left():
	pass

func interact_right():
	pass
