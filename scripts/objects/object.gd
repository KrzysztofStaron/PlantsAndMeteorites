extends Node2D

class_name object

export var objectName : String
export var drawOutline : bool

func outline(flag : bool):
	if !drawOutline:
		return
	if flag:
		$Sprite.material.set_shader_param("width", 0.5)
	else:
		$Sprite.material.set_shader_param("width", 0)

func interact_left():
	pass

func interact_right():
	pass
